#!/bin/bash


PROJECT_NAMES_FILE="./v7newprojectnames.txt"
IMAGE_NAMES_FILE="./v7newimagenames.txt"

declare -a project_names=()
declare -a image_names=()

project_count=0

for i in $(cat $PROJECT_NAMES_FILE)
do
    project_names[$project_count]=$i
    project_count=$(($project_count+1))
done


#echo -e "Project names are : ${project_names[*]}"

for j in "${project_names[@]}"
do
    echo -e "\033[1;32mProject Name is : \033[0m$j"
done


##IMAGE names
image_count=0
for i in $(cat $IMAGE_NAMES_FILE)
do
    image_names[$image_count]=$i
    image_count=$(($image_count+1))
done


for j in "${image_names[@]}"
do
    echo -e "\033[1;33mImage Name is : \033[0m$j"
done

