APP=qa-task
REGISTRY=ghcr.io/thanxx
VERSION=v0.0.1
TARGETOS=linux
TARGETARCH=amd64
TAG=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

image:
	docker build . -t ${TAG} --no-cache

push:
	docker push ${TAG}

build: format
	go get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o app -ldflags "-X="kbot/cmd.appVersion=${VERSION}

linux: 
	build

macos:
	$(MAKE) build TARGETOS=darwin

windows: 
	$(MAKE) build TARGETOS=windows 

clean:
	docker rmi ${TAG}