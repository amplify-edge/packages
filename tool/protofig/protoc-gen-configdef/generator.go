package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"regexp"

	"github.com/getcouragenow/protokit"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/descriptorpb"
	plugin "google.golang.org/protobuf/types/pluginpb"

	"log"
	"strings"
	"text/template"
	"unicode"
)

type (
	protoapi struct {
		params   commandLineParams
		output   *bytes.Buffer
		Messages []*Message
		mnames   []string
		comments *protokit.Comment
		Fname    string
		Name     string
	}

	Message struct {
		Prefix string
		Name   string
		Fields []field
		Label  descriptorpb.FieldDescriptorProto_Label
	}

	field struct {
		JsonKey string
		Key     string
		Type    string
		Value   interface{}
		Label   descriptorpb.FieldDescriptorProto_Label
	}

	DefConfig struct {
		AppConfig []Component `json:"appConfig" yaml:"appConfig"`
	}

	Component struct {
		Name   string                 `json:"componentName" yaml:"componentName"`
		Config map[string]interface{} `json:"config" yaml:"config"`
	}
)

var (
	numberSequence    = regexp.MustCompile(`([a-zA-Z])(\d+)([a-zA-Z]?)`)
	numberReplacement = []byte("$1 $2 $3")
	uppercaseAcronym  = map[string]bool{
		"ID": true,
	}
)

func newGenerator(params commandLineParams) *protoapi {
	return &protoapi{
		params:   params,
		Messages: []*Message{},
		mnames:   []string{},
		output:   bytes.NewBuffer(nil),
	}
}

func (p *protoapi) newDefConfig() *DefConfig {
	var cs []Component
	for _, m := range p.Messages {
		fields := map[string]interface{}{}
		for _, f := range m.Fields {
			if f.Key != "" && f.Value != nil {
				fields[toCamelCase(f.Key)] = f.Value
			}
		}
		newComp := &Component{
			Name:   m.Name,
			Config: fields,
		}
		cs = append(cs, *newComp)
	}
	return &DefConfig{
		AppConfig: cs,
	}
}

func (p *protoapi) Generate(in *plugin.CodeGeneratorRequest) *plugin.CodeGeneratorResponse {
	resp := new(plugin.CodeGeneratorResponse)

	p.scanAllMessages(in, resp)
	p.GenerateGoDefault(in, resp)

	return resp
}

func (p *protoapi) scanAllMessages(req *plugin.CodeGeneratorRequest, _ *plugin.CodeGeneratorResponse) {
	descriptors := protokit.ParseCodeGenRequest(req)
	for _, d := range descriptors {
		p.scanMessages(d)
	}
}

func (p *protoapi) scanMessages(d *protokit.FileDescriptor) {
	for _, md := range d.GetMessages() {
		p.scanMessage(md)
	}
}

func (p *protoapi) scanMessage(md *protokit.Descriptor) {
	for _, smd := range md.GetMessages() {
		p.scanMessage(smd)
	}
	{
		fields := make([]field, len(md.GetMessageFields()))
		maps := make(map[string]*descriptorpb.DescriptorProto)
		for _, nt := range md.NestedType {
			if nt.Options.GetMapEntry() {
				name := nt.GetName()
				log.Println(name)
				maps[name] = nt
			}
		}

		for i, fd := range md.GetMessageFields() {
			typeName := fd.GetTypeName()
			if typeName == "" {
				typeName = fd.GetType().String()
			}

			f := field{
				Type:    typeName,
				Key:     fd.GetName(),
				JsonKey: fd.GetJsonName(),
				Value:   getFieldValue(fd.GetType().String(), fd.GetName(), fd.GetComments().GetTrailing()),
			}
			fields[i] = f
		}
		p.Messages = append(p.Messages, &Message{
			Name:   md.GetName(),
			Fields: fields,
		})
	}
}

func getFieldValue(s, kname, comment string) interface{} {
	switch s {
	case "TYPE_STRING":
		switch kname {
		case "email_val":
			return "test@example.com"
		default:
			return "REPLACE_THIS"
		}
	case "TYPE_BYTES":
		switch kname {
		case "cidr_val":
			return "IPv4_or_IPv6_here"
		default:
			return "bytes_value_here"
		}
	case "TYPE_DOUBLE", "TYPE_FLOAT":
		return 0.0
	case "TYPE_BOOL":
		return false
	case "TYPE_INT64", "TYPE_UINT64", "TYPE_INT32", "TYPE_UINT32":
		return 0
	case "TYPE_MESSAGE":
		return getNestedMessageValue(comment)
	default:
		return ""
	}
}

func getNestedMessageValue(s string) interface{} {
	typ := strings.Split(s, " ")
	if typ[0] == "repeated" {
		switch typ[len(typ)-1] {
		case "string":
			return `[REPLACE_THIS, REPLACE_THIS]`
		case "int", "uint64", "uint32", "int64", "int32":
			return [2]uint64{0, 0}
		case "double", "float":
			return [2]float64{0.0, 0.0}
		case "bool":
			return [2]bool{false, false}
		case "cidr":
			return [2]string{"127.0.0.1", "http://fe80::1ff:fe23:4567:890a"}
		case "email":
			return [2]string{"test@example.com", "winwisely268@example.com"}
		default:
			return `["", ""]`
		}
	}
	switch typ[len(typ)-1] {
	case "string":
		return `REPLACE_THIS`
	case "int", "uint64", "uint32", "int64", "int32":
		return 0
	case "double", "float":
		return 0.0
	case "bool":
		return false
	case "cidr":
		return "127.0.0.1"
	case "email":
		return "test@example.com"
	case "bytes":
		return "this is of type bytes"
	default:
		return `""`
	}
}

