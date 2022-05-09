# aws-ec2-injectkey

Problem: Lost private ssh key for AWS EC2 Linux instance<br>
Solution: Inject public ssh key into AWS ECS Linux running AWS Systems Manager, then SSH into machine

## Usage

```
sh ./aws-ec2-injectkey.sh
```

## Clean up afterwards

```bash
aws ec2 delete-key-pair --key-name $PEMKEY --profile $AWSPROFILE
yes | rm $PEMKEY.*
```

## TODO - Work in Progress
The SSH logon does not yet work: it fails with `ubuntu@13.239.26.48: Permission denied (publickey).`
