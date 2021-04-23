FROM golang:alpine as builder

WORKDIR /app

COPY src/ .

RUN go mod init edukandalski/main \
  && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main .

FROM scratch

WORKDIR /app

COPY --from=builder /app .

ENTRYPOINT [ "/app/main" ]