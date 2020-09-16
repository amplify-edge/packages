// // +build mage

package main

// import (
// 	"fmt"
//
// 	"github.com/magefile/mage/sh"
// )
//
// // mage:import
// //_ "go.zenithar.org/spotigraph/.mage"
//
// const (
// 	ClourProjectID = "winwisely-cloudrun-googlesheet"
// 	Name           = "googlesheet"
// )
//
// // Build googlesheet tool.
// func Gsheet_Build() {
// 	sh.Run("go", "build", "-o", Name, ".")
// }
//
// // Run googlesheet Tests.
// func Gsheet_RunTests() {
// 	sh.RunV("go", "test", "-v")
// }
//
// // Clean googlesheet project.
// func Gsheet_Clean() {
// 	sh.RunV("go", "clean", "-cache")
// 	sh.RunV("go", "clean", "-modcache")
// 	sh.RunV("go", "clean", "-testcache")
// 	sh.RunV("rm", Name)
// }
//
// // Generate dump data.
// func Gsheet_RunDataDump() {
// 	getData("datadump")
// }
//
// // Generate language data.
// func Gsheet_RunLangDump() {
// 	getData("lang")
// }
//
// // Generate Hugo Content.
// func Gsheet_RunHugo() {
// 	getData("hugo")
// }
//
// func getData(option string) {
// 	fmt.Println("Generating Data...")
// 	sh.Run(Name, "-option="+option)
// 	fmt.Println("Done.")
// }
//
// // Cloud
//
// // Auth Cloud
// func Cloud_AUTH() {
// 	sh.RunV("gcloud", "auth", "login")
// 	sh.RunV("gcloud", "config", "set", "project", ClourProjectID)
// 	sh.RunV("gcloud", "config", "set", "run/region", "europe-west1")
// }
//
// // Open Cloud
// func Cloud_Open() {
// 	baseCloudURL := "https://console.cloud.google.com/"
// 	// run
// 	sh.RunV("open", baseCloudURL+"run?project="+ClourProjectID)
// 	// container
// 	sh.RunV("open", baseCloudURL+"cloud-build/builds?project="+ClourProjectID)
// 	// store
// 	sh.RunV("open", baseCloudURL+"storage/browser?project="+ClourProjectID)
// }
//
// // Build Cloud
// func Cloud_Build() {
// 	sh.RunV("gcloud", "build", "submit", "--tag", "gcr.io/"+ClourProjectID+"/identicon-generator")
// }
//
// // Deploy Cloud
// func Cloud_Deploy() {
// 	sh.RunV("gcloud", "beta", "deploy", "--image", "gcr.io/"+ClourProjectID+"/identicon-generator", "--platform", "managed")
// }
