FROM quay.io/projectquay/golang:1.20 as builder
LABEL org.opencontainers.image.source="https://github.com/thanxx/prometheus-qa-task"
WORKDIR /go/src/app
COPY . .
RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app .

ENTRYPOINT [ "./app" ]
