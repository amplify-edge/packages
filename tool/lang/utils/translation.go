package utils

import (
	"encoding/json"
	"os"
	"strings"
)

// CleanTranslation struct used to clean hugo translations files
type CleanTranslation struct {
	Error *string `json:"error"`
	Fix   *string `json:"fix"`
}

// CleanData clean data by replacing errors during translation
func CleanData(data, tagsFileDir, tagsFileName string) string {
	cleanedData := data

	cleanTags, _ := GetCleanTranslationTags(tagsFileDir, tagsFileName)

	for _, tag := range cleanTags {
		cleanedData = strings.ReplaceAll(cleanedData, *tag.Error, *tag.Fix)
	}
	return cleanedData
}

// CleanKey change separator
func CleanKey(key string) string {
	return strings.ReplaceAll(key, ".", "_")
}

// GetCleanTranslationTags get clean translation tags
func GetCleanTranslationTags(fileDir, fileName string) ([]*CleanTranslation, error) {

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
