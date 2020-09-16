package services

import (
	"bytes"
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/emirpasic/gods/maps/linkedhashmap"
	"github.com/getcouragenow/core-runtime/tool/googlesheet/services/config"
	"github.com/pkg/errors"

	"github.com/tidwall/pretty"
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

	createFile(filename)

	err = ioutil.WriteFile(filename, b, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot write to file", err)
		return errors.New("Cannot write to file")
	}

	// log.Println(sheet, " : ", "Doc downloaded in ", filename)

	return nil
}

// Download the file in the url
func downloadURL(cell string, sheet string) string {
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

// CleanTranslation struct used to clean hugo translations files
type CleanTranslation struct {
	Error *string `json:"error"`
	Fixe  *string `json:"fixe"`
}

// TomlFormat struct
type TomlFormat struct {
	Key    string
	Values [][]string
}

// TODO: Use the new error handling patterns

// WriteDataDumpFiles exported
func WriteDataDumpFiles(csvFilePath string, jsonDirPath string, sheet string) error {
	csvFile, err := os.Open(csvFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, "Cannot open file:"+csvFilePath)

	}
	// get csf file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()
	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}
	keys := csvFileContent[0][0:]
	// walk content for each lang
	var data []map[string]string
	for rowIndex, row := range csvFileContent[1:][0:] {
		data = append(data, map[string]string{})
		for columnIndex, key := range keys {
			if strings.Contains(key, "_url") && strings.TrimSpace(row[columnIndex]) != "" {
				if strings.Contains(row[columnIndex], ",") {
					var paths []string
					urls := strings.Split(row[columnIndex], ",")
					for _, url := range urls {
						paths = append(paths, downloadURL(strings.TrimSpace(url), sheet))
					}
					data[rowIndex][key] = strings.Join(paths, ",")
				} else {
					data[rowIndex][key] = downloadURL(strings.TrimSpace(row[columnIndex]), sheet)
				}

			} else {
				data[rowIndex][key] = row[columnIndex]
			}

		}
	}
	FileName := sheet + ".json"

	FilePath := filepath.Join(jsonDirPath, FileName)

	AbsPath, err := filepath.Abs(FilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot get path specified: \""+AbsPath+"\"", err)
		return errors.New("Cannot get path specified:" + FilePath)
	}

	createFile(AbsPath)

	file, err := os.OpenFile(AbsPath, os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file: \""+AbsPath+"\"", err)
		return errors.Wrap(err, "Cannot open file: \""+AbsPath+"\"")
	}

	err = file.Truncate(0)
	if err != nil {
		return errors.New("Cannot truncate file:" + sheet)
	}
	encodedJSON, _ := json.Marshal(data)

	_, err = file.Write(formatJSON(encodedJSON))
	if err != nil {
		return errors.New("Cannot write to file:" + sheet)
	}
	err = file.Close()
	if err != nil {
		return errors.New("Cannot Close to file:" + sheet)
	}
	return nil
}

func arbFiles(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {
	for index, col := range csvFileContent[0][1:] {
		languages := linkedhashmap.New()
		// languages := map[string]interface{}{}
		cleanedData := ""
		fileName := getOutFileName(config.FileName, col)
		index++
		for _, row := range csvFileContent[1:] {
			err := mkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}
			cleanedData = cleanData(row[index], cleanTagsDir, cleanTagsFileName)

			m := linkedhashmap.New()
			m.Put("description", cleanKey(row[0]))
			m.Put("type", "text")
			m.Put("placeholders", "{}")

			languages.Put(cleanKey(row[0]), cleanedData)
			languages.Put("@"+cleanKey(row[0]), m)
		}
		data, err := jsonify(languages)
		data = pretty.Pretty(data)

		err = writeOutFile(string(data), config.OutDir+fileName+config.Extension)

		if err != nil {
			return err
		}
	}
	return nil
}

func jsonFiles(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	for index, col := range csvFileContent[0][1:] {
		languages := map[string]string{}
		cleanedData := ""
		fileName := getOutFileName(config.FileName, col)
		index++

		for _, row := range csvFileContent[1:] {
			err := mkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}
			cleanedData = cleanData(row[index], cleanTagsDir, cleanTagsFileName)
			languages[cleanKey(row[0])] = cleanedData
			// j := jsonMap{cleanKey(row[0]): cleanedData}
			// languages = append(languages, j)
		}
		data, err := json.MarshalIndent(languages, "", "  ")

		err = writeOutFile(string(data), config.OutDir+fileName+config.Extension)

		if err != nil {
			return err
		}
	}
	return nil
}

