FROM golang:alpine as builder

WORKDIR /go/src/app

COPY /app .

RUN go mod download

RUN CGO_ENABLED=0 go build -o /app app.go

FROM scratch

COPY --from=builder /app /app

EXPOSE 80

CMD ["/app"]