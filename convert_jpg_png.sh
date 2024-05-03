#!/bin/bash

convert_image(){
cd ../images
if [ ! -d png ]
then
	mkdir png
fi

for image in *.jpg
do
	echo "converting image: " $image
	local image_without_ext=$(ls $image | awk -F. '{print $1}')
	convert $image_without_ext.jpg png/$image_without_ext.png
done
}

convert_image 2 > logs.txt
if [ $? -eq 0 ]
then
	echo "success"
else
	echo "error" $?
fi
