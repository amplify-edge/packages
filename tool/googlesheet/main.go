package main

import (
	"flag"
	"log"
	"sync"

	"github.com/getcouragenow/core-runtime/tool/googlesheet/services"
	"github.com/getcouragenow/core-runtime/tool/googlesheet/services/config"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	// process lang by default
	option := flag.String("option", "hugo", "a string")
	flag.Parse()
	switch *option {
	case "lang":
		processConfig(*option)
	case "datadump":
		processConfig(*option)
	case "i18n":
		processConfig(*option)
	default:
		log.Println("Invalid Option ", *option)
	}
	log.Println("Completed Execution..")
}
func processConfig(option string) {
	Setting, err := config.New(option)
	if err != nil {
		log.Println("No conf file founded ", option)
		return
	}

	log.Println("Starting Extracting Language Files from GoogleSheet - downloading csv approach..")
	var wg sync.WaitGroup
	for item, conf := range Setting.GoogleSheet {
		wg.Add(1)
		go func(sheet string, config config.Config) {
			gsheetURL := Setting.GoogleSheet[sheet].CSV
			csvRelFilePath := "./outputs/" + option + "/" + sheet + ".csv"
			csvAbsFilePath, err := services.GetAbsoluteFilePath(csvRelFilePath, sheet)

			err = services.Download(gsheetURL, csvAbsFilePath, 5000, sheet, true)
			if err != nil {
				log.Println(sheet, " : ", err)
				wg.Done()
				return
			}

			jsonRelDirPath := "./outputs/" + option + "/json/" + sheet + "/"
			jsonAbsDirPath, err := services.GetAbsoluteFilePath(jsonRelDirPath, sheet)

			// log.Println(sheet, " JSON Output directory: "+jsonAbsDirPath)
			switch option {
			case "lang":
				err = services.WriteLanguageFiles(csvAbsFilePath, jsonAbsDirPath, sheet)
				if err != nil {
					log.Println(sheet, " : ", err)
					wg.Done()
					return
				}
			case "datadump":
				err = services.WriteDataDumpFiles(csvAbsFilePath, jsonAbsDirPath, sheet)
				if err != nil {
					log.Println(sheet, " : ", err)
					wg.Done()
					return
				}
			case "i18n":
				cleanTagsDir := "./clean_translation_tags.json"
				cleanTagsFileName := "clean_translation_tags.json"
				err = services.WriteFiles(csvAbsFilePath, config, cleanTagsDir, cleanTagsFileName)
				if err != nil {
					log.Println(err)
					wg.Done()
					return
				}
			default:
				log.Println("Invalid Option ", option)
			}

			wg.Done()
		}(item, conf)

	}
	wg.Wait()
}
