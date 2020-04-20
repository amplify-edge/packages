package keyutil

import (
	"crypto"
	"crypto/ed25519"
	"crypto/rand"
	"crypto/rsa"
	"encoding/base64"
	"fmt"
	jose "github.com/square/go-jose/v3"
	"os"
	"text/template"
)

type KeyType int

// EncodedKeyPairs contains keypairs for signing JWTs.
type encodedKeyPairs struct {
	Pub  string
	Priv string
}

func newEncodedKeyPairs(pub, priv []byte) *encodedKeyPairs {
	return &encodedKeyPairs{
		Pub:  base64.StdEncoding.EncodeToString(pub),
		Priv: base64.StdEncoding.EncodeToString(priv),
	}
}

const (
	RSA KeyType = iota
	ECC
)

var (
	filename        = "keypair-secrets"
	secretsTemplate = `apiVersion: v1
kind: Secret
type: Opaque
metadata:
    name: signing-keys
data:
    publicKey: {{ .Pub }}
    privateKey: {{ .Priv }}
`
)

func (k *KeyType) String() string {
	return [...]string{"RSA", "ECC"}[*k]
}

func (k *KeyType) generateAlgo() string {
	switch *k {
	case RSA:
		return string(jose.HS512)
	case ECC:
		return string(jose.EdDSA)
	default:
		return string(jose.HS512)
	}
}


func (k *KeyType) GenSigningKeys(path string) error {
	pubKey, privKey, err := k.genSigningKey()
	if err != nil {
		return err
	}
	alg := k.generateAlgo()
	// private keys
	priv := jose.JSONWebKey{Key: privKey, KeyID: "", Algorithm: alg, Use: "sig"}
	fprint, err := priv.Thumbprint(crypto.SHA256)
	if err != nil {
		return err
	}
	// kid
	kid := base64.URLEncoding.EncodeToString(fprint)
	priv.KeyID = kid
	// public keys
	pub := jose.JSONWebKey{Key: pubKey, KeyID: kid, Algorithm: alg, Use: "sig"}
	jpriv, err := priv.MarshalJSON()
	if err != nil {
		return err
	}
	jpub, err := pub.MarshalJSON()
	if err != nil {
		return err
	}
	t := template.Must(template.New(filename).Parse(secretsTemplate))
	ekp := newEncodedKeyPairs(jpub, jpriv)
	return writeSecrets(t, ekp, path)
}

func writeSecrets(tpl *template.Template, ekp *encodedKeyPairs, path string) error {
	fname := fmt.Sprintf("%s/%s.yaml", path, filename)
	file, err := os.OpenFile(fname, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0644)
	if err != nil {
		return err
	}
	return tpl.Execute(file, ekp)
}

func (k *KeyType) genSigningKey() (crypto.PublicKey, crypto.PrivateKey, error) {
	switch *k {
	case ECC:
		return ed25519.GenerateKey(rand.Reader)
	case RSA:
		// we opt for 4096, even though 2048 may suffice.
		priv, err := rsa.GenerateKey(rand.Reader, 4096)
		if err != nil {
			return nil, nil, err
		}
		return priv.Public(), priv, err
	default:
		return nil, nil, fmt.Errorf("unknown alg specified: %s", k.String())
	}
}
