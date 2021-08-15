#remove directories
rm -rf deploy
# creating directories
mkdir -m 777 deploy
# Get into inside the directory
cd deploy
# copy the war file from package 
cp /var/lib/jenkins/workspace/Package/target/addressbook.war .
# Creating docker file
touch dockerfile
# get inside of the dockerfile
echo "
FROM centos:latest
#Author name
MAINTAINER abc
# get update the image
RUN yum update -y
# Install java package
RUN yum install java-1.8* -y
# install editor
RUN yum install vim -y 
# install nano editor
RUN yum install nano -y
#install wget package
RUN yum install wget -y
# Download the tomcat package 
RUN wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.52/bin/apache-tomcat-9.0.52.tar.gz
#extract the tar file
RUN tar -zxvf apache-tomcat-9.0.52.tar.gz
# Deploy the tomcat
COPY addressbook.war /apache-tomcat-9.0.52/webapps/bin/
# start the catalina service
CMD "/bin/./startup.sh"
# creating the port number
EXPOSE 8080" >> dockerfile
# Build an Image
sudo  docker build -t addressbook:v1 .
