package services

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/emirpasic/gods/maps/linkedhashmap"
	"github.com/getcouragenow/core-runtime/tool/lang/services/config"
	"github.com/getcouragenow/core-runtime/tool/lang/utils"

	"github.com/tidwall/pretty"
)

// TomlFormat struct
type TomlFormat struct {
	Key    string
	Values [][]string
}

func arbFiles(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {
	for index, col := range csvFileContent[0][1:] {
		languages := linkedhashmap.New()
		// languages := map[string]interface{}{}
		cleanedData := ""
		fileName := getOutFileName(config.FileName, col)
		index++
		for _, row := range csvFileContent[1:] {
			err := utils.MkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}
			cleanedData = utils.CleanData(row[index], cleanTagsDir, cleanTagsFileName)

			m := linkedhashmap.New()
			m.Put("description", utils.CleanKey(row[0]))
			m.Put("type", "text")
			m.Put("placeholders", "{}")

			languages.Put(utils.CleanKey(row[0]), cleanedData)
			languages.Put("@"+utils.CleanKey(row[0]), m)
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
			err := utils.MkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}
			cleanedData = utils.CleanData(row[index], cleanTagsDir, cleanTagsFileName)
			languages[utils.CleanKey(row[0])] = cleanedData
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
		var languages []TomlFormat
		cleanedData := ""
		fileName := getOutFileName(config.FileName, col)
		index++

		for _, row := range csvFileContent[1:] {

			err := utils.MkDirIfNotExists(config.OutDir)
			if err != nil {
				return err
			}

			cleanedData = utils.CleanData(row[index], cleanTagsDir, cleanTagsFileName)

			h := TomlFormat{}
			if strings.Contains(row[0], "(") && config.Extension == ".toml" {

				// Check if row contains multi values
				sp := strings.Split(row[0], "(")
				tr := strings.TrimRight(sp[1], ")")
				sp2 := strings.Split(tr, ".")

				// if there is already a object with the same key in cache
				// get index from cache and append to to values array
				if i, ok := cache[utils.CleanKey(sp[0])]; ok {

					val := []string{sp2[1], cleanedData}
					languages[i].Values = append(languages[i].Values, val)
					continue
				}

				h = TomlFormat{Key: utils.CleanKey(sp[0]), Values: [][]string{{sp2[1], cleanedData}}}

			} else {
				h = TomlFormat{Key: utils.CleanKey(row[0]), Values: [][]string{{"other", cleanedData}}}
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

// JSONify allows to convert linkedhashmap.Map with a max depth of two to json
// Todo make it recursive
func jsonify(m *linkedhashmap.Map) ([]byte, error) {
	var b []byte
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

func getOutFileName(fileName, colName string) string {
	if fileName == "" {
		return colName
	}
	return fileName
}
