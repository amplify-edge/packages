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
	"github.com/spf13/cobra"
)

var (
	subSubject *string
	subStorage *string
	subName    *string
)

// streamCmd represents the subject command
var streamCmd = &cobra.Command{
	Use:   "stream",
	Short: "add a stream to jetstream",
	Long:  ``,
	RunE: func(cmd *cobra.Command, args []string) error {
		return addSubject()
	},
}

var ls = &cobra.Command{
	Use:   "ls",
	Short: "list stream infos",
	Long:  ``,
	RunE: func(cmd *cobra.Command, args []string) error {
		return streamInfo()
	},
}

func init() {
	rootCmd.AddCommand(streamCmd)
	streamCmd.AddCommand(ls)
	subName = streamCmd.Flags().StringP("name", "n", "MESSAGES", "storage name(ex: MESSAGES)")
	subSubject = streamCmd.Flags().StringP("subjects", "s", "MESSAGES.*", "wildcard of subjects (ex:MESSAGES.*)")
	subStorage = streamCmd.Flags().StringP("storage", "g", "file", "where data is saved (file or memory)")
}

func addSubject() error {
	return execute("str", "add", *subName, "--subjects", *subSubject, "--ack", "--max-msgs=-1", "--max-bytes=-1", "--max-age=1y", "--storage", *subStorage, "--retention", "limits", "--max-msg-size=-1")
}

func streamInfo() error {
	return execute("str", "info", "ls")
}
