gen-certs:
	./scripts/gen-certs.sh

install-certs: gen-certs
	@kubectl apply -f ./maintemplate-csr-real.yaml
	@kubectl certificate approve maintemplate.default.svc.cluster.local
