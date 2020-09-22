package utilities

import (
	"github.com/segmentio/ksuid"
)

func NewID() string {
	// Yes discards error
	return ksuid.New().String()
}
