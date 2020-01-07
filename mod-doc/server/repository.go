package document

import (
	"context"

	v1 "github.com/winwisely99/main/packages/document/server/api/v1"
)

// Repository interface
type Repository interface {
	Close()
	New(ctx context.Context, userID string, documents *v1.Document) (*v1.Document, error)
	Update(ctx context.Context, userID string, document *v1.Document) (*v1.Document, error)
	Merge(ctx context.Context, userID string, document *v1.Document) (*v1.Document, error)
	List(ctx context.Context, userID string) ([]*v1.Document, error)
	Delete(ctx context.Context, userID string, documentID string) error
	Sync(ctx context.Context, userID string, documents *v1.Document) (string, error)
}