func (f field) isRepeated() bool {
	return f.Label == descriptorpb.FieldDescriptorProto_LABEL_REPEATED
}

func (p *protoapi) GenerateGoDefault(req *plugin.CodeGeneratorRequest, resp *plugin.CodeGeneratorResponse) {
	descriptors := protokit.ParseCodeGenRequest(req)

	for _, d := range descriptors {
		p.Fname = d.GetName()
		p.Name = d.GetPackage()
		defConfig := p.newDefConfig()
		for _, m := range p.Messages {
			m.Prefix = p.Name
		}
		switch p.params.outputFormat {
		case "dart":
			p.generateDartDefault()
			resp.File = append(resp.File,
				p.createGeneratorResponseFile(
					fmt.Sprintf("%s.default-%s.dart", p.Name, p.params.suffix),
				),
			)
		case "go":
			p.generateGoDefault()
			resp.File = append(resp.File,
				p.createGeneratorResponseFile(
					fmt.Sprintf("%s.default-%s.go", p.Name, p.params.suffix),
				),
			)
		case "json":
			defConfig.generateJsonDefault(p.output)
			resp.File = append(resp.File,
				p.createGeneratorResponseFile(
					fmt.Sprintf("%s.default-%s.json", p.Name, p.params.suffix),
				),
			)
		}

	}
}

func (p *protoapi) createGeneratorResponseFile(format string) *plugin.CodeGeneratorResponse_File {
	return &plugin.CodeGeneratorResponse_File{
		Name:    proto.String(format),
		Content: proto.String(p.output.String()),
	}
}

func (p *protoapi) generateGoDefault() {
	fmap := template.FuncMap{
		"toTitle":      strings.Title,
		"toPascalCase": toPascalCase,
		"yamlTpl":      getYamlTpl,
		"shellTpl":     getShellTpl,
	}
	if err := p.generatorDefault(gotpl, fmap); err != nil {
		panic(fmt.Sprintf("Should be able to marshal input to go output: %v", err))
	}
}

func (p *protoapi) generateDartDefault() {
	fmap := template.FuncMap{
		"toPascalCase": toPascalCase,
		"toCamel":      toCamelCase,
		"yamlTpl":      getYamlTpl,
		"shellTpl":     getShellTpl,
	}
	if err := p.generatorDefault(dartTpl, fmap); err != nil {
		panic(fmt.Sprintf("Should be able to marshal input to dart output: %v", err))
	}
}

func (dc *DefConfig) generateJsonDefault(output *bytes.Buffer) {
	jsonOut, err := json.MarshalIndent(dc, "", "  ")
	if err != nil {
		log.Fatal(err)
	}
	_, err = output.Write(jsonOut)
	if err != nil {
		log.Fatalf("fatal: should be able to write to output: %v", err)
	}
}

func (p *protoapi) generatorDefault(tpl string, fmap template.FuncMap) error {
	t, err := template.New(p.Fname).Funcs(fmap).Parse(tpl)
	if err != nil {
		panic(fmt.Sprintf("Error parsing default template: %v", err))
	}
	return t.Execute(p.output, p)
}

func isWhitespace(r rune) bool {
	return r == '\t' || r == '\n' || r == ' ' || r == '\r'
}

func toPascalCase(s string) string {
	prev := ' '
	result := strings.Map(
		func(r rune) rune {
			if isWhitespace(prev) || '_' == prev || '-' == prev {
				prev = r
				return unicode.ToTitle(r)
			} else if isWhitespace(r) || '_' == r || '-' == r {
				prev = r
				return -1
			} else {
				prev = r
				return unicode.ToLower(r)

			}
		},
		s)
	return result
}

func getYamlTpl(_ string) string {
	return yamlTmpl
}

func getShellTpl(_ string) string {
	return shellTpl
}

// Code below is
// taken from https://github.com/iancoleman/strcase

func addWordBoundariesToNumbers(s string) string {
	b := []byte(s)
	b = numberSequence.ReplaceAll(b, numberReplacement)
	return string(b)
}

func toUpperCaseSnake(s string) string {
	return toUpperCaseDelimited(s, '_', 0, true)
}

func toUpperCaseDelimited(s string, delimiter uint8, ignore uint8, upper bool) string {
	s = addWordBoundariesToNumbers(s)
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
func toCamelInitCase(s string, initCase bool) string {
	s = addWordBoundariesToNumbers(s)
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

func toCamelCase(s string) string {
	if s == "" {
		return s
	}
	if uppercaseAcronym[s] {
		s = strings.ToLower(s)
	}
	if r := rune(s[0]); r >= 'A' && r <= 'Z' {
		s = strings.ToLower(string(r)) + s[1:]
	}
	return toCamelInitCase(s, false)
}
