package utilities

import (
	"github.com/segmentio/ksuid"
)

// TODO @winwisely268: this will be deleted once sys-core exported the utilities.
func NewID() string {
	// Yes discards error
	return ksuid.New().String()
}
