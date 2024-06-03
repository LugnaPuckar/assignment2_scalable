#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

PauseAndWait(){
    # Pause execution and wait for user input before proceeding
    read -n 1 -s -r -p "Press any key to continue..."
}

./setups/setup_docker_env.sh
echo "################## done setup docker env"
PauseAndWait

# Create a new CodeCommit repository with a name and description
DEFAULT_NAME="dockerdemo"
DESCRIPTION="Docker Demo Repository"
AWS_REGION="eu-west-1"

./setups/setup_aws_codecommit.sh "$DEFAULT_NAME" "$DESCRIPTION" "$AWS_REGION"
echo "################ done setup codecommit"
PauseAndWait

./setups/setup_ecr.sh
echo "################# done setup ecr"
PauseAndWait

./setups/update_buildspec.sh
echo "################# done update buildspec"
PauseAndWait

./setups/setup_codebuild_project.sh "$DEFAULT_NAME"
echo "################# done setup codebuild"
PauseAndWait