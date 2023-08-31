#!/bin/bash

PROJECT_NAMES_FILE="./v7newprojectnames.txt"
IMAGE_NAMES_FILE="./v7newimagenames.txt"

declare -a project_names=()

project_count=0
for i in $(cat $PROJECT_NAMES_FILE)
do
${project_names[$project_count]}=$i
done