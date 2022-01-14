#!/bin/bash

export PATH=$JAVA_HOME/bin:$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

workspace=$(cd $(dirname $0) && pwd -P)
cd $workspace
module="tumo"
app=$module
app_id="$module-0.1"
pidfile=var/${app}.pid
jar="${app_id}.jar"
if [[ -e $pidfile ]]
then
  echo "kill `cat $pidfile`"
  kill -9 `cat $pidfile`
fi
action=$1
profile=$2
case $action in
    "start" )
         # 启动服务, 以前台方式启动, 否则无法托管
         mkdir -p var &>/dev/null
         echo "$jar --spring.profiles.active=$profile"

         # 启动程序
         nohup java -Xms1g -Xmx4g -Duser.timezone=GMT+8 -Dlog4j2.formatMsgNoLookups=true -jar $jar --spring.profiles.active=$profile > ./nohup.log 2>&1 &

         # 记录服务pid
         echo $! > $pidfile
         echo "$app start ok, pid=$!"

        ;;
    * )
        # 非法命令, 已非0码退出
        echo "unknown command"
        exit 1
        ;;
esac