func tomlFiles(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	for index, col := range csvFileContent[0][1:] {

		cache := make(map[string]int)
		languages := []TomlFormat{}
		cleanedData := ""
		fileName := getOutFileName(config.FileName, col)
		index++

		for _, row := range csvFileContent[1:] {

			err := mkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}

			cleanedData = cleanData(row[index], cleanTagsDir, cleanTagsFileName)

			h := TomlFormat{}
			if strings.Contains(row[0], "(") && config.Extension == ".toml" {

				// Check if row contains multi values
				sp := strings.Split(row[0], "(")
				tr := strings.TrimRight(sp[1], ")")
				sp2 := strings.Split(tr, ".")

				// if there is already a object with the same key in cache
				// get index from cache and append to to values array
				if i, ok := cache[cleanKey(sp[0])]; ok {

					val := []string{sp2[1], cleanedData}
					languages[i].Values = append(languages[i].Values, val)
					continue
				}

				h = TomlFormat{Key: cleanKey(sp[0]), Values: [][]string{{sp2[1], cleanedData}}}

			} else {
				h = TomlFormat{Key: cleanKey(row[0]), Values: [][]string{{"other", cleanedData}}}
			}

			languages = append(languages, h)
			cache[h.Key] = len(languages) - 1
		}

		fileData := ""
		// populate hugo object

		if config.Extension == ".toml" {
			for _, item := range languages {

				fileData += "[" + item.Key + "]\n"
				for _, val := range item.Values {
					fileData += val[0] + " = \"" + val[1] + "\"\n"
				}
				fileData += "\n"

			}
		} else {

			return fmt.Errorf("'%s' extension not implemented", config.Extension)
		}

		err := writeOutFile(fileData, config.OutDir+fileName+config.Extension)

		if err != nil {
			return err
		}
	}
	return nil
}

func mergeCell(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	for index, col := range csvFileContent[0][1:] {
		index++
		for _, row := range csvFileContent[1:] {

			outDir := strings.ReplaceAll(config.OutDir, "XXX", col)
			err := mkDirIfNotExists(outDir)
			if err != nil {
				return err
			}

			outFile := row[0]
			if config.FileName != "" {
				outFile = strings.ReplaceAll(config.FileName, "XXX", col) + config.Extension
			}

			cleanedData := cleanData(row[index], cleanTagsDir, cleanTagsFileName)
			err = writeOutFile(cleanedData, outDir+outFile)

			if err != nil {
				return err
			}
		}
	}
	return nil
}

func mergeRow(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	err := mkDirIfNotExists(config.OutDir)
	if err != nil {
		return err
	}

	for _, row := range csvFileContent[1:] {
		data := ""

		fileName := getOutFileName(config.FileName, row[0])

		for _, col := range row[1:] {
			data += col + "\n\n"

			err = writeOutFile(data, config.OutDir+fileName+config.Extension)

			if err != nil {
				return err
			}
		}
	}

	return nil
}

