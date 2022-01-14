#!/bin/bash

APP_NAME="tumo"
APP_ID="${APP_NAME}-0.1"

BASE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "当前目录 ：" $BASE_DIR

OUTPUT_DIR=${BASE_DIR}/output
rm -rf $OUTPUT_DIR
mkdir ${OUTPUT_DIR}
mkdir ${OUTPUT_DIR}/logs
mkdir ${OUTPUT_DIR}/work
mkdir ${OUTPUT_DIR}/public

SRC_DIR=${BASE_DIR}/..
echo "Src目录 : "$SRC_DIR

echo "进入到项目主目录 : "${SRC_DIR}
cd ${SRC_DIR}

echo "====== 1. 开始打包 ======"
mvn clean package -U -Dmaven.test.skip=true

TARGET_DIR=${SRC_DIR}/target
echo "====== 2. 拷贝 jar 包 ======"
cp -f ${TARGET_DIR}/${APP_ID}.jar ${OUTPUT_DIR}/${APP_ID}.jar #拷贝目标war包或者jar包等 至output目录下

echo "====== 3. 拷贝 control.sh 脚本 ======"
cp -f ${BASE_DIR}/control.sh ${OUTPUT_DIR}/control.sh


echo "====== 构建结束 ======="