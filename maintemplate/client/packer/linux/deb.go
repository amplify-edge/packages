package deb

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path"
	"strings"
)

// DebianPack struct
type DebianPack struct {
	version string
	Path    string            `json:"path"`
	DirName string            `json:"dir_name"`
	AppName string            `json:"app_name"`
	Ctl     Control           `json:"control"`
	Desk    Desktop           `json:"desktop"`
	App     map[string]string `json:"app"`
	CMD     map[string]string `json:"cmd"`
}

// FromJSON generate deb package from json
func FromJSON(version, configFilePath string) (*DebianPack, error) {
	data, err := ioutil.ReadFile(configFilePath)
	if err != nil {
		return nil, err
	}
	deb := &DebianPack{}

	err = json.Unmarshal(data, &deb)
	if err != nil {
		return nil, err
	}
	deb.version = version
	return deb, nil
}

func (p *DebianPack) init() {
	os.MkdirAll(p.getPath()+"/DEBIAN", 0755)
	os.MkdirAll(p.getPath()+"/usr/bin", 0755)
	os.MkdirAll(p.getPath()+"/usr/lib/"+p.AppName, 0755)
	os.MkdirAll(p.getPath()+"/usr/share/applications", 0755)
}

func (p *DebianPack) getPath() string {
	return path.Join(p.Path, p.DirName)
}

func (p *DebianPack) entrypoint() []byte {
	out := "#!/bin/sh\n"
	out += path.Join("/usr/lib/", p.AppName, p.AppName)
	return []byte(out)
}

// Build deb
func (p *DebianPack) Build() {
	p.init()
	writeFile(path.Join(p.getPath(), "usr/bin", p.AppName), p.entrypoint())
	writeFile(path.Join(p.getPath(), "DEBIAN/control"), p.Ctl.encode(p.version, p.AppName))
	writeFile(path.Join(p.getPath(), "usr/share/applications", p.AppName+".desktop"), p.Desk.encode(p.version, p.AppName))

	for k, v := range p.App {
		v = parseData(v, p.version, p.AppName)
		execute("cp", "-r", k, p.getPath()+"/"+v)
	}

	os.Chdir(p.getPath())
	for k, v := range p.CMD {
		v = parseData(v, p.version, p.AppName)
		err := execute(k, strings.Split(v, " ")...)
		if err != nil {
			log.Fatal(err)
		}
	}
}

// Control struct
type Control struct {
	Options map[string]string `json:"options"`
}

func (c *Control) encode(version, appName string) []byte {
	out := ""

	for k, v := range c.Options {
		v = parseData(v, version, appName)
		out += k + ": " + v + "\n"
	}
	strings.TrimRight(out, "\n")
	return []byte(out)
}

// Desktop struct
type Desktop struct {
	Options map[string]string `json:"options"`
}

func (d *Desktop) encode(version, appName string) []byte {
	out := "[Desktop Entry]\n"
	for k, v := range d.Options {
		v = parseData(v, version, appName)
		out += k + "= " + v + "\n"
	}
	strings.TrimRight(out, "\n")
	return []byte(out)
}

func execute(cmd string, args ...string) error {
	c := exec.Command(cmd, args...)
	c.Stdout = os.Stdout
	c.Stderr = os.Stderr
	return c.Run()
}

func writeFile(path string, data []byte) error {
	f, err := os.OpenFile(path, os.O_RDWR|os.O_CREATE, 0755)
	if err != nil {
		return err
	}
	defer f.Close()

	_, err = f.Write(data)
	return err
}

func parseData(v, version, appName string) string {
	if strings.Contains(v, "{{.version}}") {
		v = strings.ReplaceAll(v, "{{.version}}", version)
	}
	if strings.Contains(v, "{{.app_name}}") {
		v = strings.ReplaceAll(v, "{{.app_name}}", appName)
	}
	return v
}
