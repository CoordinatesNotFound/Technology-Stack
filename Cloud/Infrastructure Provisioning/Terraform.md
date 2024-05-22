# Terraform



## 1 Introduction to Terraform

> [What is Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/intro)



### 1.1 IaC

- Background: DevOps
  - Emphasize the collaboration and communication of both software developers and IT operations teams
  - Automate the process of software delivery and infrastructure changes

- What is IaC
  - With IaC, one can write code in files to define, provision, and manage your infratructure.
- Problems of DevOps that IaC can solve
  - Inability to scale rapidly
  - Operational bottlenecks
  - Disconnected feedback loops
  - High manual errors
- Benifits of IaC
  - Declarative: specify the desired state of infrastructure, not updates
  - Code Management: commit, version, trace, and collaborative, just like source code
  - Auditable: compare infrastructure between desired state and current state
  - Portable: build reusable modules across an organization

> IaC vs. Configuration Management
>
> - IaC refers to provisioning a VM instance
> - Configuration Management refers to package configuration and software management inside a VM



### 1.2 Terraform

- What is Terraform
  - an open source IaC tool created by HashiCorp that lets you provision Cloud resources with declarative configuration files
- Features of Terraform
  - Multi-cloud, multi-API
  - Open cire with enterprise support
  - Large community
  - Infrastructure provisioning
- Benefits
  - Provision resources
  - Create resource dependencies
  - Standarize configuration
  - Validate inputs to resource arguments
- Workflow of Terraform
  1. Author
     - You author the configuration, code for the infrastructure you want to create. Referring to our example, during this phase, you code the configuration of the instances and the VPC network. You then organize your code in configuration files, such as variables, main, and tfvars.
  2. Initiliaze
     - During this phase, you run the terraform init command, which initializes the Terraform configuration directory and installs (Google Cloud) as the provider.
  3. Plan
     - You run the terraform plan command. The terraform plan command provides an execution plan for the resources created, changed, or destroyed as per the configuration defined in the author phase. You can then review the plan before applying it to your cloud infrastructure.
  4. Apply
     - Apply it to create the infrastructure and a state file.



### 1.3 Using Terraform

- Using Terraform
  1. Terraform recognizes configuration files written in .tf file
  2. Terraform generates an execution plan
  3. Terraform uses this plan to create infrastructure
  4. Terraform determines the changes and creates incremental execution plans
- Running Terraform in Production
  - Terraform Open Source
  - Terraform Cloud
  - Terraform Enterprise



## 2 Terms and Concepts



### 2.1 Terraform Configurations & HCL

```
-- main.tf
	-- servers/
		 -- main.tf
		 -- provider.tf
		 -- variables.tf
		 -- outputs.tf
```

- Terraform Directory
  - Terraform uses configuration files to declare an infrastructure element
  - The configuration is written in terraform language witha `.tf `extension
  - A configuration consists of:
    - A root module/ root configuration
    - Zero or more child modules
    - Variable.tf (optional but recommended)
    - Outputs.tf (optional but recommended)

- HCL (HashiCorp Configuration Language)

  - Terraform's configuration language for creating and managing API-based resources

  - Configuration language, not a programming language

  - HCL Syntax
    ```
    <BLOCK TYPE> "<BLOCK_LABEL>" "<BLOCK_LABEL>" {
    	# Block body
    	<IDENTIFIER> <EXPRESSION> #Argument
    }
    ```

    - Blocks
    - Arguments
    - Identifiers
    - Expressions
    - Comments

    

### 2.2 Author Phase

- Resources
  ```
  resource "resource_type" "resource_name" {
  	# resource specific arguments
  }
  ```

  - Code blocks that define the infrastructure components
    - e.g. Cloud Storage Bucket
  - Terafform uses the resource type and the resource name to identify an infrastructure element

- Providers
  ```
  terraform {
  	required_providers {
  		google = {
  			source = "hashicorp/google"
  			version = "4.23.8"
  		}
  	}
  }
  
  provider "google" {
  	# configuration options
  	project = <projhect_id>
  	region = "us-central"
  }
  ```

  - Impelement every resource type
  - Terraform downloads the provider plugin in the root configuration when the provider is declared

