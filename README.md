# 1. Infrastructure as Code (IaC) with Terraform
* Task: Create a Terraform configuration to deploy a multi-tier web application.
* Requirements:  

    1.1 VPC with public and private subnets.  

            * tfconfig: /IaC/_modules/network  
            * tfvars: /IaC/development/network/development_vpc.tfvars  

    1.2 Internet Gateway and NAT Gateway.  

            * tfconfig: /IaC/_modules/network  
            * tfvars: /IaC/development/network/development_vpc.tfvars  

    1.3 EC2 instances in private subnets for the application tier. 

            * tfconfig: /IaC/_modules/ec2  
            * tfvars: /IaC/development/ec2/webapp.tfvars  

    1.4 Load Balancer in the public subnet.  

            * tfconfig: /IaC/_modules/elb  
            * tfvars: /IaC/development/elb/webapp_lb.tfvars  

    1.5 RDS instance in the private subnet.  

            * tfconfig: /IaC/_modules/rds   
            * tfvars: /IaC/development/rds/webapp_db.tfvars  


# 2. Automated Deployment with Terraform and CI/CD
* Task: Set up a CI/CD pipeline using Azure DevOps YAML pipelines to automate the deployment of the Terraform configuration.
* Requirements:

    2.1 Source code repository.  
    2.2 Build stage to validate Terraform configuration.  
    2.2 Deploy stage to apply the Terraform configuration.  

            * CI/CD Pipeline: /.azure-pipelines.yml


# 3. Monitoring and Logging with AWS CloudWatch
* Task: Implement monitoring and logging for the deployed application using Terraform.
* Requirements:

    3.1 Set up CloudWatch Alarms for CPU, memory, and disk usage.  
    3.2 Enable CloudWatch Logs for application logs.  
    3.3 Create a CloudWatch Dashboard to visualize the metrics.  

            * tfconfig: /IaC/_modules/monitoring   
            * tfvars: /IaC/development/monitoring/webapp_monitoring.tfvars  

# 4. Security Best Practices
* Task: Review and enhance the security of the deployed application using Terraform.
* Requirements:

    4.1 Implement IAM roles and policies for least privilege access.  
    4.2 Enable AWS WAF to protect against common web exploits.  
    4.3 Set up AWS Shield for DDoS protection.  

            * tfconfig: /IaC/_modules/security   
            * tfvars: /IaC/development/security/webapp_shield.tfvars 
            * WAF is implemented in ELB part of code

# 5. Cost Optimization
* Task: Analyse the cost of the deployed infrastructure and suggest optimizations.
* Requirements:

    5.1 Use AWS Cost Explorer to analyze the cost.  
    5.2 Identify underutilized resources and suggest rightsizing.  
    5.3 Explore Reserved Instances and Savings Plans for cost savings.  

            * Some ideas mentioned here: /Cost_Explorer.md

# 6. Disaster Recovery and Backup
* Task: Implement a disaster recovery plan for the application using Terraform.
* Requirements:

    6.1 Set up automated backups for RDS.  
    6.2 Implement cross-region replication for critical data.  
    6.3 Create a runbook for disaster recovery.  

            * tfconfig: /IaC/_modules/rds   
            * tfvars: /IaC/development/rds/webapp_db.tfvars  
            
        MultiAZ and cross region replication would ensure automatic recovery in case of disaster and minimal downtime
