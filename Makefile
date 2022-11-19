SHELL=/bin/bash
APP=app
export PORT=3200
export SERVICE=gen_passwd
.DEFAULT_GOAL := up

init: down
	@go mod init mod && go mod tidy

build:
	@go build -o ${APP} *.go 

up: build
	@./${APP}

down:
	@[ -f go.mod ] && bash -c 'rm go.mod go.sum' || echo go.mod go.sum are not exist
	@[ -f ${APP} ] && rm ${APP} || echo ${APP} are not exist

.PHONY: all

all: down init build up

docker-build:
	docker build --network=host --no-cache -t ${SERVICE} .

docker-run: docker-down
	docker compose up -d

docker-down:
	docker compose down

docker-all: docker-build docker-run