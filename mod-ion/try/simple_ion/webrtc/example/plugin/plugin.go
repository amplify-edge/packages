package package_ion

import (
	"os"
	"runtime"

	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "plugins.flutter.io/package_ion"

// PackageIonPlugin implements flutter.Plugin and handles method calls to
// the plugins.flutter.io/package_info channel.
type PackageIonPlugin struct{}

var _ flutter.Plugin = &PackageIonPlugin{} // compile-time type check

// InitPlugin initializes the plugin.
func (p *PackageIonPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	channel.HandleFunc("run", p.handleION)
	return nil
}

func (p *PackageIonPlugin) handleION(arguments interface{}) (reply interface{}, err error) {
	switch runtime.GOOS {
	case "linux":
		os.Chdir("output/linux-amd64/")
	case "windows":
	case "darwin":
	}

	return map[interface{}]interface{}{
		"appName":     flutter.ProjectName,
		"packageName": flutter.ProjectOrganizationName + "." + flutter.ProjectName,
		"version":     flutter.ProjectVersion,
		"buildNumber": flutter.ProjectVersion,
	}, nil
}
