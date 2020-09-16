package main

import (
	"encoding/json"
	"flag"
	"fmt"
	config "github.com/getcouragenow/core-runtime/tool/protofig/generated/go"
	"io/ioutil"
	"log"
	"os"
)

var (
	jsonFile string
	outPath  string
	user     string
)

type outputStruct struct {
	cfg    *config.DefConfig
	path   string
	suffix string
}

func NewOutputStruct(cfg *config.DefConfig, path, suffix string) *outputStruct {
	return &outputStruct{
		cfg:    cfg,
		path:   path,
		suffix: suffix,
	}
}

func main() {
	flag.StringVar(&jsonFile, "f", "", "json file to decode/encode")
	flag.StringVar(&outPath, "o", "", "json output validated against protobuf schema")
	flag.StringVar(&user, "u", "", "prefix to output files")
	flag.Parse()

	if jsonFile == "" {
		log.Fatal("Error: you have to supply the jsonfile option")
	}

	if outPath == "" {
		out, err := os.Getwd()
		if err != nil {
			log.Fatal("Cannot get current working dir")
		}
		outPath = out
	}

	if user == "" {
		log.Fatal("Error: user prefix has to be supplied")
	}

	f, err := os.Open(jsonFile)
	if err != nil {
		log.Fatalf("Error: your input json file doesn't exist: %v", err)
	}

	file, err := ioutil.ReadAll(f)
	if err != nil {
		log.Fatalf("Error: your input can't be read: %v", err)
	}

	var newAppConfig config.DefConfig
	if err := json.Unmarshal(file, &newAppConfig); err != nil {
		log.Fatalf("Error: unable to marshal to json: %v", err)
	}

	newOutputStruct := NewOutputStruct(&newAppConfig, outPath, user)

	if err = CreateOutputs(newOutputStruct); err != nil {
		log.Fatalf("Error while creating output: %v", err)
	}

}

func CreateOutputs(out *outputStruct) (err error) {
	if err = out.createOutput(makeJsonConfig, writeFile, "json"); err != nil {
		return err
	}
	if err = out.createOutput(makeSecretConfig, writeFile, "yaml"); err != nil {
		return err
	}
	return out.createOutput(makeShellConfig, writeFile, "env")
}

func (o *outputStruct) createOutput(f func(c *config.Component) ([]byte, error), writeFunc func(string, []byte) error, format string) error {
	for _, c := range o.cfg.AppConfig {
		nb, err := f(&c)
		if err != nil {
			return err
		}
		if err = writeFunc(
			fmt.Sprintf("%s/%s.%s.%s", o.path, c.Name, o.suffix, format), nb); err != nil {
			return err
		}
	}
	return nil
}

func writeFile(path string, content []byte) error {
	return ioutil.WriteFile(path, content, 0644)
}

func makeJsonConfig(c *config.Component) ([]byte, error) {
	return c.ConfigToJSON()
}

func makeShellConfig(c *config.Component) ([]byte, error) {
	return c.ConfigToShellEnv()
}

func makeSecretConfig(c *config.Component) ([]byte, error) {
	return c.ConfigToK8sSecret()
}
