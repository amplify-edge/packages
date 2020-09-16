package main

import (
	"errors"
	"fmt"
	"strings"
)

type commandLineParams struct {
	outputFormat string // dart output path
	suffix       string // user's name
}

// parseCommandLineParams breaks the comma-separated list of key=value pairs
// in the parameter (a member of the request protobuf) into a key/value map.
// It then sets command line parameter mappings defined by those entries.
func parseCommandLineParams(parameter string) (clp commandLineParams, err error) {
	clp = commandLineParams{}
	ps := make(map[string]string)
	for _, p := range strings.Split(parameter, ",") {
		if p == "" {
			continue
		}
		i := strings.Index(p, "=")
		if i < 0 {
			err = fmt.Errorf("invalid parameter %q: expected format of parameter to be k=v", p)
			return
		}
		k := p[0:i]
		v := p[i+1:]
		if v == "" {
			err = fmt.Errorf("invalid parameter %q: expected format of parameter to be k=v", k)
			return
		}
		ps[k] = v
	}

	for k, v := range ps {
		switch k {
		case "output_format":
			if v == "go" || v == "dart" || v == "json" {
				clp.outputFormat = v
			} else {
				return clp, errors.New("invalid parameter output_format: can only take 'dart' or 'go'")
			}
		case "suffix":
			clp.suffix = v
		default:
			err = fmt.Errorf("unknown parameter %q", k)
		}
	}
	return clp, nil
}
