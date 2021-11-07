PROJECTNAME=$(shell basename "$(CURDIR)")
OUTPUT=$(PROJECTNAME)

all: build

build:
	go build -v -o $(OUTPUT) ./server
	go build -v -o $(OUTPUT) ./client

test:
	gotest -v -cover -coverprofile=coverage.out ./server
	gotest -v -cover -coverprofile=coverage.out ./client

cover: test
	go tool cover -func=coverage.out

format:
	find . -name \*.go -and -not -name \*.pb.go -and -not -name \*.gen.go | xargs goimports -w
	
run:
	go run .

clean:
	go clean

.PHONY: build test cover format run clean

