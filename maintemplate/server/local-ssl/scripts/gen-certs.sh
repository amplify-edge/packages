#!/usr/bin/env bash

	cfssl gencert -ca=ca.pem -ca-key=ca-key.pem \
		--config=maintemplate-sign-conf.json \
		-profile=kubernetes maintemplate-sign-conf.json | cfssljson -bare maintemplate-svc

	cp maintemplate-csr.yaml maintemplate-csr-real.yaml
	B64_DECODED=$(awk '1' maintemplate-svc.csr | base64 -w 0)
	sed -i s/b64_here/${B64_DECODED}/ maintemplate-csr-real.yaml



