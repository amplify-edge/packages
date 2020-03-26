package main

import (
	"flag"
	"log"

	deb "github.com/getcouragenow/bootstrap/tool/packager/linux"
)

func main() {
	pack := ""
	version := ""
	configFile := ""

	flag.StringVar(&pack, "pack", "deb", "package: deb, darwin, win...")
	flag.StringVar(&configFile, "config", "", "json file path")
	flag.StringVar(&version, "version", "1.0", "version")
	flag.Parse()

	switch pack {
	case "deb":
		debian(configFile, version)
	default:
		log.Println("Not yet implemented")
	}
}

func debian(configFile, version string) {
	p, err := deb.FromJSON(version, configFile)
	if err != nil {
		log.Fatal(err)
	}
	p.Build()
}
