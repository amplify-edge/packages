package services

import (
	"strings"

	"github.com/getcouragenow/core-runtime/tool/lang/services/config"
	"github.com/getcouragenow/core-runtime/tool/lang/utils"
	"github.com/pkg/errors"
)

// merge googlesheet array by cell
func mergeCell(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	for index, col := range csvFileContent[0][1:] {
		index++
		for _, row := range csvFileContent[1:] {

			outDir := strings.ReplaceAll(config.OutDir, "XXX", col)
			err := utils.MkDirIfNotExists(outDir)
			if err != nil {
				return err
			}

			outFile := row[0]
			if config.FileName != "" {
				outFile = strings.ReplaceAll(config.FileName, "XXX", col) + config.Extension
			}

			cleanedData := utils.CleanData(row[index], cleanTagsDir, cleanTagsFileName)
			err = writeOutFile(cleanedData, outDir+outFile)

			if err != nil {
				return err
			}
		}
	}
	return nil
}

// merge googlesheet array by row
func mergeRow(csvFileContent [][]string, config config.Config, cleanTagsDir, cleanTagsFileName string) error {

	err := utils.MkDirIfNotExists(config.OutDir)
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

// merge googlesheet array by column
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
