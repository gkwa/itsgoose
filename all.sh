#!/usr/bin/env bash

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -rf $SCRIPT_DIR/scratch.????

tmp2=$(mktemp -d $SCRIPT_DIR/scratch.XXXX)

cd $tmp2
docker ps --format "{{.Names}}" --filter name='^/dagger-engine-*' | xargs --no-run-if-empty -I"{}" docker rm --force {}

cd $tmp2
tmp=$(mktemp -d $tmp2/create-react-app-tmp.XXXX)
time npx create-react-app $tmp/my-app --template typescript
tar cf $tmp/my-app.tar --exclude=node_modules -C $tmp/my-app .
tar --list -f $tmp/my-app.tar

cd $tmp2
rm -f README.md
txtar-x -C $tmp2 $SCRIPT_DIR/payload.txtar
tar xf $tmp/my-app.tar -C $tmp2
chmod +x *.sh
bash -x ./e2e.sh
