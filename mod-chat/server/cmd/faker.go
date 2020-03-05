/*
Copyright © 2020 NAME HERE <EMAIL ADDRESS>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package cmd

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

	"github.com/spf13/cobra"
)

var (
	faFile    *string
	faSubject *string
	faURL     *string
	url       = "https://jsonplaceholder.typicode.com/users"
)

// fakerCmd represents the faker command
var fakerCmd = &cobra.Command{
	Use:   "faker",
	Short: "populate nats server with fake data",
	Long:  ``,
	RunE: func(cmd *cobra.Command, args []string) error {
		if *faURL == "" {
			return populate(*faFile, true)
		}
		return populate(*faURL, false)
	},
}

func init() {
	rootCmd.AddCommand(fakerCmd)
	faFile = fakerCmd.Flags().StringP("file", "f", "./fake_data/data.json", "file path fake data")
	faURL = fakerCmd.Flags().StringP("url", "u", "", "url of file fake data")
	faSubject = fakerCmd.Flags().StringP("subject", "s", "MESSAGES.fake", "subject where add fake data")
}

func openFileFomURL(url string) ([]byte, error) {
	res, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()
	return ioutil.ReadAll(res.Body)
}

// populate
func populate(file string, local bool) error {

	var data []byte
	var err error

	if local {
		data, err = ioutil.ReadFile(file)
		if err != nil {
			return err
		}
	} else {
		data, err = openFileFomURL(file)
		if err != nil {
			return err
		}
	}

	messages := []string{}
	err = json.Unmarshal(data, &messages)
	if err != nil {
		return err
	}

	for _, msg := range messages {
		err := publish(*faSubject, msg)
		if err != nil {
			log.Println("Error to publish", err)
		}
	}
	return nil
}
