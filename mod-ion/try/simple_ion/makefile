build-asti:
	# go install github.com/asticode/go-astilectron-bundler/astilectron-bundler
	cd webrtc/example/desktop && astilectron-bundler
	cd webrtc/example/desktop/output/darwin-amd64/ION\ Desktop\ App.app/Contents/ && cp -r . ../../../../../../../go/dlib/darwin
	cd webrtc/example/desktop/output/linux-amd64/ && cp -r . ../../../../../go/dlib/linux
	cd webrtc/example/desktop/output/windows-386/ && cp -r . ../../../../../go/dlib/windows

hover-run:
	cd example && hover run