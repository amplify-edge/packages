#!/usr/bin/env bash

	cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
		--config=maintemplate/maintemplate-sign-conf.json \
		-profile=kubernetes maintemplate/maintemplate-sign-conf.json | cfssljson -bare maintemplate-svc

	cp maintemplate/maintemplate-csr.yaml maintemplate-csr-real.yaml
	B64_DECODED=$(awk '1' maintemplate-svc.csr | base64 | tr -d '\n')
	if hash gsed 2>/dev/null; then
	  gsed -i s/b64_here/${B64_DECODED}/ maintemplate-csr-real.yaml
	else
	  sed -i s/b64_here/${B64_DECODED}/ maintemplate-csr-real.yaml
	fi

