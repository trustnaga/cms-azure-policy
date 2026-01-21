# Azure Policy Terraform Project

This project provides a set of Terraform modules to deploy Azure Policies at different levels, including Management Groups , Subscriptions  & Resource group. It also includes the capability to create exceptions for policies at various scopes.

## Project Structure

```
azure-policy-terraform
├── modules
│   ├── policy_definition        # Module for defining Azure Policies
│   ├── policy_assignment        # Module for assigning Azure Policies
│   └── policy_exemption         # Module for creating policy exemptions
├── policies                     # Directory for policy definitions
│   ├── built-in                 # Built-in Azure Policies
│   └── custom                   # Custom Azure Policies
├── examples                     # Example usage of the modules
│   ├── apply-to-management-group # Example for applying policies to a management group
│   └── apply-to-subscription     # Example for applying policies to a subscription
├── environments                 # Environment configurations for management groups and subscriptions
|   ├── management-group
|       ├──main.tf
|       ├──variables.tf
|       ├──terraform.tfvars
|       ├──providers.tf
|       └──outputs.tf
|   ├── subscription
|   ├── resource-group
├── providers.tf                 # Provider configurations
├── versions.tf                  # Terraform version requirements
├── backend.tf                   # Backend configuration for state storage
├── variables.tf                 # Root module input variables
├── outputs.tf                   # Root module outputs
└── README.md                    # Project documentation
```

## Modules

### Policy Definition
- **Location:** `modules/policy_definition`
- **Description:** Defines Azure Policy definitions using JSON rules.

### Policy Assignment
- **Location:** `modules/policy_assignment`
- **Description:** Assigns Azure Policies to specified scopes (Management Groups or Subscriptions).

### Policy Exemption
- **Location:** `modules/policy_exemption`
- **Description:** Creates exemptions for specific policies at a given scope.

## Usage

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd cms-azure-policy
   ```

2. **Initialize Terraform:**
   ```
   terraform init
   ```

3. **Plan your deployment:**
   ```
   terraform plan
   ```

4. **Apply your changes:**
   ```
   terraform apply
   ```

## Examples

- **Apply Policies to Management Group:**
  Navigate to `environments/management-group` and follow the instructions in `main.tf`.

- **Apply Policies to Subscription:**
  Navigate to `environments/subscription` and follow the instructions in `main.tf`.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.