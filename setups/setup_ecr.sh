#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run the AWS CLI command to create the repository and capture the output
CREATE_REPO_OUTPUT=$(aws ecr create-repository --repository-name dockerdemo)

# Extract the repository URI
REGISTRY_URI=$(echo "$CREATE_REPO_OUTPUT" | grep -o '"repositoryUri":[^,]*' | sed 's/"repositoryUri": "\(.*\)\/[^/]*"/\1/')

# Extract the repository name
IMAGE_NAME=$(echo "$CREATE_REPO_OUTPUT" | grep -o '"repositoryName":[^,]*' | sed 's/"repositoryName": "\(.*\)"/\1/')

# Extract the AWS region from the repository URI
REGION=$(echo "$REGISTRY_URI" | awk -F'.' '{print $4}')

# Copies template file and replaces placeholders with values.
TEMPLATE_FILE="./setups/buildspec_template.yml"
OUTPUT_FILE="./setups/buildspec.yml"
cp "$TEMPLATE_FILE" "$OUTPUT_FILE"

sed -i "s|<registry uri>|$REGISTRY_URI|g" "$OUTPUT_FILE"
sed -i "s|<image name>|$IMAGE_NAME|g" "$OUTPUT_FILE"
sed -i "s|<region>|$REGION|g" "$OUTPUT_FILE"