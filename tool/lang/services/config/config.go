package config

import (
	"fmt"
	"time"

	"github.com/spf13/viper"
)

var (
	// 'frontend' service

	// RouteWorkerPoolSize is the size of the worker pool used to query `route` service.
	// Can be overwritten from command line.
	RouteWorkerPoolSize = 3

	// 'customer' service

	// MySQLGetDelay is how long retrieving a customer record takes.
	// Using large value mostly because I cannot click the button fast enough to cause a queue.
	MySQLGetDelay = 300 * time.Millisecond

	// MySQLGetDelayStdDev is standard deviation
	MySQLGetDelayStdDev = MySQLGetDelay / 10

	// MySQLMutexDisabled controls whether there is a mutex guarding db query execution.
	// When not disabled it simulates a misconfigured connection pool of size 1.
	MySQLMutexDisabled = false

	// 'driver' service

	// RedisFindDelay is how long finding closest drivers takes.
	RedisFindDelay = 20 * time.Millisecond

	// RedisFindDelayStdDev is standard deviation.
	RedisFindDelayStdDev = RedisFindDelay / 4

	// RedisGetDelay is how long retrieving a driver record takes.
	RedisGetDelay = 10 * time.Millisecond

	// RedisGetDelayStdDev is standard deviation
	RedisGetDelayStdDev = RedisGetDelay / 4

	// 'route' service

	// RouteCalcDelay is how long a route calculation takes
	RouteCalcDelay = 50 * time.Millisecond

	// RouteCalcDelayStdDev is standard deviation
	RouteCalcDelayStdDev = RouteCalcDelay / 4

	// for gtranslate Timeout
	TranslateTimeout = 5 * time.Second
)

// Settings consists of all the application configuration
type Settings struct {
	GoogleSheet map[string]Config
}

// Config struct
type Config struct {
	ID        string
	URL       string
	CSV       string
	Merge     string
	OutDir    string
	FileName  string
	Extension string
}

// New creates an instance of the application's configuration
func New(option string) (*Settings, error) {
	v := viper.New()

	v.SetConfigName(option + "config")
	v.SetConfigType("yml")
	v.AddConfigPath("./config/")

	err := v.ReadInConfig()
	if err != nil {
		return nil, err
	}

	configs := make(map[string]Config)
	for item := range v.AllSettings() {
		data := v.GetStringMap(item)
		configs[item] = Config{
			ID:        fmt.Sprintf("%v", data["id"]),
			URL:       fmt.Sprintf("%v", data["url"]),
			CSV:       fmt.Sprintf("%v", data["csv"]),
			Merge:     fmt.Sprintf("%v", data["merge"]),
			OutDir:    fmt.Sprintf("%v", data["out_dir"]),
			FileName:  fmt.Sprintf("%v", data["file_name"]),
			Extension: fmt.Sprintf("%v", data["extension"]),
		}

	}
	return &Settings{
			GoogleSheet: configs,
		},
		nil
}
