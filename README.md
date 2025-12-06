# Terraform LocalStack Infrastructure

A modular, production-ready Terraform configuration for deploying AWS infrastructure locally using LocalStack. This project demonstrates infrastructure-as-code best practices with reusable modules for VPC, EC2, S3, and DynamoDB.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Outputs](#outputs)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This Terraform project is designed to:
- **Test AWS infrastructure locally** without incurring costs
- **Provide reusable modules** that can be used across projects
- **Follow Terraform best practices** with proper separation of concerns
- **Enable rapid prototyping** of cloud infrastructure
- **Simplify complex deployments** through modularization

### Key Features

✨ **Modular Design** - Each AWS service is encapsulated in its own module  
🔄 **Reusable** - Modules can be instantiated multiple times with different configurations  
📝 **Well Documented** - Comprehensive documentation for each module  
🛡️ **Best Practices** - Follows Terraform and AWS best practices  
🚀 **Local Testing** - Fully compatible with LocalStack for local development  

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform** >= 1.0
  ```bash
  terraform --version
  ```

- **Docker** (for LocalStack)
  ```bash
  docker --version
  ```

- **LocalStack** (running as a Docker container)
  ```bash
  docker-compose up -d
  # OR
  docker run -d -p 4566:4566 localstack/localstack
  ```

- **AWS CLI** (optional, for verification)
  ```bash
  aws --version
  ```

## 📁 Project Structure

```
terraform-localstack/
├── README.md                 # This file
├── MODULES.md               # Detailed module documentation
├── main.tf                  # Root configuration with module calls
├── variables.tf             # Root input variables
├── output.tf                # Root outputs
├── terraform.tfvars         # Variable values (local)
├── terraform.tfvars.example # Example variable template
├── .gitignore              # Git ignore rules
└── modules/                # Reusable modules directory
    ├── vpc/               # VPC networking module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── ec2/               # EC2 instances module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── s3/                # S3 buckets module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── dynamodb/          # DynamoDB tables module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 🧩 Modules

### 1. VPC Module (`modules/vpc/`)

Manages all networking infrastructure:
- **Resources**: VPC, Public Subnet, Internet Gateway, Route Table
- **Default CIDR**: 10.0.0.0/16
- **Features**: Automatic route propagation, public subnet configuration

**Key Variables**:
```hcl
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
availability_zone  = "us-east-1a"
environment        = "localstack"
```

### 2. EC2 Module (`modules/ec2/`)

Manages EC2 instance configuration:
- **Resources**: EC2 Host
- **Default Instance Type**: t2.micro
- **Use Cases**: Compute resources, application hosting

**Key Variables**:
```hcl
instance_type    = "t2.micro"
availability_zone = "us-east-1a"
instance_name    = "demo-instance"
```

### 3. S3 Module (`modules/s3/`)

Manages S3 buckets with versioning:
- **Resources**: S3 Bucket, Bucket Versioning
- **Default Bucket**: localstack-demo-bucket
- **Features**: Optional versioning, environment tagging

**Key Variables**:
```hcl
bucket_name       = "localstack-demo-bucket"
enable_versioning = false
environment       = "localstack"
```

### 4. DynamoDB Module (`modules/dynamodb/`)

Manages DynamoDB tables with flexible attributes:
- **Resources**: DynamoDB Table
- **Default Billing**: PAY_PER_REQUEST
- **Features**: Dynamic attributes, flexible key configuration

**Key Variables**:
```hcl
table_name   = "Users"
hash_key     = "UserId"
billing_mode = "PAY_PER_REQUEST"
attributes = [
  { name = "UserId", type = "S" }
]
```

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/Aashish-cyber/Terraform-Localstack-Infra.git
cd Terraform-Localstack-Infra
```

### 2. Start LocalStack

```bash
docker-compose up -d
# OR
docker run -d -p 4566:4566 localstack/localstack:latest
```

Verify LocalStack is running:
```bash
curl http://localhost:4566/_localstack/health
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Create Variables File

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your desired values if needed.

### 5. Plan the Deployment

```bash
terraform plan
```

### 6. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 7. Verify Resources

```bash
terraform output
```

## ⚙️ Configuration

### Variables Overview

All configuration is managed through `terraform.tfvars`. Key variables include:

```hcl
# AWS Provider
aws_region     = "us-east-1"
aws_access_key = "test"
aws_secret_key = "test"

# Common
environment     = "localstack"
availability_zone = "us-east-1a"

# VPC
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"

# EC2
instance_type = "t2.micro"

# S3
bucket_name       = "localstack-demo-bucket"
enable_versioning = false

# DynamoDB
dynamodb_table_name   = "Users"
dynamodb_hash_key     = "UserId"
dynamodb_billing_mode = "PAY_PER_REQUEST"
dynamodb_attributes = [
  { name = "UserId", type = "S" }
]
```

### Override Variables

You can override variables from the command line:

```bash
terraform apply \
  -var="bucket_name=my-custom-bucket" \
  -var="environment=production" \
  -var="instance_type=t3.small"
```

## 📖 Usage

### Basic Commands

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Generate plan
terraform plan -out=tfplan

# Apply configuration
terraform apply tfplan

# Show resources
terraform show

# Destroy resources
terraform destroy

# Get outputs
terraform output
terraform output vpc_id
```

### Module Usage Examples

#### Using a Single Module

```hcl
module "my_s3" {
  source = "./modules/s3"
  
  bucket_name       = "my-bucket"
  environment       = "dev"
  enable_versioning = true
}
```

#### Multiple Instances

```hcl
module "s3_prod" {
  source = "./modules/s3"
  bucket_name = "prod-bucket"
  environment = "production"
}

module "s3_dev" {
  source = "./modules/s3"
  bucket_name = "dev-bucket"
  environment = "development"
}
```

## 📤 Outputs

After successful deployment, access outputs with:

```bash
terraform output
```

Available outputs:
- `vpc_id` - VPC identifier
- `public_subnet_id` - Public subnet identifier
- `internet_gateway_id` - IGW identifier
- `ec2_host_id` - EC2 host identifier
- `instance_type` - EC2 instance type
- `s3_bucket_id` - S3 bucket identifier
- `s3_bucket_arn` - S3 bucket ARN
- `dynamodb_table_name` - DynamoDB table name
- `dynamodb_table_arn` - DynamoDB table ARN
- `dynamodb_table_id` - DynamoDB table ID

## 🏆 Best Practices

### 1. State Management

Keep your terraform state secure:
```bash
# Don't commit state files
echo "*.tfstate" >> .gitignore
echo "*.tfstate.backup" >> .gitignore
```

### 2. Variable Organization

Use separate `.tfvars` files for different environments:
```bash
terraform apply -var-file="dev.tfvars"
terraform apply -var-file="prod.tfvars"
```

### 3. Module Reusability

Keep modules generic and flexible:
- Use variables for all configurable values
- Avoid hardcoded values
- Document all inputs and outputs

### 4. Code Formatting

Always format your code:
```bash
terraform fmt -recursive
```

### 5. Validation

Validate before applying:
```bash
terraform validate
terraform plan
```

## 🔧 Troubleshooting

### Issue: "Failed to download module"

**Solution**: Check your internet connection and module source paths.

```bash
terraform get -update
```

### Issue: "Provider version constraints not met"

**Solution**: Update the AWS provider.

```bash
terraform init -upgrade
```

### Issue: "Resource already exists in LocalStack"

**Solution**: Either destroy existing resources or change resource names.

```bash
terraform destroy
terraform apply
```

### Issue: "LocalStack connection refused"

**Solution**: Ensure LocalStack is running.

```bash
docker ps | grep localstack
# If not running, start it:
docker-compose up -d
# OR
docker run -d -p 4566:4566 localstack/localstack:latest
```

### Issue: "Access Denied" errors

**Solution**: Check LocalStack credentials in `main.tf`:

```hcl
access_key = "test"    # Default LocalStack credentials
secret_key = "test"
```

## 🔍 Verification

### Check LocalStack Resources

Using AWS CLI with LocalStack endpoint:

```bash
# List S3 buckets
aws s3 ls --endpoint-url=http://localhost:4566

# List EC2 instances
aws ec2 describe-instances --endpoint-url=http://localhost:4566 --region us-east-1

# List DynamoDB tables
aws dynamodb list-tables --endpoint-url=http://localhost:4566 --region us-east-1

# Describe VPCs
aws ec2 describe-vpcs --endpoint-url=http://localhost:4566 --region us-east-1
```

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [LocalStack Documentation](https://docs.localstack.cloud/)
- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [MODULES.md](./MODULES.md) - Detailed module documentation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests.

### Steps to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the MIT License.

## 👤 Author

**Aashish Cyber**

- GitHub: [@Aashish-cyber](https://github.com/Aashish-cyber)
- Repository: [Terraform-Localstack-Infra](https://github.com/Aashish-cyber/Terraform-Localstack-Infra)

## ⚡ Quick Tips

- 💡 Use `terraform plan` before applying to review changes
- 🔒 Never commit `terraform.tfvars` with real credentials
- 📊 Use `terraform graph` to visualize resource dependencies
- 🧹 Run `terraform fmt` regularly to maintain code style
- ✅ Always validate with `terraform validate` before committing

## 🆘 Support

For issues and questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review [MODULES.md](./MODULES.md) for module-specific help
3. Open an issue on GitHub
4. Check LocalStack and Terraform documentation

---

**Happy Infrastructure Coding! 🚀**
