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

## Architecture Overview

The architecture follows a microservices-based approach, leveraging serverless computing and managed services offered by AWS. Here's a high-level overview of the architecture:

1. **Amazon Cognito User Pool**:
   - Responsible for user authentication and management.
   - Allows users to sign up, sign in, and manage their accounts securely.
   - Provides user authentication tokens for accessing resources within the system.

2. **AWS Lambda Functions**:
   - Serverless functions that execute code in response to various events.
   - Used for handling user activities, managing training runs, and processing results.
   - Each function is associated with specific API Gateway endpoints for triggering execution.

3. **API Gateway**:
   - Provides HTTP endpoints for accessing Lambda functions.
   - Acts as a front-end interface for users to interact with the system.
   - Routes requests to the appropriate Lambda function based on the API endpoint.

4. **DynamoDB Tables**:
   - NoSQL database service for storing data related to user activities, training runs, and results.
   - Tables include schemas for storing user profiles, activity logs, run metadata, and result data.
   - Ensures scalability, durability, and low-latency access to data.

5. **IAM Roles**:
   - Manages permissions for accessing AWS resources securely.
   - Provides fine-grained control over which resources each Lambda function can access.
   - Ensures least privilege access to AWS services, enhancing security.


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