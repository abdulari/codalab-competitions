#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

NAMESPACE=codalab
kubectl create namespace $NAMESPACE

ls -t ./out/ | head | xargs -I{} kubectl delete -n $NAMESPACE -f ./out/{}
./build.sh
ls -t ./out/ | head | xargs -I{} kubectl apply -n $NAMESPACE -f ./out/{}
