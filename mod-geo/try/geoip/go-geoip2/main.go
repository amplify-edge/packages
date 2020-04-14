package main
import (
  "net"
  "github.com/gjbae1212/go-geoip2"
  
)

func main() {
   // db, err := Open("local-file-path")
   db, err := OpenURL("maxmind license key", "GeoLite2-Country", "/tmp",
      geoip2.WithUpdateInterval(6 * time.Hour), geoip2.WithRetries(2), geoip2.WithSuccessFunc(func(){}),...)
   if err != nil {
   	  panic(err)
   }
   
   ip := net.ParseIP("8.8.8.8")
   record, err := db.City(ip)
   if err != nil {
      panic(err)
   }
}