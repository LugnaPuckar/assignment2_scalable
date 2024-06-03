#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

STACK_NAME="${1:-DockerDemo-stack-name}"

# Create a temporary file to replace placeholders in the template
temp_file=$(mktemp)
placeholder_file=./setups/codebuild_placeholder.yml
cp "$placeholder_file" "$temp_file"

# Replace with your AWS account ID
REPLACE_PLACEHOLDER=$(aws sts get-caller-identity --query 'Account' --output text)
sed -i "s/%AWS_ID_PLACEHOLDER%/$REPLACE_PLACEHOLDER/g" "$temp_file"


# Create the stack
aws cloudformation create-stack --stack-name $STACK_NAME --template-body "$(cat $temp_file)" --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
echo "Deploying stack: $STACK_NAME"

# Wait for the stack to be created and then attach the policy to the role
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
echo "Stack created finished: $STACK_NAME"

aws iam attach-role-policy --role-name codebuild-BuildDockerDemo-service-role --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser
echo "Attached role policy to codebuild-BuildDockerDemo-service-role"

# Clean up temporary file
rm "$temp_file"

# Start the build
aws codebuild start-build --project-name BuildDockerDemo > /dev/null 2>&1
