FROM golang:1.15.6 as builder

ENV GOPROXY direct

COPY . /go/src/
WORKDIR /go/src

RUN ./build.sh

ENTRYPOINT ["/go/src/golang-webapp"]

#FROM scratch as runner
#COPY --from=builder /go/src/golang-webapp /app/main
#ENTRYPOINT ["/app/main"]
