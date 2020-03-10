package simple_ion

import (
	"os"
	"os/exec"
	"runtime"

	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "simple_ion"

// SimpleIonPlugin implements flutter.Plugin and handles method.
type SimpleIonPlugin struct{}

var _ flutter.Plugin = &SimpleIonPlugin{} // compile-time type check

// InitPlugin initializes the plugin.
func (p *SimpleIonPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	channel.HandleFunc("start", p.handleStart)
	return nil
}

func (p *SimpleIonPlugin) handleStart(arguments interface{}) (reply interface{}, err error) {
	cmd := &exec.Cmd{}
	path := ""

	switch runtime.GOOS {
	case "linux":
		path = "../go/dlib/linux/ION Desktop App"
	case "windows":
		path = "../go/dlib/windows/ION Desktop App.exe"
	case "darwin":
		path = "../go/dlib/darwin/MacOS/ion_desktop"

	}

	cmd.Stdout = os.Stdout
	cmd.Path = path
	err = cmd.Run()
	return "go-flutter " + runtime.GOOS, err
}
