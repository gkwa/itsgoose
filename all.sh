#!/usr/bin/env bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -rf $SCRIPT_DIR/scratch.????

scratch=$(mktemp -d $SCRIPT_DIR/scratch.XXXX)

cd $scratch
docker ps --format "{{.Names}}" --filter name='^/dagger-engine-*' | xargs --no-run-if-empty -I"{}" docker rm --force {}

cd $scratch
tmp=$(mktemp -d $scratch/create-react-app-tmp.XXXX)
time npx create-react-app $tmp/my-app --template typescript
tar cf $tmp/my-app.tar --exclude=node_modules -C $tmp/my-app .
tar --list -f $tmp/my-app.tar

cd $scratch
rm -f README.md
tar xf $tmp/my-app.tar -C $scratch
chmod +x *.sh

cd $scratch
dagger mod init --name=mymod --sdk=go
git init
git add -A
git commit -am Boilerplate

dagger mod install github.com/quartz-technology/daggerverse/node@9ce087b83aa8b85f828d7d92ce39bd7c055cfc0f

cp main-step1.go.txt main.go
dagger functions

cp main-step2.go.txt main.go
dagger functions

cp main-step3.go.txt main.go
dagger functions
dagger call build