func mergeColumns(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	if config.Extension == ".toml" {
		return tomlFiles(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	} else if config.Extension == ".json" {
		return jsonFiles(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	} else if config.Extension == ".arb" {
		return arbFiles(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	} else {
		return errors.New("Not yet implemented")
	}
}

// JSONify allows to convert linkedhashmap.Map with a max deep of two to json
// Todo make it recursive
func jsonify(m *linkedhashmap.Map) ([]byte, error) {
	var b = []byte{}
	buf := bytes.NewBuffer(b)

	buf.WriteRune('{')

	it := m.Iterator()
	lastIndex := m.Size() - 1
	index := 0

	for it.Next() {

		km, err := json.Marshal(it.Key())
		if err != nil {
			return nil, err
		}
		buf.Write(km)

		buf.WriteRune(':')

		if strings.HasPrefix(it.Key().(string), "@") {
			_, ok := it.Value().(*linkedhashmap.Map)

			if ok {
				itt := it.Value().(*linkedhashmap.Map).Iterator()
				var bb = []byte{}

				buftt := bytes.NewBuffer(bb)
				indextt := 0
				lastIndextt := it.Value().(*linkedhashmap.Map).Size() - 1

				buftt.WriteRune('{')

				for itt.Next() {

					km, err := json.Marshal(itt.Key())
					if err != nil {
						return nil, err
					}
					buftt.Write(km)
					buftt.WriteRune(':')
					vm, err := json.Marshal(itt.Value())
					if err != nil {
						return nil, err
					}
					buftt.Write(vm)

					if indextt != lastIndextt {
						buftt.WriteRune(',')
					}

					indextt++
				}

				buf.Write(buftt.Bytes())
				buf.WriteRune('}')
				if index != lastIndex {
					buf.WriteRune(',')
				}
			}
		} else {

			vm, err := json.Marshal(it.Value())
			if err != nil {
				return nil, err
			}
			buf.Write(vm)
			if index != lastIndex {
				buf.WriteRune(',')
			}
		}
		index++

	}

	buf.WriteRune('}')

	return buf.Bytes(), nil
}

func cleanData(data string, tagsFileDir, tagsFileName string) string {
	cleanedData := data

	cleanTags, _ := getCleanTranslationTags(tagsFileDir, tagsFileName)

	for _, tag := range cleanTags {
		cleanedData = strings.ReplaceAll(cleanedData, *tag.Error, *tag.Fixe)
	}
	// for tagIndex, tag := range tagsToRemove {
	// 	cleanedData = strings.ReplaceAll(cleanedData, tag, tagsToReplace[tagIndex])
	// }
	return cleanedData
}

// open csv file
func openCSVFile(csvFilePath string) ([][]string, error) {
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

func writeOutFile(data, outFilePath string) error {

	file, err := os.OpenFile(outFilePath, os.O_WRONLY|os.O_CREATE, 0777)

	defer file.Close()

	if err != nil {
		return err
	}

	// write to lang file
	err = file.Truncate(0)

	if err != nil {
		return fmt.Errorf("Cannot truncate file: %v", err)
	}

	_, err = file.Write([]byte(data))

	if err != nil {
		return fmt.Errorf("Cannot write to file: %v", err)
	}
	return nil
}

func mkDirIfNotExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0777)
		if err != nil {
			fmt.Println("Cannot create directory:", err)
			return err
		}
	}
	return nil
}

func cleanKey(key string) string {
	return strings.ReplaceAll(key, ".", "_")
}

func getCleanTranslationTags(fileDir, fileName string) ([]*CleanTranslation, error) {

	filePath, err := GetAbsoluteFilePath(fileDir, fileName)

	if err != nil {
		return nil, err
	}

	f, err := os.Open(filePath)

	if err != nil {
		return nil, err
	}

	cleanData := []*CleanTranslation{}

	err = json.NewDecoder(f).Decode(&cleanData)
	if err != nil {
		return nil, err
	}

	return cleanData, nil
}

func createFile(path string) {
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

// FormatJSON formats the JSON to be tidy and readable
func formatJSON(json []byte) (result []byte) {
	result = pretty.Pretty(json)
	return result
}

func getOutFileName(fileName, colName string) string {
	if fileName == "" {
		return colName
	}
	return fileName
}

// WriteLanguageFiles exported
func WriteLanguageFiles(csvFilePath string, jsonDirPath string, sheet string) error {
	csvFile, err := os.Open(csvFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, sheet+" : "+"Cannot open file:"+csvFilePath)

	}
	// get csf file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()
	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}

	langFileName := "labels.json"

	langFilePath := filepath.Join(jsonDirPath, langFileName)

	langAbsPath, err := filepath.Abs(langFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot get path specified: \""+langAbsPath+"\"", err)
		return errors.New("Cannot get path specified:" + langFilePath)
	}

	createFile(langAbsPath)

	file, err := os.OpenFile(langAbsPath, os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file: \""+langAbsPath+"\"", err)
		return errors.Wrap(err, sheet+" : "+"Cannot open file: \""+langAbsPath+"\"")
	}

	//log.Println("langAbsPath: \"" + langAbsPath + "\"")
	//os.Exit(1)

	err = file.Truncate(0)
	if err != nil {
		return errors.Errorf("Cannot truncate file:", err)
	}
	mapFull := map[string]map[string]string{}
	// walk content for each lang
	for i, lang := range csvFileContent[0][1:] {

		mapLn := map[string]string{}
		log.Println("Language : ", lang, i)
		for j, row := range csvFileContent[1:] {
			// fmt.Println(csvFileContent[j+1][0], row[i+1])
			mapLn[csvFileContent[j+1][0]] = row[i+1]
		}
		mapFull[lang] = mapLn
	}
	encodedJSON, _ := json.Marshal(mapFull)
	// log.Println(string(encodedJSON))

	_, err = file.Write(formatJSON(encodedJSON))
	if err != nil {
		return errors.Errorf("Cannot write to file:", err)
	}
	err = file.Close()
	if err != nil {
		return errors.Errorf("Cannot Close to file:", err)
	}
	return nil
}

// WriteFiles Write files
func WriteFiles(csvFilePath string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	// open csv file
	csvFileContent, err := openCSVFile(csvFilePath)

	if err != nil {
		return err
	}

	err = mkDirIfNotExists(config.OutDir)

	if err != nil {
		return fmt.Errorf("Cannot create dir: %v", err)
	}

	log.Println("Start generating data...")
	if config.Merge == "row" {
		return mergeRow(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	} else if config.Merge == "column" {
		return mergeColumns(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	} else if config.Merge == "cell" {
		return mergeCell(csvFileContent, config, cleanTagsDir, cleanTagsFileName)
	}

	return errors.New("Merge should be column or row")
}
