#!/bin/bash

# Define subscriptions and their resource groups
SUBSCRIPTIONS=(
    "a8140a9e-f1b0-481f-a4de-09e2ee23f7ab:sds-platform-shutter-webapp-sbox-rg"
    "b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb:cft-platform-shutter-webapp-sbox-rg"
    "5ca62022-6aa2-4cee-aaa7-e7536c8d566c:sds-platform-shutter-webapp-prod-rg"
    "8cbc6f36-7c56-4963-9d36-739db5d00b27:cft-platform-shutter-webapp-prod-rg"
    "ed302caf-ec27-4c64-a05e-85731c3ce90e:MTA-STS-Site"
)

# Setting default value for WEBAPP_TOKEN
default_APP="toffee"
default_RESOURCE_GROUP="sds-platform-shutter-webapp-sbox-rg"
DEPLOYMENT_TOKEN=$(az staticwebapp secrets list -n $default_APP -g $default_RESOURCE_GROUP --subscription a8140a9e-f1b0-481f-a4de-09e2ee23f7ab --query "properties.apiKey" -o tsv)
export WEBAPP_TOKEN=$DEPLOYMENT_TOKEN
export WEBAPP_NAME=$default_APP

# Iterate through subscriptions
for SUBSCRIPTION_PAIR in "${SUBSCRIPTIONS[@]}"; do
    IFS=":" read -r SUBSCRIPTION RESOURCE_GROUP <<< "$SUBSCRIPTION_PAIR"
    echo "========================================"
    echo "Setting subscription to: $SUBSCRIPTION"
    az account set --subscription $SUBSCRIPTION
    
    echo "Processing resource group: $RESOURCE_GROUP"
    
    # Get list of static web apps in resource group
    STATIC_WEB_APPS=$(az staticwebapp list --resource-group $RESOURCE_GROUP --query "[].name" -o tsv)
    
    # Iterate through static web apps
    for APP in $STATIC_WEB_APPS; do
        echo "----------------------------------------"
        echo "Processing static web app: $APP in resource group: $RESOURCE_GROUP"
        
        # Get tags for the current static web app
        RepositoryUrl=$(az staticwebapp show -n $APP -g $RESOURCE_GROUP --query repositoryUrl -o tsv)
        if [ -z "$RepositoryUrl" ]; then
            echo "Repository URL is empty for static web app: $APP"
            DEPLOYMENT_TOKEN=$(az staticwebapp secrets list -n $APP -g $RESOURCE_GROUP --query "properties.apiKey" -o tsv)
            # Set WEBAPP_TOKEN
            if [ -z "$DEPLOYMENT_TOKEN" ]; then
                echo "Error: DEPLOYMENT_TOKEN is not set!"
                exit 1
            fi
            export WEBAPP_TOKEN=$DEPLOYMENT_TOKEN
            export WEBAPP_NAME=$APP
        fi        
    done
done