#!/bin/bash
#
# Script to build the doozer and doozerd binaries in the current directory
#

set -e
set -x

export GOPATH=`pwd`

# goprotobuf
mkdir -p $GOPATH/src/code.google.com/p/goprotobuf
hg clone -U https://code.google.com/p/goprotobuf $GOPATH/src/code.google.com/p/goprotobuf
cd $GOPATH/src/code.google.com/p/goprotobuf
hg update default
cd $GOPATH/src/code.google.com/p/goprotobuf
cd protoc-gen-go
go install
cd ../proto
go install

# doozer
cd $GOPATH
# cloned into pretty.go because the repo was renamed
git clone git@github.com:kr/pretty.git $GOPATH/src/github.com/kr/pretty.go
# cloned into 'ha', because otherwise we would have to change all the reqs
git clone git@github.com:chartbeat/doozer.git $GOPATH/src/github.com/ha/doozer
cd $GOPATH/src/github.com/ha/doozer
git checkout origin/production
go install
cd $GOPATH/src/github.com/ha/doozer/cmd/doozer
echo -e "package main\n\nconst version = \`0.8+9+g5149113\`\n" > vers.go
go install

# doozerd
cd $GOPATH
# cloned into 'ha', because otherwise we would have to change all the reqs
git clone git@github.com:chartbeat/doozerd.git $GOPATH/src/github.com/ha/doozerd
cd $GOPATH/src/github.com/ha/doozerd
git checkout origin/production
echo -e "package peer;const Version = \`0.8+30+g7f72aca\`\n" > peer/version.go
hg clone -U https://code.google.com/p/go.net $GOPATH/src/code.google.com/p/go.net
cd $GOPATH/src/code.google.com/p/go.net
hg update default
cd $GOPATH/src/github.com/ha/doozerd
go install
