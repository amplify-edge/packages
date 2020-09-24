// package pass
// provides password generation and verification using argon2id
// encoded passwords are stored in the format of:
// $<ARGON_ALGO (i'm using argon2id)>$<version>:$MEM,ITER,PAR:$<SALT>:$<KEY>
package pass

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"errors"
	"fmt"
	"strings"

	"golang.org/x/crypto/argon2"
)

var (
	ErrWrongHash           = errors.New("error: incorrect hash format")
	ErrIncompatibleVersion = errors.New("error: incompatible version of argon algorithm")
)

// Hashing Parameter
// TODO: Parameterize this
const (
	MEM     = 64 * 1024
	ITER    = 1
	PAR     = 2
	SLENGTH = 16
	KLENGTH = 32
)

func GenHash(password string) (hash string, err error) {
	s, err := genRandBytes(SLENGTH)
	if err != nil {
		return "", err
	}

	k := argon2.IDKey([]byte(password), s, ITER, MEM, PAR, KLENGTH)

	salt := base64.RawStdEncoding.EncodeToString(s)
	key := base64.RawStdEncoding.EncodeToString(k)

	hash = fmt.Sprintf(
		"$argon2id$v=%d$m=%d,t=%d,p=%d$%s$%s",
		argon2.Version, MEM, ITER, PAR, salt, key)
	return base64.RawStdEncoding.Strict().EncodeToString([]byte(hash)), nil
}

func VerifyHash(password, hash string) (match bool, err error) {
	salt, key, err := decodeHash(hash)
	if err != nil {
		return false, err
	}

	otherKey := argon2.IDKey([]byte(password), salt, ITER, MEM, PAR, KLENGTH)

	keyLen := int32(len(key))
	otherKeyLen := int32(len(otherKey))

	if subtle.ConstantTimeEq(keyLen, otherKeyLen) == 0 {
		return false, nil
	}
	if subtle.ConstantTimeCompare(key, otherKey) == 1 {
		return true, nil
	}
	return false, nil
}

func genRandBytes(n uint64) ([]byte, error) {
	b := make([]byte, n)
	_, err := rand.Read(b)
	if err != nil {
		return nil, err
	}

	return b, nil
}

func decodeHash(hash string) (salt, key []byte, err error) {
	v, err := base64.RawStdEncoding.DecodeString(hash)
	if err != nil {
		return nil, nil, ErrWrongHash
	}
	vals := strings.Split(string(v), "$")
	if len(vals) != 6 {
		return nil, nil, ErrWrongHash
	}

	var version int
	_, err = fmt.Sscanf(vals[2], "v=%d", &version)
	if err != nil {
		return nil, nil, err
	}
	if version != argon2.Version {
		return nil, nil, ErrIncompatibleVersion
	}

	salt, err = base64.RawStdEncoding.DecodeString(vals[4])
	if err != nil {
		return nil, nil, err
	}

	key, err = base64.RawStdEncoding.DecodeString(vals[5])
	if err != nil {
		return nil, nil, err
	}

	return salt, key, nil
}
