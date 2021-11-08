#!/bin/bash

TIMESTAMP=$(date +"%y%m%d-%H%M%S")
DEPLOY_NAME="vwan-deploy-$TIMESTAMP"
LOCATION="westeurope"
TEMPLATEFILE="./main.bicep"

az deployment sub create --name $DEPLOY_NAME --location $LOCATION --template-file $TEMPLATEFILE