#!/bin/sh
#**************************************************************************************************
# Script Name : gemfireBootstrap.sh
# Version     : 1.0
# Author      : VMware
# Contact     : 
# Description : Script to bootstrap Gemfire v9.10.14
#**************************************************************************************************
# TODO : 
#**************************************************************************************************
# Update History
#**************************************************************************************************
# Ver   Date            Who             Update
#**************************************************************************************************
# 1.0  03-03-2022      VMware           Initial release
#**************************************************************************************************
# WARNING : This script was developed for xxx environment only
#**************************************************************************************************

function waitForPort {

    (exec 6<>/dev/tcp/$1/$2) &>/dev/null
    while [ $? -ne 0 ]
    do
        echo -n "."
        sleep 1
        (exec 6<>/dev/tcp/$1/$2) &>/dev/null
    done
}

# CONFIGURABLE PARAMETERS
export GEMFIREDIR=/home/ec2-user/gemfire
export GEMFIREBINARY="pivotal-gemfire-9.10.14"
# CONFIGURABLE PARAMETERS


echo "[INFO]: Cleanup previous install"
cd
rm -rf ${GEMFIREBINARY}
rm -rf ${GEMFIREDIR}


echo "[INFO]: Install JDK"
sudo yum install java-1.8.0-openjdk -y

echo "[INFO]: Setup new Gemfire environment"
tar -zxvf ${GEMFIREBINARY}.tgz
export GF_HOME=/home/ec2-user/${GEMFIREBINARY}
export CLASSPATH=/home/ec2-user/${GEMFIREBINARY}/lib:$GF_HOME/bin:$CLASSPATH
export PATH=/home/ec2-user/${GEMFIREBINARY}/lib:$GF_HOME/bin:$PATH
vJDKPATH=`ls -lrth /usr/lib/jvm/ | grep jdk | grep drwxr | awk '{print "/usr/lib/jvm/"$9}'`
export JAVA_HOME=${vJDKPATH}/jre
export CLASSPATH=${JAVA_HOME}/bin:$CLASSPATH

echo "[INFO]: Start Gemfire Locator"
mkdir -p ${GEMFIREDIR}/locator_`hostname`
gfsh start locator --name=locator_`hostname` --bind-address=`hostname` --port=41111 --dir=${GEMFIREDIR}/locator_`hostname` --locators=`hostname`[41111] --mcast-port=0 --initial-heap=1024m --max-heap=1024m --log-level=config --J=-XX:+UseParNewGC --J=-XX:+UseConcMarkSweepGC


echo "[INFO]: Start Gemfire Cache Server"
gfsh -e "connect --locator=`hostname`[41111]" -e "start server --name=server1 --server-port=6321"
gfsh -e "connect --locator=`hostname`[41111]" -e "start server --name=server2 --server-port=6322"


echo "[INFO]: Gemfire started...."

sleep 10

echo " "
echo " "
echo " "
echo " "

echo "[INFO]: Showing Gemfire configuration, 1 locator and 2 cach servers:"
gfsh -e "connect --locator=`hostname`[41111]" -e "list members"
