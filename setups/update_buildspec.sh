#!/bin/bash

rm -rf ./ECSDemo/buildspec.yml
cp ./setups/buildspec.yml ./ECSDemo/buildspec.yml

cd ./ECSDemo
git add buildspec.yml
git commit -m "Updated buildspec.yml"
git push