- Variables

  - Parameterize resource arguments to eliminate hard coding its value
  - Define a resource attribute at runtime or centrally in a file with a .tfvars extension

- Outputs

  - Output values are stored in output.tf file
  - Output values expose values of resource attributes

- State

  - Terraform saves the state pf resources it manages in a state file
  - The state file can be stored:
    - Locally(default)
    - Remotely in a shared location

- Module

  - A Terraform module is a set of Terraform configuration files in a single directory
  - It is the primary method for code reuse in Terraform

  - There are 2 kinds of sources:
    - Local: Source within your directory
    - Remote: Source outside your directory



### 2.3 Terraform Commands

- `terraform init`
  - Initialize Terraoform: download the provider plugins, and initialize the module
- `terraform plan`
  - Create an execution plan: preview execution plan for resources created, modified, or destroyed, in order to ensure the update can reach the desired state.
- `teraform apply`
  - Execute the plan: executes the actions proposed in a Terraform plan, creates the resources and establishes the dependencies.
- `terraform fmt`
  - Format: enforce code convention best practices.
- `terraform destroy`
  - Destroy resources: behaves as if all resources have been removed from configuration



### 2.4 Terraform Validator

- A tool for enforcing policy compliance as part of an infrastructure
- Security and governance team can set up constraints
  - Constraints define the source of truth for security and governance requirements
  - Constraints must be compatible with tools across every stage of the application cycle



## 3 Writing Infrastructure Code



### 3.1 Resources

- Introduction to Resources

  - Concept

    - Resources are infrastructure elements on Terraform
    - Terraform uses underlying APIs of each Google Cloud service to deploy your resources

  - Syntax
    ```
    resource "resource_type" "resource_name" {
    	# resource specific arguments
    }
    ```

    - Resources are defined within a .tf file
    - The resource block represents a single infrastructure object
    - The `resource type` identify the type of resource being created, depending on the provider being declared within a terraform module

  - A configuration file can include multiple resources

    - A resource can refer to another resource's attribute, only when resources are defined within the same configuration
      ```
      resource "google_compute_network" "vpc_network" {
      	...
      }
      
      resource "google_compute_subnetwork" "subnetwork-ipv6" {
      	...
      	network = google_compute_network.vpc_network.id
      }
      ```

  - Consideration for defining a resource block

    - name should be unique
    - type is not user-defined and should be provider-based
    - All arguments should be enclosed within the resource block

- Meta-arguments for Resources
  - `count`
    - Create multiple instances according to the value assigned to it
  - `for_each`
    - Create multiple resource instances as per a set of strings
  - `depends_on`
    - Specify explicit dependency
  - `lifecycle`
    - Define life cycle of a resource
  - `provider`
    - Select a non-default provider configuration
  
- Resource Dependencies
  - Dependency graph
    - Built from the terraform configurations
    - Interpolates attributes during runtime
    - Determines the correct order of operations
  - Two kinds of dependencies
    - Implicit dependency: dependencies known to Terraform are detected automatically
    - Explicit dependency: dependencies unknown to Terraform must be configured explicitly, defined by `depends_on` argument



### 3.2 Variables

- Variables

  - Introduction to Variables

    - Variables parameterize your configuration without altering the source code.

    - Variables allow you to assign a value to the resource attribute at run time.

    - Variables separate source code from value assignments

  - Syntax
    ```
    variable "variable_name" {
    	type = <variable_type>
      default = "<default_value_for_variable"
      description = "<variable_description>"
      sensitive = true
    }
    ```

    - variable name should be unique and cannot be keywords

  - Various ways to assign values to variables

    - .tfvars files: `terraform apply -var-file my-var.tfvars`
      - quickly switching between sets of cariables and versioning them
    - CLI options: `terraform apply -var project_id="my-project"`
      - running quick examples on simple files
      - `-var` has the highest precedence
    - environment variables: `TF_VAR_project_id="my-project \ terraform apply"`
      - scripts and pipelines
    - CLI prompt
      - if a required variable hasn't been set

- Variables Best Practices

  - Paramerize only when necessary
    - Only parameterize values that must vary for each instance or environment( the values used in every block like name can be hard-coded in the configuration)
    - Changing a variable with a default value is backward-compatible
    - Removing a variable is not backward-compatible
  - Provide values in a .tfvars file
  - Give descriptive names to variables
  - Provide meaningful descriptions

