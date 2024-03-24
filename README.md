# immunetworkstf - Distributed Training System on AWS with Terraform

## Introduction

This repository contains Terraform configurations for deploying a distributed training system on AWS. The system utilizes various AWS services such as Amazon Cognito, AWS Lambda, API Gateway, and DynamoDB to create a scalable and secure platform for distributed deep learning training.

## Features

- **User Authentication**: Utilizes Amazon Cognito for user authentication and management.
- **Serverless Architecture**: Leveraging AWS Lambda and API Gateway for serverless computing and API management.
- **Data Storage**: Stores user activity logs, training runs, and results in DynamoDB tables.
- **Scalability**: The architecture is designed to scale horizontally to accommodate increased demand for distributed training.
- **Security**: IAM roles are used to manage permissions, ensuring secure access to AWS resources.
- **Customizable**: Easily customizable to fit specific use cases and requirements.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Install Terraform on your local machine.
- Configure AWS credentials with appropriate permissions.
- Have your codebase and Terraform configuration ready.

## Configuration

Modify the `variables.tf` file to set the required variables such as `aws_region`, `user_pool_name`, `SNS_email`, etc. Ensure these are configured according to your requirements.

## Deployment

To deploy the distributed training system, follow these steps:

1. **Terraform Initialization**:
   ```bash
   terraform init
