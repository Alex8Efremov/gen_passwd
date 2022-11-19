FROM golang:1.19.3-alpine AS build
WORKDIR /build

COPY . .
RUN go mod init mod && go mod tidy \
    && CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags "-s -w -extldflags '-static'" -o ./app

RUN apk add upx
RUN upx ./app

FROM scratch
COPY --from=build /build/app /app

CMD ["/app"]
