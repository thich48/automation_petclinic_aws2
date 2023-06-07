#!/bin/bash

sudo apt-get update
wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.6.3 /opt/maven
sudo nano /etc/profile.d/maven.sh


export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

sudo chmod u+x,g+x,o+x /etc/profile.d/maven.sh

./setup_platform.sh