- Output Values

  - Expose the information about the resource to the user of the Terraform configuration

  - Syntax
    ```
    output "output_name" {
    	description = <description of output>
    	value = <resource_type>.<resource_name>.<attribute>
    	sensitive = true
    }
    ```

  - Command

    - Querying all output values: `terraform output`







### 3.3 Terraform Registry

- Terraform Registry
  - An interactive resource for discovering a wide selection of integrations and configuration packages, otherwise known as providers and modules. The Registry includes solutions developed by HashiCorp, third-party vendors, and the Terraform community.
- Cloud Foundation Toolkit
  - also known as CFT
  - CFT provides a series of reference modules for Terraform that reflect Google Cloud best practices. These modules can be used to quickly build a repeatable foundation in Google Cloud. 
  - CFT modules are also referred to as Terraform blueprints.





## 4 Terraform Modules



### 4.1 Introduction to Terraform Modules

- DRY
  - Don't Repeat Yourself
  - Replace repeated code with abstraction to avoid redundancy
- Terraform Module
  - One or more Terraform configuration file (.tf) in a directory can form a module
  - Allow people to group a set of resources and reuse them later
  - The root module consists of the .tf files that are stored in the working directory where `terraform plan` / `terraform apply` is run
    - where other resources and modules are instantiated



### 4.2 Reuse Configuration with Modules

- Calling the Modules
  ```
  -- server/
  	-- main.tf
  	-- output.tf
  	-- variable.tf
  	
  -- network/
  	-- main.tf
  	-- output.tf
  	-- variable.tf
  	
  -- main.tf
  ```

  ```
  # root main.tf
  module "web_server" {
  	source = "./server"
  }
  
  module "server_network" {
  	source = "./network"
  }
  ```

  - `source`: meta-argument, whose value provides the path to the configuration code
    - The path can be local or remote, can be Terraform Registry, HTTP URL, ...





### 4.3 Variables and Outputs

- Using Variables

  - With variables, you can customize aspects of modules without altering the source code.

- Parameteriize the Configuration with Input Variables

  1. Replace the hardcoded values within your module with a variable
     ```
     # module main.tf
     resource "google_compute_network" "vpc_network" {
     	name = var.network_name
     }
     ```

  2. Declare the variables in the variables.tf file
     ```
     # module variables.tf
     variable "network_name" {
     	type = string
     	description = "name of the network"
     }
     ```

  3. Pass the value to the input variable when you call the module.
     ```
     # root main.tf
     module "dev_network" {
     	source = "./server"
     	network_name = "my-network1"
     }
     
     module "prod_network" {
     	source = "./network"
     	network_name = "my-network2"
     }
     ```

- Pass Values Outside the Module

  - Unlike root configuration, you cannot pass values to variables at run time.
    - To pass resource arguments from one module to another, the argument must be configured as an output value in Terraform.
  - Using output value
    1. Declare the network name as the output value to expose the resource attribute outside of the module.
    2. Define the network name as a variable in the server module, so that it can accept the values passed outside the module.
    3. In the main configuration, reference the output value when calling the server module.





## 5 Terraform States



### 5.1 Introduction to Terraform State

- Terraform state 

  - a metadata repository of your infrastructure configuration

  - By default, state is stored locally in a file named "terraform.tfstate", but it can also
    be stored remotely, which is recommended for team environments
  - The primary purpose of Terraform state is to store bindings between objects in a remote
    system and resource instances declared in your configuration.
  - States will record the identity of that remote object against a particular resource instance.
    - Terraform then potentially updates or deletes that object in response to future configuration



### 5.2 Storing State Files

- Ways to Save a State File
  - Terraform, by default, saves local state files in the current working directory with a .tfstate extension, so they don’t require additional maintenance.
  - If you’re working in a team where multiple developers are writing code to manage the infrastructure, then you should store state files remotely in a central location. That way when your infrastructure is changed, your Terraform state file is updated and synced, and your team will always be working with up-to-date infrastructure.



## 6 Terraform for Google Cloud

- [GCP | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started)

- [Docs overview | hashicorp/google | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs)



## 7 CDK for Terraform

- [CDK for Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/cdktf)