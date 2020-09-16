package main

var (
	gotpl = `package {{ .Name }}
	
import (
	"bytes"
	b64 "encoding/base64"
	"errors"
	"google.golang.org/protobuf/encoding/protojson"
	nurl "net/url"
	"reflect"
	"regexp"
	"strings"
	"text/template"
)	
	
type DefConfig struct {
	AppConfig []Component ` + "`" + `json:"appConfig" yaml:"appConfig"` + "`" + `
}

type Component struct {
	Name   string                 ` + "`" + `json:"componentName" yaml:"appConfig"` + "`" + `
	Config map[string]interface{} ` + "`" + `json:"config" yaml:"config"` + "`" + ` 
}	

var (	
	{{ .Name }}MessageNames = []string{
		{{ range .Messages }}"{{ .Name }}",
		{{ end }}
	}
	{{ .Name }}ShellTpl =  ` + "`" + `{{ "" | shellTpl }}` + "`" + ` 
	{{ .Name }}YamlTpl =  ` + "`" + `{{ "" | yamlTpl }}` + "`" + ` 
	{{ .Name }}NumberSequence    = regexp.MustCompile(` + "`" + `([a-zA-Z])(\d+)([a-zA-Z]?)` + "`" + `)
	{{ .Name }}NumberReplacement = []byte("$1 $2 $3")
	{{ .Name }}UppercaseAcronym = map[string]bool{
		"ID": true,
	}
)
	
func {{ .Name }}IsUrl(str string) bool {
	u, err := nurl.Parse(str)
	return err == nil && u.Scheme != "" && u.Host != ""
}
	
func {{ .Name }}IsEmail(str string) bool {
	rxEmail := regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+\\/=?^_` + "`" + `{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	return rxEmail.MatchString(str)
}
	
func {{ toTitle .Name }}HasMessageName(s string) bool {
	for _, mn := range {{ .Name }}MessageNames {
	    if s == mn {
			return true
		}
	}
	return false
}
	
func (c *Component) {{ toTitle .Name }}ToJSON() ([]byte, error) {
	switch c.Name {
	{{ range .Messages}}case "{{ .Name }}":
		msg, err := c.Create{{ .Name }}()
		if err != nil { return nil, err }
		return msg.MarshalJSON()
	{{ end }}
	default:
		return nil, errors.New("component name is unknown")
	}
}
	
func (c *Component) {{ toTitle .Name }}ToShellEnv() ([]byte, error) {
	b := bytes.NewBuffer(nil)
	component, err := func() (*Component, error) {
		switch c.Name {
		{{ range .Messages }}case "{{ .Name }}":
			msg, err := c.Create{{ .Name }}()
			if err != nil { return nil, err }
			return msg.ToComponent()
		{{ end }}
		default:
			return nil, errors.New("component name is unknown")
		}
	}()
	if err != nil { return nil, err }
	shellTemplate := {{ .Name }}ShellTpl
	fmap := template.FuncMap{
		"toUpperCaseSnake": {{ .Name }}ToUpperCaseSnake,
	}
	t, err := template.New(component.Name).Funcs(fmap).Parse(shellTemplate)
	if err != nil {
			return nil, err
		}
	err = t.Execute(b, component)
	return b.Bytes(), err
}
	
func (c *Component) {{ toTitle .Name }}ToK8sSecret() ([]byte, error) {
	b := bytes.NewBuffer(nil)
	component, err := func() (*Component, error) {
		switch c.Name {
		{{ range .Messages }}case "{{ .Name }}":
			msg, err := c.Create{{ .Name }}()
			if err != nil { return nil, err }
			return msg.ToComponent()
		{{ end }}
		default:
			return nil, errors.New("component name is unknown")
		}
	}()
	if err != nil { return nil, err }
	yamlTemplate := {{ .Name }}YamlTpl
	fmap := template.FuncMap{
		"toB64": {{ .Name }}ToB64,
		"typeOf": {{ .Name }}TypeOf,
		"toCamelCase": {{ .Name }}ToCamelCase,
	}
	t, err := template.New(component.Name).Funcs(fmap).Parse(yamlTemplate)
	if err != nil {
			return nil, err
		}
	err = t.Execute(b, component)
	return b.Bytes(), err
}
	
func {{ .Name }}IsSecret(s string) bool {
	rxSecret := regexp.MustCompile("[k|K]ey")
	return rxSecret.MatchString(s)
}
	
func(c *ConfigVal) FromConfigVal() (interface{}, error) {
	protoTyp := strings.Split(c.String(), ":")[0]
	switch protoTyp {
	case "string_val":
		return c.GetStringVal(), nil
	case "uint64_val":
		return c.GetUint64Val(), nil
	case "double_val":
		return c.GetDoubleVal(), nil
	case "bool_val":
		return c.GetBoolVal(), nil
	case "cidr_val":
		return c.GetCidrVal(), nil
	case "email_val":
		return c.GetEmailVal(), nil
	default:
		return nil, errors.New("unknown value")
	}
}

func toConfigVal(i interface{}) (cfg *ConfigVal, err error) {
	switch i.(type) {
	case string:
		if {{ .Name }}IsUrl(i.(string)) {
			cfg = &ConfigVal{Val: &ConfigVal_CidrVal{CidrVal: []byte(i.(string))}}
			if err = cfg.Validate(); err != nil {
				return nil, err
			}
			return cfg, nil
		} else if {{ .Name }}IsEmail(i.(string)) {
			cfg = &ConfigVal{Val: &ConfigVal_EmailVal{EmailVal: i.(string)}}
			if err = cfg.Validate(); err != nil {
				return nil, err
			}
			return cfg, nil
		} else {
			if {{ .Name }}IsSecret(i.(string)) {
				cfg = &ConfigVal{Val: &ConfigVal_StringVal{StringVal: b64.StdEncoding.EncodeToString([]byte(i.(string)))}}
				if err = cfg.Validate(); err != nil {
					return nil, err
				}
			return cfg, nil	
			}
		    cfg = &ConfigVal{Val: &ConfigVal_StringVal{StringVal: i.(string)}}
			if err = cfg.Validate(); err != nil {
				return nil, err
			}
			return cfg, nil
		}

	case uint32, uint64, int, int32:
	    cfg := &ConfigVal{Val: &ConfigVal_Uint64Val{Uint64Val: i.(uint64)}}
		if err = cfg.Validate(); err != nil {
			return nil, err
		}
		return cfg, nil
	case bool:
	    cfg := &ConfigVal{Val: &ConfigVal_BoolVal{BoolVal: i.(bool)}}
		if err = cfg.Validate(); err != nil {
			return nil, err
		}
		return cfg, nil	
	case float64, float32:
		cfg := &ConfigVal{Val: &ConfigVal_DoubleVal{DoubleVal: i.(float64)}}
		if err = cfg.Validate(); err != nil {
			return nil, err
		}
		return cfg, nil
	default:
		return nil, errors.New("Unknown value")
	}
}
{{ range .Messages }}func (c *Component) Create{{ .Name }}() (*{{ .Name }}, error) {
	{{ range .Fields }}{{ .JsonKey }}, err := toConfigVal(c.Config["{{ .JsonKey }}"])
	if err != nil {
		return nil, err
	}
	{{ end }}
	return &{{ .Name }}{
	    {{ range .Fields }}{{ .Key | toPascalCase }}: {{ .JsonKey }},
	    {{ end }}
	}, nil
}
{{ end }}	
	
{{ range .Messages }}func (x *{{ .Name }}) MarshalJSON() ([]byte, error) {
	opt := protojson.MarshalOptions{
		Multiline: true,
		AllowPartial: true,
	}
	return opt.Marshal(x)
}
{{ end }}
	
{{ range .Messages }}func (x *{{ .Name }}) UnmarshalJSON(b []byte) error {
	opt := protojson.UnmarshalOptions{
		AllowPartial: true,
	}
	return opt.Unmarshal(b, x)
}
{{ end }}

{{ range .Messages }}func (x *{{ .Name }}) ToComponent() (*Component, error) {
	var err error
	msgName := "{{ .Name }}"
	fields := make(map[string]interface{})
	{{ range .Fields }}
	fields["{{ .JsonKey }}"], err = x.{{ .Key | toPascalCase }}.FromConfigVal()
	if err != nil { return nil, err }
	{{ end }}
	return &Component{
		Name: msgName,
		Config: fields,
	}, nil
}
{{ end }}	

{{ range .Messages }}func (x *{{ .Name }}) ToProtoModuleConfig() *ProtoModuleConfig {
	msc := map[string]*ConfigVal{}
	{{ range .Fields }}msc["{{ .JsonKey }}"] = x.{{ .Key | toPascalCase }}
	{{ end }}
	return &ProtoModuleConfig{
		ModuleId: "{{ .Name }}",
		Configs: msc,
	}
}
{{ end }}	
	
{{ range .Messages }}func (p *ProtoModuleConfig) Create{{ .Name }}() (*{{ .Name }}, error) {
	if p.ModuleId == "{{ .Name }}" {
	    {{ range .Fields }}{{ .JsonKey }} := p.Configs["{{ .JsonKey }}"]
	    {{ end }}
	    return &{{ .Name }}{
	        {{ range .Fields }}{{ .Key | toPascalCase }}: {{ .JsonKey }},
	        {{ end }}
	    }, nil
	}
	return nil, errors.New("Module name doesn't match current message")
}
{{ end }}	
	
func {{ .Name }}ToB64(s string) string {
	return b64.StdEncoding.EncodeToString([]byte(s))
}
	
func {{ .Name }}TypeOf(i interface{}) string {
	return reflect.TypeOf(i).String()
}	
	
// Code below is
// taken from https://github.com/iancoleman/strcase

func {{ .Name }}AddWordBoundariesToNumbers(s string) string {
	b := []byte(s)
	b = {{ .Name }}NumberSequence.ReplaceAll(b, {{ .Name }}NumberReplacement)
	return string(b)
}


func {{ .Name }}ToUpperCaseSnake(s string) string {
	return {{ .Name }}ToUpperCaseDelimited(s, '_', 0, true)
}

func {{ .Name }}ToUpperCaseDelimited(s string, delimiter uint8, ignore uint8, upper bool) string {
	s = {{ .Name }}AddWordBoundariesToNumbers(s)
	s = strings.Trim(s, " ")
	n := ""
	for i, v := range s {
		// treat acronyms as words, eg for JSONData -> JSON is a whole word
		nextCaseIsChanged := false
		if i+1 < len(s) {
			next := s[i+1]
			vIsCap := v >= 'A' && v <= 'Z'
			vIsLow := v >= 'a' && v <= 'z'
			nextIsCap := next >= 'A' && next <= 'Z'
			nextIsLow := next >= 'a' && next <= 'z'
			if (vIsCap && nextIsLow) || (vIsLow && nextIsCap) {
				nextCaseIsChanged = true
			}
			if ignore > 0 && i-1 >= 0 && s[i-1] == ignore && nextCaseIsChanged {
				nextCaseIsChanged = false
			}
		}

		if i > 0 && n[len(n)-1] != delimiter && nextCaseIsChanged {
			// add underscore if next letter case type is changed
			if v >= 'A' && v <= 'Z' {
				n += string(delimiter) + string(v)
			} else if v >= 'a' && v <= 'z' {
				n += string(v) + string(delimiter)
			}
		} else if v == ' ' || v == '_' || v == '-' {
			// replace spaces/underscores with delimiters
			if uint8(v) == ignore {
				n += string(v)
			} else {
				n += string(delimiter)
			}
		} else {
			n = n + string(v)
		}
	}

	if upper {
		n = strings.ToUpper(n)
	} else {
		n = strings.ToLower(n)
	}
	return n
}
	

// Converts a string to CamelCase
func {{ .Name }}ToCamelInitCase(s string, initCase bool) string {
	s = {{ .Name }}AddWordBoundariesToNumbers(s)
	s = strings.Trim(s, " ")
	n := ""
	capNext := initCase
	for _, v := range s {
		if v >= 'A' && v <= 'Z' {
			n += string(v)
		}
		if v >= '0' && v <= '9' {
			n += string(v)
		}
		if v >= 'a' && v <= 'z' {
			if capNext {
				n += strings.ToUpper(string(v))
			} else {
				n += string(v)
			}
		}
		if v == '_' || v == ' ' || v == '-' || v == '.' {
			capNext = true
		} else {
			capNext = false
		}
	}
	return n
}	
	
// {{ .Name }}ToCamelCase converts a string to lowerCamelCase
func {{ .Name }}ToCamelCase(s string) string {
	if s == "" {
		return s
	}
	if {{ .Name }}UppercaseAcronym[s] {
		s = strings.ToLower(s)
	}
	if r := rune(s[0]); r >= 'A' && r <= 'Z' {
		s = strings.ToLower(string(r)) + s[1:]
	}
	return {{ .Name }}ToCamelInitCase(s, false)
}	
`
	yamlTmpl = `apiVersion: v1
kind: Secret
metadata:
  name: {{ .Name | toCamelCase }}-secret
type: Opaque
data:
  {{ range $k, $v := .Config }}{{if eq ($v | typeOf ) "string"}}{{ $k }}: {{ $v | toB64 }}{{end}}
  {{ end }}`
	shellTpl = `
# {{ .Name }}	
{{ range $k, $v := .Config }}{{ $k | toUpperCaseSnake }} = "{{ $v }}"
{{ end }}
export {{ range $k, $v := .Config}}{{ $k | toUpperCaseSnake }} {{ end }}
`
)
