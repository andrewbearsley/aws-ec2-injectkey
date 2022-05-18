#!/bin/bash

# Inject public key into AWS EC2 Linux running AWS Systems Manager, then SSH into machine

# AWS EC2 Details
export INSTANCEID=i-0f9cbd441127d4cd5
export INSTANCEIP=54.252.215.12
export INSTANCEOSUSER=ubuntu
export AWSREGION=ap-southeast-2
export AZZONE=ap-southeast-2a
export AWSPROFILE=default

# Create key pair
export PEMKEY=mykeypair
ssh-keygen -t rsa -f /tmp/$PEMKEY
chmod 400 /tmp/$PEMKEY.pem

# Inject public key to EC2
aws ec2-instance-connect send-ssh-public-key --instance-id $INSTANCEID --instance-os-user $INSTANCEOSUSER --region $AWSREGION --profile $AWSPROFILE --ssh-public-key "$(cat /tmp/${PEMKEY}.pub)" --availability-zone $AZZONE | jq

# Connect to EC2
ssh -i /tmp/$PEMKEY $INSTANCEOSUSER@$INSTANCEIP

# Cleanup - delete key pair
# yes | rm /tmp/$PEMKEY.*
