FROM golang:latest AS GOLANG

WORKDIR /go/src/app

COPY main.go .

RUN apt-get update && \
    apt-get install -y upx && \
    go build -o app -ldflags "-s -w" main.go && \
    upx --best --lzma app

FROM scratch

WORKDIR /app

COPY --from=GOLANG /go/src/app/app .

ENTRYPOINT [ "./app" ]
