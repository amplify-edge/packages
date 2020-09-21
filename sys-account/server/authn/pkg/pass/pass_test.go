package pass_test

import (
	"github.com/getcouragenow/packages/sys-account/authn/pkg/pass"
	"github.com/stretchr/testify/assert"
	"testing"
)

type hashAndSalt struct {
	Unhashed string
	Hash     string
}

func TestSec(t *testing.T) {
	t.Log("Given the need to produce hash and salt from plain text password, and verifies it thus.")
	{
		hs := hashAndSalt{
			Unhashed: "MostSecurePassword",
		}
		t.Log("\tHandling hashing and updating hash and salt record.")
		{
			h, err := pass.GenHash(hs.Unhashed)
			assert.NoError(t, err)
			hs.Hash = h
			t.Logf("Successfully created hash: %s\t from plain text password: %s\n", hs.Hash, hs.Unhashed)
		}
		t.Log("\tHandling verification of hash and salt")
		{
			valid, err := pass.VerifyHash(hs.Unhashed, hs.Hash)
			assert.NoError(t, err)
			assert.True(t, valid)
			t.Log("Successfully verified password.")

			valid, err = pass.VerifyHash("RudolfTheRednoseReindeer", hs.Hash)
			assert.NoError(t, err)
			assert.False(t, valid)
			t.Log("Successfully invalidates invalid password.")
		}
	}

}
