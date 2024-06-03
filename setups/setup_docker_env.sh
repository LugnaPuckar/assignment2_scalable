#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# cloning forked repo with adjusted FROM Dockerfile. Original is LarsAppel/ECSDemo
# git clone https://github.com/larsappel/ECSDemo.git
git clone https://github.com/LugnaPuckar/ECSDemo.git
cd ECSDemo
rm -rf .git