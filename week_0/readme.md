To create and delete stack via AWS CLI it was installed and configured with the next commands:

`pip3 install awscli --upgrade`

`aws configure`

Then, stack was deployed (optionally, with parameters):

`aws cloudformation create-stack --stack-name week0-CLI --template-body file:////Users/svoitenko/Projects/AWS_course/week_0/week_0_ec2_creation.yml --parameters ParameterKey=EC2InstanceAmiID,ParameterValue=ami-08e2d37b6a0129927`

Status checked:

`aws cloudformation describe-stacks --stack-name week0-CLI`

Deleted:

`aws cloudformation delete-stack --stack-name week0-CLI`