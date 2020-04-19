package keyutil

import (
	"crypto"
	"crypto/ed25519"
	"crypto/rand"
	"crypto/rsa"
	"encoding/base64"
	"fmt"
	jose "github.com/square/go-jose/v3"
	"io"
	"os"
)

type KeyType int

const (
	RSA KeyType = iota
	ECC
)

func (k *KeyType) String() string {
	return [...]string{"RSA", "ECC"}[*k]
}

func (k *KeyType) generateAlgo() string {
	switch *k {
	case RSA:
		return string(jose.RS384)
	case ECC:
		return string(jose.EdDSA)
	default:
		return string(jose.RS256)
	}
}

func (k *KeyType) GenSigningKeys(path string) error {
	pubKey, privKey, err := genSigningKey(k.String())
	if err != nil {
		return err
	}
	alg := k.generateAlgo()
	priv := jose.JSONWebKey{Key: privKey, KeyID: "", Algorithm: alg, Use: "sig"}
	fprint, err := priv.Thumbprint(crypto.SHA256)
	if err != nil {
		return err
	}
	kid := base64.URLEncoding.EncodeToString(fprint)
	priv.KeyID = kid
	pub := jose.JSONWebKey{Key: pubKey, KeyID: kid, Algorithm: alg, Use: "sig"}
	jpriv, err := priv.MarshalJSON()
	if err != nil {
		return err
	}
	jpub, err := pub.MarshalJSON()
	if err != nil {
		return err
	}
	return writeJsonKeys(jpriv, jpub, path, kid)
}

func writeJsonKeys(priv []byte, pub []byte, path string, kid string) error {
	basefilename := fmt.Sprintf("%s/jwk-%s-%s", path, "sig", kid)
	pubFile := fmt.Sprintf("%s-public.json", basefilename)
	privFile := fmt.Sprintf("%s-private.json", basefilename)

	err := writeToFile(pub, pubFile, 0444)
	if err != nil {
		return err
	}
	err = writeToFile(priv, privFile, 0400)
	if err != nil {
		return err
	}
	return nil
}

func writeToFile(bytedata []byte, name string, filemode os.FileMode) error {
	file, err := os.OpenFile(name, os.O_WRONLY|os.O_CREATE|os.O_EXCL, filemode)
	if err != nil {
		return err
	}
	n, err := file.Write(bytedata)
	if err == nil && n < len(bytedata) {
		err = io.ErrShortWrite
	}
	if errClose := file.Close(); err == nil {
		err = errClose
	}
	return err
}

func genSigningKey(alg string) (crypto.PublicKey, crypto.PrivateKey, error) {
	switch alg {
	case "ECC":
		return ed25519.GenerateKey(rand.Reader)
	case "RSA":
		// we opt for 4096, even though 2048 may suffice.
		priv, err := rsa.GenerateKey(rand.Reader, 4096)
		if err != nil {
			return nil, nil, err
		}
		return priv.Public(), priv, err
	default:
		return nil, nil, fmt.Errorf("Unknown alg specified: %s", alg)
	}
}
