.PHONY: \
	build \
	windowsbuild \
	macbuild \

GO_PATH = $(shell echo $(GOPATH) | awk -F':' '{print $$1}')
GO_SRC = $(shell pwd | xargs dirname | xargs dirname | xargs dirname)
DEPLOY_PATH := build/
BIN_NAME := bioschema-goweb
VERSION=$(shell git describe --tags)
BUILD=$(shell date +%FT%T%z)
LDFLAGS=-ldflags "-X main.version=${VERSION} -X main.buildDate=${BUILD}"

build:
	go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)$(BIN_NAME) main.go

windowsbuild:
	env GOOS=windows GOARCH=amd64 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)windows/64/$(BIN_NAME) main.go
	env GOOS=windows GOARCH=386 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)windows/x86/$(BIN_NAME) main.go

linuxbuild:
	env GOOS=linux GOARCH=amd64 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)linux/64/$(BIN_NAME) main.go
	env GOOS=linux GOARCH=386 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)linux/x86/$(BIN_NAME) main.go

macbuild:
	env GOOS=darwin GOARCH=amd64 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)darwin/64/$(BIN_NAME) main.go
	env GOOS=darwin GOARCH=386 go build -i -v $(LDFLAGS) -o $(DEPLOY_PATH)darwin/x86/$(BIN_NAME) main.go

build-all: windowsbuild linuxbuild	macbuild