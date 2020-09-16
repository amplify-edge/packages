package main

var (
	dartTpl = `import 'dart:convert';
import 'baseproto.pb.dart';	
import 'package:fixnum/fixnum.dart';	
import '{{ .Name }}.pb.dart';
import 'settings.pb.dart';	
	
class {{ .Name | toPascalCase }}DefConfig {
  final List<{{ .Name | toPascalCase }}AppConfig> appConfig;
  {{ .Name | toPascalCase }}DefConfig({
    this.appConfig
  });
	
  factory {{ .Name | toPascalCase }}DefConfig.fromJson(Map<String, dynamic> json) => {{ .Name | toPascalCase }}DefConfig(
    appConfig: List<{{ .Name | toPascalCase }}AppConfig>.from(json["appConfig"].map((x) => {{ .Name | toPascalCase }}AppConfig.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "appConfig": List<dynamic>.from(appConfig.map((x) => x.toJson())),
  };
}
	
class {{ .Name | toPascalCase }}AppConfig {
  String componentName;
  Map<String, dynamic> config;
	
  {{ .Name | toPascalCase }}AppConfig({
    this.componentName,
    this.config,
  });
	
  factory {{ .Name | toPascalCase }}AppConfig.fromJson(Map<String, dynamic> json) =>
    ConfigAppConfig(
      componentName: json["componentName"], config: json["config"],
	);
	
  factory {{ .Name | toPascalCase }}AppConfig.fromEmpty() => ConfigAppConfig(
	  componentName: "", config: Map<String, dynamic>(),
	);
	
  Map<String, dynamic> toJson() => {
    "componentName": componentName,
    "config": config,
  };

  {{ range .Messages }}{{ .Name }} {{ .Name }}FromAppConfig() {
	{{ .Name }} msg = {{ .Name }}.create();
	{{ range .Fields }}msg.{{ .JsonKey }} = ConfigVal().fromDynamic(config["{{ .JsonKey }}"]);
	{{ end }}
	return msg;
  }
  {{ end }}	
	
}

{{ range .Messages }} extension {{ .Prefix | toPascalCase }}{{ .Name }} on {{ .Name }} {
  {{ .Prefix | toPascalCase }}AppConfig toAppConfig() {
	  {{ .Prefix | toPascalCase }}AppConfig component = {{ .Prefix | toPascalCase }}AppConfig.fromEmpty();	
	  component.componentName = "{{ .Name | toCamel }}";
	  {{ range .Fields}}component.config["{{ .JsonKey }}"] = this.{{ .JsonKey }}.toDynamic(); 
	  {{ end }}
	  return component;
  }
	
  ProtoModuleConfig to{{ .Prefix | toPascalCase }}ProtoModuleConfig() {
	  ProtoModuleConfig x = ProtoModuleConfig();
	  x.moduleId = "{{ .Name }}";
	  {{ range .Fields }}x.configs["{{ .JsonKey }}"] = this.{{ .JsonKey }};
	  {{ end }}
	  return x;
  }	
}
{{ end }}	
	
extension {{ .Name | toPascalCase }}ConfigVal on ConfigVal {
  bool isEmail(String s) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_` + "`" + `{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s);
  }

  bool isCidr(String s) {
    RegExp ipv4 = RegExp(
      r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");
    RegExp ipv6 = RegExp(
      r"^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))(\/((1(1[0-9]|2[0-8]))|([0-9][0-9])|([0-9])))?$");

    return (ipv4.hasMatch(s) || ipv6.hasMatch(s));
  }

  ConfigVal fromDynamic(dynamic v) {
    ConfigVal cfg = ConfigVal.create();
    if (v is String) {
      if (isEmail(v)) {
        cfg.emailVal = v;
      } else if (isCidr(v)) {
        cfg.cidrVal = utf8.encode(v);
      }
      cfg.stringVal = v;
    }
    if (v is double) {
      cfg.doubleVal = v;
    }
    if (v is num) {
      cfg.uint64Val = v as Int64;
    }
    if (v is bool) {
      cfg.boolVal = v;
    }
    return cfg;
  }
	
  dynamic toDynamic() {
    if (this.hasStringVal()) {
      return this.stringVal;
    }
    else if (this.hasCidrVal()) {
	  return this.cidrVal;
    }
    else if (this.hasEmailVal()) {
	  return this.emailVal;
    }	
    else if (this.hasDoubleVal()) {
	  return this.doubleVal;
    }	
    else if (this.hasUint64Val()) {
	  return this.uint64Val;
    }
    else if (this.hasBoolVal()) {
	  return this.boolVal;
    }	
    return "";	
  }
}
	

`
)
