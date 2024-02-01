#!/usr/bin/env bash

set -e

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
