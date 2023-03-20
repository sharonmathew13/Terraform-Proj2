"# Terraform-Project-2" 
1. Created a VPC with CIDR: 10.0.0.0/16 and 2 subnets with CIDR in 10.0.1.0/24 and 10.0.2.0/24.
2. Attached an Internet Gateway and route table.
3. Deploed EC2 instance to the created VPC using auto-scaling group (Desired =2) in which the Apache server is installed.

JENKINS PIPELINE:
   Launched Jenkins server in a new EC2 instance and created a pipeline job with this Git Repository.
   Automated the CHECKOUT, PLAN and Manual Apply in Jenkins.
