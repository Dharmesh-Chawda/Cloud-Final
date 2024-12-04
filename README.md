# Cloud Application Deployment using Terraform

This project demonstrates the deployment of a cloud-based messaging application using Terraform. The infrastructure includes AWS services such as DynamoDB, Lambda, SQS, and API Gateway. The goal is to automate resource provisioning and ensure scalability, reliability, and performance.

---

## **Architecture Overview**

The architecture consists of the following components:

- **API Gateway**: Acts as the entry point for the application, providing RESTful endpoints for client interactions.
- **Lambda Function**: Handles backend business logic and interacts with other AWS services.
- **DynamoDB**: NoSQL database to store application data such as messages.
- **SQS Queue**: Ensures asynchronous message processing.
- **CloudWatch Logs**: Monitors application logs and metrics.

---

## **Project Structure**

```
Cloud-App/
├── modules/
│   ├── dynamodb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── lambda/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── sqs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable definitions
├── output.tf         # Output definitions
├── lambda.zip        # Deployment package for Lambda
├── .gitignore        # Git ignore file
├── README.md         # Project documentation
```

---

## **Prerequisites**

Before deploying the infrastructure, ensure you have the following:

- AWS CLI installed and configured with appropriate permissions.
- Terraform installed (v1.0+).
- Python installed for packaging the Lambda function.

---

## **Deployment Steps**

### **1. Clone the Repository**
```bash
git clone https://github.com/Dharmesh-Chawda/Cloud-Final.git
cd Cloud-Final
```

### **2. Initialize Terraform**
Run the following command to initialize Terraform and download the required provider plugins:
```bash
terraform init
```

### **3. Validate the Configuration**
Ensure the configuration files are valid:
```bash
terraform validate
```

### **4. Plan the Deployment**
Preview the resources that will be created:
```bash
terraform plan
```

### **5. Deploy the Infrastructure**
Apply the Terraform configuration to create the infrastructure:
```bash
terraform apply
```

### **6. Test the Application**
- Use the **API Gateway Endpoint** (output after deployment) to send POST requests to the `/messages` endpoint.
- Verify that messages are stored in DynamoDB and processed through SQS.

---

## **Project Outputs**

After a successful deployment, Terraform will provide the following outputs:

- **API Gateway Endpoint**: The REST API URL.
- **DynamoDB Table Name**: The name of the DynamoDB table created.
- **Lambda Function ARN**: The ARN of the deployed Lambda function.

---

## **Clean Up**

To avoid incurring unnecessary costs, destroy the infrastructure when it's no longer needed:
```bash
terraform destroy
```

---

## **Notes**

- Ensure that sensitive files like `terraform.tfstate` are not pushed to version control by using `.gitignore`.
- If you encounter large file errors during `git push`, confirm that the `.terraform/` folder is excluded.

---

## **License**

This project is licensed under the MIT License.
