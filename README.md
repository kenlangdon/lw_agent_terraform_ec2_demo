# Lacework Agent Terraform EC2 Demo Repo
  
### About
A Terraform script to deploy an AWS EC2 instance and install / configure the Lacework Agent automatically.
  
### What you need to run the Terraform
You will need the following:  
 - AWS access  
 - A `pem` key in the AWS IAM  - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
 - Terraform installed  
 - AWS CLI  - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
 - A code editor like VS Code  
  
Here is a script to set up you laptop using `Brew` - https://github.com/anthonygrees/laptop_setup
  
### Setup the Terraform
First you need the code !  
  
```bash
git clone https://github.com/anthonygrees/lw_agent_terraform_ec2_demo

cd lw_agent_terraform_ec2_demo
cd terraform
```
  
Next, create yourself a `terraform.tfvars` file with the following:  
 - node_counter: Is the number of demo VM's you need   
 - lw_token: Is the Lacework Agent Token  
  
Here is an example `tfvars` file:  
```bash
aws_profile = "default"
aws_key_pair_file = "/Users/yourName/.ssh/yourPEMfile.pem"
aws_key_pair_name = "yourPEMfile"
aws_availability_zone = "a"
tag_customer = "testing"
tag_project = "project"
tag_name = "name"
tag_dept = "department"
tag_contact = "yourName@lacework.net"
tag_application = "demo"
tag_ttl = "4"
node_counter = "1"
lw_token = "FAKE9SFSODJOSDFOJ89SF99WUILGFOI;NHFAKE"
linux_node_instance_type = "t3.large"
```
  
### Initiate your Terraform
Execute the terraform. First run the initialise to ensure the plugins you need are installed:  
  
```bash
terraform init
```
  
Before you run Terraform to create your infrastructure, it's a good idea to see what resources it would create. It also helps you verify that Terraform can connect to your AWS account.  
  
```bash
terraform plan
```
  
### Run your Terraform
  
Now run the apply to create the infrastructure.  
  
```bash
terraform apply -auto-approve
```
  
### Apply Complete !
Once the run is complete you will get a list of the `server_ip` addresses.  
  
```bash
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

image_id = ami-091127048df1f044d
route_internet_access_id = rtb-0c8293a365ad2c956
security_group_lw_id = sg-0a81b14c168fc98fb
security_group_ssh_id = sg-0d6d8b4effe83c007
lw_server_id = [
  [
    "i-077bc45345e48aca7",
    "i-08f792a8324121942",
  ],
]
lw_server_public_ip = [
  [
    "52.33.117.188",
    "54.148.76.388",
  ],
]
subnet_private_id = subnet-0132085bfe976b75f
subnet_public_id = subnet-0aefe221eb5ffaf77
vpc_id = vpc-081791ad1bf742a05
```