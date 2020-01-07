package document

import (
	"context"
	"log"

	v1 "github.com/winwisely99/main/packages/document/server/api/v1"

	db "github.com/winwisely99/main/packages/document/server/repository/memory"

	"net"
	"testing"
	"time"

	"github.com/golang/protobuf/ptypes"
	"google.golang.org/grpc"
	"google.golang.org/grpc/test/bufconn"
)

const buffSize = 1024 * 1024

var lis *bufconn.Listener

var createdTimeStamp, _ = ptypes.TimestampProto(time.Now())
var updatedTimeStamp, _ = ptypes.TimestampProto(time.Now().Add(time.Second * 1000))

// server documents
var serverDocuments = map[string][]*v1.Document{
	"1": []*v1.Document{
		{Id: "1", LocalId: "1", Data: "data file", Uid: "1", CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp},
		{Id: "2", LocalId: "2", Data: "data file", Uid: "1", CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp},
	},
}

// local documents
var localDocuments = []*v1.Document{
	// document is sync
	{Id: "1", LocalId: "1", Data: "data file", Uid: "1", Type: v1.SyncType_NOTHING, CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp},
	// documment is outdated
	{Id: "2", LocalId: "2", Data: "data file", Uid: "1", Type: v1.SyncType_MERGE, CreatedAt: createdTimeStamp, LastUpdate: updatedTimeStamp},
	// document not exists
	{Id: "3", LocalId: "3", Data: "data file", Uid: "1", Type: v1.SyncType_CREATE, CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp},
}

var m = &db.Memory{Documents: serverDocuments}

// document server to test with
var dTest = &documentServiceServer{
	repository: m,
}

func init() {
	lis = bufconn.Listen(buffSize)
	s := grpc.NewServer()
	v1.RegisterDocumentServiceServer(s, dTest)
	go func() {
		if err := s.Serve(lis); err != nil {
			log.Fatal(err)
		}
	}()
}

// buffDialer
func buffDialer(string, time.Duration) (net.Conn, error) {
	return lis.Dial()
}

// Test to create a new document
func TestNewDocument(t *testing.T) {

	document := &v1.Document{
		LocalId: "23",
		Data:    "data file",
		Uid:     "1",
	}

	resp, err := dTest.New(context.Background(), document)

	if err != nil {
		t.Error(err)
	} else {
		if resp.LocalId != document.GetLocalId() {
			t.Error("Error local id does not match")
		}
	}
}

// Test to update a document
func TestUpdateDocument(t *testing.T) {

	document := &v1.Document{Id: "1", LocalId: "1", Data: "data file", Uid: "1", CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp}
	resp, err := dTest.Update(context.Background(), document)

	if err != nil {
		t.Error(err)
	} else {
		if resp.GetConflict() != v1.ConflictStatus_SYNC {
			t.Errorf("Error conflict should be %v but got %v", resp.GetConflict(), v1.ConflictStatus_SYNC)
		}
	}
}

// Test to delete a document
func TestDeleteDocument(t *testing.T) {

	document := &v1.Document{Id: "1", LocalId: "1", Data: "data file", Uid: "1", CreatedAt: createdTimeStamp, LastUpdate: createdTimeStamp}

	resp, err := dTest.Delete(context.Background(), document)

	if err != nil {
		t.Error(err)
	} else {
		if resp.GetConflict() != v1.ConflictStatus_SYNC {
			t.Errorf("Error conflict should be %v but got %v", resp.GetConflict(), v1.ConflictStatus_SYNC)
		}
	}
}

// Test check if local files are sync
func TestCheckIfDocumentsSync(t *testing.T) {

	checks := []*v1.CheckSync{}
	userID := localDocuments[0].GetUid()

	for _, lDoc := range localDocuments {
		checks = append(checks, &v1.CheckSync{
			Id:         lDoc.GetId(),
			LocalId:    lDoc.GetLocalId(),
			LastUpdate: lDoc.GetLastUpdate(),
		})
	}

	reqCheck := &v1.RequestCheckSync{
		Uid:    userID,
		Checks: checks,
	}

	conn, err := grpc.DialContext(context.Background(), "bufnet", grpc.WithDialer(buffDialer), grpc.WithInsecure())

	if err != nil {
		t.Fatal(err)
	}

	defer conn.Close()

	client := v1.NewDocumentServiceClient(conn)

	stream, err := client.CheckIfDocumentsSync(context.Background(), reqCheck)

	if err != nil {
		t.Fatal(err)
	}

	received := 0
	for {
		c, _ := stream.Recv()

		if c != nil {

			switch c.GetLocalId() {
			case localDocuments[0].GetLocalId():
				if c.GetConflict() != v1.ConflictStatus_SYNC {
					t.Errorf("Error conflict should be %v but got %v\n", c.GetConflict(), v1.ConflictStatus_SYNC)
					break
				}

			case localDocuments[1].GetLocalId():
				if c.GetConflict() != v1.ConflictStatus_OUTDATED {
					t.Errorf("Error conflict should be %v but got %v\n", c.GetConflict(), v1.ConflictStatus_SYNC)
					break
				}

			case localDocuments[2].GetLocalId():
				if c.GetConflict() != v1.ConflictStatus_NEW {
					t.Errorf("Error conflict should be %v but got %v\n", c.GetConflict(), v1.ConflictStatus_SYNC)
					break
				}
			}

			received++

			if received >= len(localDocuments) {
				return
			}
		}

	}
}

// Test sync local documents
func TestSyncDocuments(t *testing.T) {

	docSended := 0
	conn, err := grpc.DialContext(context.Background(), "bufnet", grpc.WithDialer(buffDialer), grpc.WithInsecure())

	if err != nil {
		t.Fatal(err)
	}

	defer conn.Close()

	client := v1.NewDocumentServiceClient(conn)

	stream, err := client.SyncDocuments(context.Background())

	if err != nil {
		t.Fatal(err)
	}

	for _, lDoc := range localDocuments {
		if lDoc.GetType() != v1.SyncType_NOTHING {
			docSended++
			stream.Send(lDoc)
		}
	}

	for {
		responseCheck, _ := stream.Recv()

		if responseCheck != nil {

			if responseCheck.GetConflict() != v1.ConflictStatus_SYNC {
				t.Errorf("Error sync should be %v but got %v", v1.ConflictStatus_SYNC, responseCheck.GetConflict())
				return
			}

			docSended--
			if docSended == 0 {
				break
			}
		}
	}

	// Check if server documents len areequal to local documents
	docs, _ := dTest.repository.List(context.Background(), "1")

	if len(docs) != len(localDocuments) {
		t.Errorf("Error documents in servers should be %d but got %d", len(localDocuments), len(docs))
	}
}
