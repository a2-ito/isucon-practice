#!/bin/bash

go get github.com/go-martini/martini
go get github.com/go-sql-driver/mysql
go get github.com/martini-contrib/render
go get github.com/martini-contrib/sessions
go get -u cloud.google.com/go/profiler
go build -o golang-webapp .
