# Terraform LocalStack - Modular Architecture

This project has been refactored into reusable Terraform modules for better organization, maintainability, and scalability.

## Directory Structure

```
terraform-localstack/
├── modules/
│   ├── vpc/              # VPC, Subnet, Internet Gateway, Route Table
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/              # EC2 Instance configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3/               # S3 Bucket with versioning
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── dynamodb/         # DynamoDB Table configuration
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── main.tf               # Root configuration with module calls
├── variables.tf          # Root variables
├── output.tf             # Root outputs
├── terraform.tfvars      # Default variable values
└── README.md             # This file
```

## Modules Overview

### 1. VPC Module (`modules/vpc/`)
Manages VPC infrastructure:
- **aws_vpc**: Main VPC resource
- **aws_subnet**: Public subnet
- **aws_internet_gateway**: Internet Gateway for internet access
- **aws_route_table**: Route table with 0.0.0.0/0 → IGW route
- **aws_route_table_association**: Subnet association with route table

**Variables:**
- `vpc_cidr` (default: "10.0.0.0/16")
- `public_subnet_cidr` (default: "10.0.1.0/24")
- `availability_zone` (default: "us-east-1a")
- `environment` (default: "localstack")

**Outputs:**
- `vpc_id`: VPC ID
- `public_subnet_id`: Public subnet ID
- `internet_gateway_id`: IGW ID
- `route_table_id`: Route table ID

### 2. EC2 Module (`modules/ec2/`)
Manages EC2 instances:
- **aws_ec2_host**: EC2 dedicated host configuration

**Variables:**
- `instance_type` (default: "t2.micro")
- `availability_zone` (default: "us-east-1a")
- `instance_name` (default: "demo-instance")

**Outputs:**
- `ec2_host_id`: EC2 host ID
- `instance_type`: Instance type

### 3. S3 Module (`modules/s3/`)
Manages S3 buckets with versioning:
- **aws_s3_bucket**: S3 bucket
- **aws_s3_bucket_versioning**: Versioning configuration

**Variables:**
- `bucket_name` (default: "localstack-demo-bucket")
- `environment` (default: "localstack")
- `enable_versioning` (default: false)

**Outputs:**
- `bucket_id`: Bucket ID
- `bucket_arn`: Bucket ARN

### 4. DynamoDB Module (`modules/dynamodb/`)
Manages DynamoDB tables with flexible attributes:
- **aws_dynamodb_table**: DynamoDB table with dynamic attributes

**Variables:**
- `table_name` (default: "Users")
- `hash_key` (default: "UserId")
- `billing_mode` (default: "PAY_PER_REQUEST")
- `attributes`: List of table attributes (default: [{ name = "UserId", type = "S" }])
- `environment` (default: "localstack")

**Outputs:**
- `table_name`: Table name
- `table_arn`: Table ARN
- `table_id`: Table ID

## Usage

### Basic Usage

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply

# Destroy resources
terraform destroy
```

### Customizing Variables

Edit `terraform.tfvars` to customize resource configuration:

```hcl
# AWS Provider Configuration
aws_region     = "us-east-1"
aws_access_key = "test"
aws_secret_key = "test"

# Environment
environment = "localstack"

# VPC
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"

# S3
bucket_name       = "my-custom-bucket"
enable_versioning = true

# DynamoDB
dynamodb_table_name = "CustomTable"
dynamodb_attributes = [
  { name = "UserId", type = "S" },
  { name = "Timestamp", type = "N" }
]
```

### Override Variables on Command Line

```bash
terraform apply \
  -var="bucket_name=my-bucket" \
  -var="environment=production"
```

## Module Reusability

Each module is designed to be independently reusable. You can:

1. **Use the same module multiple times** with different configurations:
```hcl
module "s3_prod" {
  source      = "./modules/s3"
  bucket_name = "prod-bucket"
  environment = "production"
}

module "s3_dev" {
  source      = "./modules/s3"
  bucket_name = "dev-bucket"
  environment = "development"
}
```

2. **Copy modules to other projects** - modules are self-contained with all dependencies documented.

3. **Extend modules** by adding more resources or variables as needed.

## Benefits of This Modular Approach

✅ **Reusability**: Modules can be used across multiple projects  
✅ **Maintainability**: Clear separation of concerns  
✅ **Scalability**: Easy to add new resources or modules  
✅ **Testability**: Modules can be tested independently  
✅ **Documentation**: Each module documents its inputs/outputs  
✅ **DRY Principle**: Avoid code duplication  

## LocalStack Endpoints

The configuration uses LocalStack endpoints for local AWS emulation:
- S3: `http://localhost:4566`
- DynamoDB: `http://localhost:4566`
- EC2: `http://localhost:4566`
- IAM: `http://localhost:4566`
- STS: `http://localhost:4566`

Ensure LocalStack is running locally before applying the configuration.

## Output Values

All module outputs are aggregated at the root level. Access them after applying:

```bash
terraform output vpc_id
terraform output s3_bucket_id
terraform output dynamodb_table_name
terraform output ec2_host_id
```

## Troubleshooting

### Variable validation errors
Ensure all required variables are defined in `terraform.tfvars` or passed via command line.

### Module not found errors
Verify the module path in `main.tf` is correct: `source = "./modules/modulename"`

### LocalStack connection errors
Check that LocalStack is running and the endpoints in `main.tf` are correct.

## Next Steps

- Add more modules (RDS, Lambda, SQS, etc.)
- Implement workspace management for multiple environments
- Add Terraform state backends (S3, Terraform Cloud)
- Create reusable module registry for organization-wide use
