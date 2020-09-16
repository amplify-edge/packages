package main_test

import (
	"encoding/json"
	config "github.com/getcouragenow/core-runtime/tool/protofig/generated/go"
	"os"
	"path/filepath"
	"testing"

	p "github.com/getcouragenow/core-runtime/tool/protofig"
)

var testData = `
{
  "appConfig": [
    {
      "componentName": "MinioComponent",
      "config": {
        "minioAccesskey": "REPLACE_THIS",
        "minioSecretkey": "REPLACE_THIS"
      }
    },
    {
      "componentName": "MaintemplateComponent",
      "config": {
        "minioAccesskey": "REPLACE_THIS",
        "minioEnckey": "this is of type bytes",
        "minioEndpoint": "127.0.0.1",
        "minioLocation": "REPLACE_THIS",
        "minioSecretkey": "REPLACE_THIS",
        "minioSsl": false,
        "minioTimeout": 0
      }
    },
    {
      "componentName": "GcpComponent",
      "config": {
        "gcpProject": "REPLACE_THIS",
        "gcpUser": "REPLACE_THIS",
        "gkeCluster": "REPLACE_THIS",
        "gkeEmail": "test@example.com",
        "gkeZone": "REPLACE_THIS"
      }
    },
    {
      "componentName": "JwtComponent",
      "config": {
        "privateKey": "REPLACE_THIS",
        "publicKey": "REPLACE_THIS"
      }
    },
    {
      "componentName": "WorkflowComponent",
      "config": {
        "flutterChannel": "REPLACE_THIS",
        "githubRef": "REPLACE_THIS",
        "githubSha": "REPLACE_THIS",
        "locales": "[REPLACE_THIS, REPLACE_THIS]",
        "project": "REPLACE_THIS",
        "registryHostname": "127.0.0.1",
        "releaseChannel": "REPLACE_THIS",
        "url": "REPLACE_THIS"
      }
    }
  ]
}
`

func BenchmarkCreateOutputs(b *testing.B) {
	var newAppConfig config.DefConfig
	if err := json.Unmarshal([]byte(testData), &newAppConfig); err != nil {
		b.Fatalf("Error: unable to marshal to json: %v", err)
	}
	path, err := os.Getwd()
	if err != nil {
		b.Fatalf("Error: unable to get current dir")
	}
	outDir := filepath.Join(path, "output")
	output := p.NewOutputStruct(&newAppConfig, outDir, "alex")
	if _, err = os.Stat(outDir); err != nil {
		err = os.Mkdir(outDir, 0755)
		if err != nil {
			b.Fatalf("Error: unable to create directory: %v", err)
		}
	}
	for i := 0; i < b.N; i++ {
		if err = p.CreateOutputs(output); err != nil {
			b.Fatalf("Error: unable to create outputs: %v", err)
		}
	}
	b.Logf("Successfully run bench test")
	os.Remove(outDir)
}
