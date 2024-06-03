#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Change dir to setup_docker_env, init git, add files, and commit
cd ECSDemo
git init
git add .
git commit -m 'Add simple web site'

# Create a new CodeCommit repository with a name and description
REPO_NAME="$1"
REPO_DESCRIPTION="$2"
AWS_REGION="$3"

# Capture the output of the create-repository command
echo "attempting to create codecommit repo"
CREATE_REPO_OUTPUT=$(aws codecommit create-repository --repository-name $REPO_NAME --repository-description "$REPO_DESCRIPTION" --region $AWS_REGION)

# Extract the clone URL using grep and sed
CLONE_URL=$(echo "$CREATE_REPO_OUTPUT" | grep -o '"cloneUrlHttp":[^,]*' | sed 's/"cloneUrlHttp": "\(.*\)"/\1/')

# Set CodeCommit repo as origin
git remote add origin $CLONE_URL

# Push to CodeCommit
git push -u origin main

# Print success message
echo "Repository created and pushed to CodeCommit successfully!"
