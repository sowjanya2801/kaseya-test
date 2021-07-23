#!/usr/bin/env bash

echo "Creating key pair..."

aws ec2 create-key-pair --key-name ec2-key-pair

echo "Creating ec2 security group with inbound rules..."

aws ec2 create-security-group \
        --group-name ec2-sg \
        --description "EC2 security group"

aws ec2 authorize-security-group-ingress \
        --group-name ec2-sg --protocol tcp \
        --port 3389 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
        --group-name ec2-sg --protocol tcp \
        --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
        --group-name ec2-sg --protocol tcp \
        --port 5985 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
        --group-name ec2-sg --protocol tcp \
        --port 5986 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
        --group-name ec2-sg --protocol tcp \
        --port 8080 --cidr 0.0.0.0/0

echo "Security group created!!"

echo "Launching Windows VM..."

WIN_INSTANCE_ID=$(aws ec2 run-instances \
                      --instance-type t2.small \
                      --image-id ami-03295ec1641924349 \
                      --user-data file://user-data-windows.txt  \
                      --security-groups ec2-sg \
                      --key-name ec2-key-pair \
                      --output text --query 'Instances[*].InstanceId'\
                )

WIN_IP=$(aws ec2 describe-instances \
                --instance-ids $WIN_INSTANCE_ID \
                --query 'Reservations[*].Instances[*].PublicIpAddress' \
                --output text\
        )

aws ec2 wait instance-status-ok --instance-ids $WIN_INSTANCE_ID

echo "Windows instance with instance id $WIN_INSTANCE_ID and IP address $WIN_IP launched!"

echo "Launching Jenkins VM..."

JEN_INSTANCE_ID=$(aws ec2 run-instances \
                      --instance-type t2.small \
                      --image-id ami-0dc2d3e4c0f9ebd18 \
                      --user-data file://user-data-jenkins.sh  \
                      --security-groups ec2-sg \
                      --key-name ec2-key-pair \
                      --output text --query 'Instances[*].InstanceId'\
                )

JEN_IP=$(aws ec2 describe-instances \
                --instance-ids $JEN_INSTANCE_ID \
                --query 'Reservations[*].Instances[*].PublicIpAddress' \
                --output text\
        )

aws ec2 wait instance-status-ok --instance-ids $JEN_INSTANCE_ID

echo "Jenkins instance with instance id $JEN_INSTANCE_ID and IP address $JEN_IP launched!"
