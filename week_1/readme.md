To create stack via AWS CLI (optionally, with parameters) run the next command:

`aws cloudformation create-stack --stack-name week1-CLI --template-body file:////Users/svoitenko/Projects/AWS_course/week_1/week_1_asg_sec_groups_java8.yml --parameters ParameterKey=EC2InstanceAmiID,ParameterValue=ami-08e2d37b6a0129927`

Status checked:

`aws cloudformation describe-stacks --stack-name week1-CLI`

Deleted:

`aws cloudformation delete-stack --stack-name week1-CLI`