#!/bin/bash

# Inject public key into AWS EC2 Linux running AWS Systems Manager, then SSH into machine

# AWS EC2 Details
export INSTANCEID=i-00c6e55a5f0271c62
export INSTANCEIP=13.239.26.48
export INSTANCEOSUSER=ubuntu
export AWSREGION=ap-southeast-2
export AZZONE=ap-southeast-2a
export AWSPROFILE=default

# Create key pair
#export PEMKEY=mykeypair
#aws ec2 create-key-pair --key-name $PEMKEY --profile $AWSPROFILE --query 'KeyMaterial' --output text > $PEMKEY.pem
#chmod 400 $PEMKEY.pem
#ssh-keygen -y -f $PEMKEY.pem > $PEMKEY.pub

export PEMKEY=mykeypair
chmod 400 $PEMKEY.pem
ssh-keygen -t rsa -f /tmp/$PEMKEY

# Inject public key to EC2
aws ec2-instance-connect send-ssh-public-key --instance-id $INSTANCEID --instance-os-user $INSTANCEOSUSER --region $AWSREGION --profile $AWSPROFILE --ssh-public-key "$(cat /tmp/${PEMKEY}.pub)" --availability-zone $AZZONE | jq

# Connect to EC2
ssh -i /tmp/$PEMKEY $INSTANCEOSUSER@$INSTANCEIP
# Currently this fails with "ubuntu@13.239.26.48: Permission denied (publickey).""

# Cleanup - delete key pair
# aws ec2 delete-key-pair --key-name $PEMKEY --profile $AWSPROFILE 
# yes | rm $PEMKEY.*
