package utils

import (
	"encoding/csv"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"time"

	"github.com/pkg/errors"
)

// do not edit this mapping
var mimeMap = map[string]string{
	"video/3gpp":         "3gp",
	"video/x-ms-asf":     "asf",
	"video/x-msvideo":    "avi",
	"image/bmp":          "bmp",
	"application/msword": "doc",
	"application/vnd.openxmlformats-officedocument.wordprocessingml.document": "docx",
	"application/vnd.ms-excel": "xls",
	"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": "xlsx",
	"image/gif":                          "gif",
	"application/x-gtar":                 "gtar",
	"application/x-gzip":                 "gz",
	"text/html":                          "html",
	"image/jpeg":                         "jpg",
	"audio/x-mpegurl":                    "m3u",
	"audio/mp4a-latm":                    "m4a",
	"video/vnd.mpegurl":                  "m4u",
	"video/x-m4v":                        "m4v",
	"video/quicktime":                    "mov",
	"audio/x-mpeg":                       "mp3",
	"video/mp4":                          "mp4",
	"application/vnd.mpohun.certificate": "mpc",
	"video/mpeg":                         "mpeg",
	"audio/mpeg":                         "mpga",
	"application/vnd.ms-outlook":         "msg",
	"audio/ogg":                          "ogg",
	"application/pdf":                    "pdf",
	"image/png":                          "png",
	"application/vnd.ms-powerpoint":      "ppt",
	"application/vnd.openxmlformats-officedocument.presentationml.presentation": "pptx",
	"audio/x-pn-realaudio":         "rmvb",
	"application/rtf":              "rtf",
	"application/x-tar":            "tar",
	"application/x-compressed":     "tgz",
	"text/plain":                   "txt",
	"audio/x-wav":                  "wav",
	"audio/x-ms-wma":               "wma",
	"audio/x-ms-wmv":               "wmv",
	"application/x-compress":       "z",
	"application/x-zip-compressed": "zip",
	"*/*":                          "",
}

// GetAbsoluteFilePath get abs path
func GetAbsoluteFilePath(relFilePath string, sheet string) (result string, err error) {
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(sheet, " : ", err)
	}
	absFilePath := filepath.Join(dir, relFilePath)

	return absFilePath, nil

}

// Download exported
func Download(url string, filename string, timeout int64, sheet string, checkCSV bool) (err error) {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	//log.Println(sheet, " : ", "Downloading", url, "...")
	client := http.Client{
		Timeout: time.Duration(timeout * int64(time.Second)),
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Println(sheet, " : ", "Cannot download file from the given url", err)
		return err
	}

	if resp.StatusCode != 200 {
		log.Printf("%v : Response from the URL was %d, but expecting 200", sheet, resp.StatusCode)
		return errors.New("Response returned with a status different from 200")
	}
	if checkCSV {
		if resp.Header["Content-Type"][0] != "text/csv" && resp.Header["Content-Type"][0] != "text/csv; charset=utf-8" {
			log.Printf(sheet, " : ", "The file downloaded has content type %s, expected text/csv", resp.Header["Content-Type"])
			return errors.New("Downloaded file didn't contain the expected content-type: text/csv")
		}
	}
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Println(sheet, " : ", "Cannot read Body of Response", err)
		return errors.New("Cannot read Body of Response")
	}

	if !checkCSV {
		filename = filename + "." + mimeMap[resp.Header["Content-Type"][0]]
		log.Println(sheet, " : ", filename)
	}

	CreateFile(filename)

	err = ioutil.WriteFile(filename, b, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot write to file", err)
		return errors.New("Cannot write to file")
	}

	// log.Println(sheet, " : ", "Doc downloaded in ", filename)

	return nil
}

// CreateFile create file
func CreateFile(path string) {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		// create dir (or 0755)
		dir := filepath.Dir(path)
		err = os.MkdirAll(dir, 0700)
		if isError(err) {
			return
		}
		// Create your file
		var file, err = os.Create(path)
		if isError(err) {
			return
		}
		defer file.Close()
	}

	//log.Println("==> done creating file", path)
}

func isError(err error) bool {
	if err != nil {
		log.Println(err.Error())
	}

	return err != nil
}

// DownloadURL Download the file in the url
func DownloadURL(cell string, sheet string) string {
	u, err := url.Parse(cell)
	if err != nil {
		return "error downloading"
		//panic(err)
	}
	m, _ := url.ParseQuery(u.RawQuery)
	if m.Get("id") != "" {
		link := fmt.Sprintf("https://drive.google.com/uc?authuser=0&id=%v&export=download", m["id"][0])
		AbsFilePath, err := GetAbsoluteFilePath("./outputs/datadump/json/"+sheet+"/"+m["id"][0], sheet)
		err = Download(link, AbsFilePath, 5000, sheet, false)
		if err != nil {
			log.Println(sheet, " : ", err)
			return "error downloading"
		}
		return "assets/mockData/" + sheet + "/" + m["id"][0] + ".png"
	}
	return "invalid link"
}

// MkDirIfNotExists create direcory if not exists
func MkDirIfNotExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0777)
		if err != nil {
			fmt.Println("Cannot create directory:", err)
			return err
		}
	}
	return nil
}

// OpenCSVFile open csv file
func OpenCSVFile(csvFilePath string) ([][]string, error) {
	// open csv file
	csvFile, err := os.Open(csvFilePath)
	defer csvFile.Close()

	if err != nil {
		return nil, errors.Wrap(err, "Cannot open file:"+csvFilePath)
	}

	// get csv file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()

	if err != nil {
		return nil, errors.New("Cannot read file:" + csvFilePath)
	}
	return csvFileContent, nil
}
