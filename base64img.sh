#!/bin/bash

#作者林英杰  email:11394019@qq.com  2019-04-18
#确保shell 切换到当前shell 脚本文件夹
current_file_path=$(cd "$(dirname "$0")"; pwd)
cd ${current_file_path}

MARKDOWN_FILE_NAME=""

#图片默认是当前目录
IMAGE_PATH=${current_file_path}
SPACE_LINE_NUMBER=100

echo "参数说明: -i 图片路径 -s 空行数量"
while getopts "f:i:s:" opt; do
  case $opt in
    f)
       MARKDOWN_FILE_NAME=$OPTARG
       echo "this is -f the arg is ! $OPTARG"
       ;;
    i)
       IMAGE_PATH=$OPTARG
       echo "this is -i the arg is ! $OPTARG"
       ;;
    s)
      #图像数据之前的空行数量，默认20行
      SPACE_LINE_NUMBER=$OPTARG
      echo "this is -s the arg is ! $OPTARG"
      ;;
    \?)  #没有的参数，会被存储在?中
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

if [[ ! -f $MARKDOWN_FILE_NAME ]];
then
  echo "请输入markdown 文件名"
  exit 1
fi

MARKDOWN_FILE_NAME=$current_file_path/$(basename "$MARKDOWN_FILE_NAME")
echo "文件名=$MARKDOWN_FILE_NAME image_path=$IMAGE_PATH space_line_count=$SPACE_LINE_NUMBER"

cd ${IMAGE_PATH}
image_file_list=$(ls)

for imagefile in $image_file_list
  do
     filename=$(basename "$imagefile")
     fileType="${filename##*.}"
     fileType=$(echo $fileType | tr '[:upper:]' '[:lower:]')
     #filename=$(basename "$imagefile")
     filename_without_extension="${filename%.*}"

     if [[ ($fileType = "jpg") || ($fileType = "jpeg") || ($fileType = "png") || ($fileType = "gif") || ($fileType = "svg") || ($fileType = "webp") || ($fileType = "bmp") || ($fileType = "tif") ]];
     then
         ##![1555555321007](1555555321007.png)
        OLD_IMAGE_PLAYHOLD="\\!\\[${filename_without_extension}\\]"
        NEW_IMAGE_PLAYHOLD="![avatar][${filename_without_extension}]"
        sed -i '' -e "s|$OLD_IMAGE_PLAYHOLD|$NEW_IMAGE_PLAYHOLD|g" $MARKDOWN_FILE_NAME
     fi
  done


#for 循环
for ((i=1; i<=$SPACE_LINE_NUMBER; i++))
  do
    echo -e "\n" >> $MARKDOWN_FILE_NAME
  done


for imagefile in $image_file_list
  do
     filename=$(basename "$imagefile")
     fileType="${filename##*.}"
     fileType=$(echo $fileType | tr '[:upper:]' '[:lower:]')
     #filename=$(basename "$imagefile")
     filename_without_extension="${filename%.*}"

     if [[ ($fileType = "jpg") || ($fileType = "jpeg") || ($fileType = "png") || ($fileType = "gif") || ($fileType = "svg") || ($fileType = "webp") || ($fileType = "bmp") || ($fileType = "tif") ]];
     then
         base64Content=$(base64 $imagefile)
        echo "[${filename_without_extension}]:data:image/${fileType};base64,${base64Content}" >> $MARKDOWN_FILE_NAME
     else
        echo "很抱歉,${imagefile}是图片文件吗？${fileType}格式目前不支持."
     fi

  done

cd ${current_file_path}
