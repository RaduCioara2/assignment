# 1. Infrastructure as Code (IaC) with Terraform
* Task: Create a Terraform configuration to deploy a multi-tier web application.
* Requirements:
1.1 VPC with public and private subnets.
1.2  Internet Gateway and NAT Gateway.
1.3 EC2 instances in private subnets for the application tier.
1.4 Load Balancer in the public subnet.
1.5 RDS instance in the private subnet.

* Objective: Ensure the configuration is modular, reusable, and follows best practices for security and scalability.

# 2. Automated Deployment with Terraform and CI/CD
* Task: Set up a CI/CD pipeline using Azure DevOps YAML pipelines to automate the deployment of the Terraform configuration.
* Requirements:
2.1 Source code repository
2.2 Build stage to validate Terraform configuration.
2.2 Deploy stage to apply the Terraform configuration.

* Objective: Automate the deployment process and ensure zero-downtime deployments.

# 3. Monitoring and Logging with AWS CloudWatch
* Task: Implement monitoring and logging for the deployed application using Terraform.
* Requirements:
3.1 Set up CloudWatch Alarms for CPU, memory, and disk usage.
3.2 Enable CloudWatch Logs for application logs.
3.3 Create a CloudWatch Dashboard to visualize the metrics.

* Objective: Ensure the application is monitored effectively and logs are centralized for troubleshooting.

# 4. Security Best Practices
* Task: Review and enhance the security of the deployed application using Terraform.
* Requirements:
4.1 Implement IAM roles and policies for least privilege access.
4.2 Enable AWS WAF to protect against common web exploits.
4.3 Set up AWS Shield for DDoS protection.

* Objective: Ensure the application follows AWS security best practices and is protected against common threats.

# 5. Cost Optimization
* Task: Analyse the cost of the deployed infrastructure and suggest optimizations.
* Requirements:
5.1 Use AWS Cost Explorer to analyze the cost.
5.2 Identify underutilized resources and suggest rightsizing.
5.3 Explore Reserved Instances and Savings Plans for cost savings.

* Objective: Ensure the infrastructure is cost-effective without compromising performance.

# 6. Disaster Recovery and Backup
* Task: Implement a disaster recovery plan for the application using Terraform.
* Requirements:
6.1 Set up automated backups for RDS.
6.2 Implement cross-region replication for critical data.
6.3 Create a runbook for disaster recovery.
* Objective: Ensure the application can recover quickly from failures and data loss is minimized.

# Deliverables
• Terraform configuration files.
• CI/CD pipeline configuration.
• CloudWatch Dashboard and Alarms.
• Security policies and configurations.
• Cost optimization report.
• Disaster recovery plan and runbook.
Evaluation Criteria
• Completeness: All tasks are completed as per the requirements.
• Best Practices: Solutions follow AWS and Terraform best practices for security, scalability, and cost optimization.
• Documentation: Clear and concise documentation for each task.
• Innovation: Creative and efficient solutions to the given problems.
