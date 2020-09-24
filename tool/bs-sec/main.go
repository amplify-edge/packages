package main

import (
	"os"

	"github.com/securego/gosec/v2/cmd/gosec"
	// "github.com/securego/gosec/v2/cmd/gosec"
)

func main() {
	resp := gosec.Execute(os.Args[1:])

	if resp.Err != nil {
		if resp.IsUserError() {
			resp.Cmd.Println("")
			resp.Cmd.Println(resp.Cmd.UsageString())
		}
		os.Exit(-1)
	}

}
