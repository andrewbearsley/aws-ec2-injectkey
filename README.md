# aws-ec2-injectkey

Problem: Lost private ssh key for AWS EC2 Linux instance<br>
Solution: Inject public ssh key into AWS ECS Linux running AWS Systems Manager, then SSH into machine

## Usage

```console
sh ./aws-ec2-injectkey.sh
```

## Clean up afterwards

```console
aws ec2 delete-key-pair --key-name $PEMKEY --profile $AWSPROFILE
yes | rm $PEMKEY.*
```
