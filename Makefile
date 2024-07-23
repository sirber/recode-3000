.PHONY: test build upgrade run

help:
	@echo make [intall, run, test, upgrade, build]

test:
	go test ./...

upgrade:
	go get -u ./...
	go mod tidy

install:
	go get
	go mod tidy

run:
	go run .

build:
	GOOS=linux GOARCH=amd64 go build -ldflags '-s -w' -o ./dist/recode .