SAMPLE_FSPATH = $(PWD)
LIB_NAME = packer

print:
	@echo SAMPLE_FSPATH: ${SAMPLE_FSPATH}
	@echo GOPATH = ${GOPATH}

# packer
# 1. go-build => build go binary
# 2. go-pack-deb => pack an app to debian package
go-build:
	cd ${SAMPLE_FSPATH} && go build -o ${LIB_NAME} .

go-pack-deb:
	./${LIB_NAME} -config=config/deb.json -version=2.0