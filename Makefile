APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=thanxx
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64
TAG=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

image:
	docker build . -t ${TAG}

push:
	docker push ${TAG}

build: format
	go get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="kbot/cmd.appVersion=${VERSION}

linux:
	build

macos:
	TARGETOS=macos
	build

windows:
	TARGETOS=windows
	build


clean:
	rm -rf kbot