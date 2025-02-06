# End-to-End Azure Data Pipeline with Terraform

## Table of Contents
1. [Project Overview](#project-overview)
2. [Key Features](#key-features)
3. [Prerequisites](#prerequisites)
4. [Get Started](#get-started)
5. [Power BI Dashboard](#power-bi-dashboard)
6. [Conclusion](#conclusion)
7. [Future Enhancements](#future-enhancements)

## Project Overview
This project implements an end-to-end Azure Data Engineering pipeline, extracting data from the AdventureWorksDW2022 database on an on-prem SQL Server and loading it into Azure Data Lake Storage. The data follows the Medallion Architecture (bronze, silver, gold) and is visualized in Power BI. It leverages Azure Data Factory, Databricks, Storage, Synapse, and Key Vault, with Terraform provisioning only the core Azure resources as my first cloud integration experience.

![Pipeline Flow](/images/0.project_architecture.png "Project Architecture")

*Note: Terraform provisions only the core Azure resources. Other resources, such as Linked Services, Databricks clusters, and notebooks, are not provisioned and must be created manually.*

## Key Features
This section contains the main functionalities and capabilities of ETL Pipeline:

1. **End-to-End Data Pipeline**
    - Extracts data from on-prem SQL Server (AdventureWorksDW2022) and processes it in Azure using the Medallion Architecture (bronze, silver, gold)

2. **Infrastructure as Code**
    - Provisions core Azure resources (Data Factory, Databricks, Storage, Synapse, Key Vault) with Terraform, supporting easy teardown via `terraform destroy`.

3. **Automated & Secure Data Movement**
    - Uses Azure Data Factory with a self-hosted integration runtime for on-premises data extraction and secure storage.

4. **Scalable Data Processing**
    - Leverages Azure Databricks and Spark for efficient distributed transformations.

5. **Secure Credential Management**
    - Stores and retrieves secrets via Azure Key Vault, integrating with Databricks secret scope

6. **Data Warehousing & Automation**
    - Creates SQL views and automates transformations in Synapse Studio (Serverless SQL Pool)

7. **Business Intelligence & Visualization**
    - Visualizes insights using Power BI dashboards.

## Prerequisites
1. **Azure Subscription**: 
    - Ensure you have an active Azure subscription with Owner or Contributor access to provision the required resources.

2. **Azure CLI**:
    - Install Azure CLI to authenticate with Azure for Terraform provisioning.

3. **Terraform**: 
    - Install Terraform and set up the configuration files for Azure resource provisioning

4. **SQL Server**:
    - Set up SQL Server with the AdventureWorksDW2022 database. Download the .bak file from the official Microsoft website [here](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)

5. **SQL Server Management Studio**: 
    - Used to manage the SQL database and configure the Self-Hosted Integration Runtime for Azure Data Factory

## Get Started

1. **Install and Authenticate Azure CLI**:  
    - Install Azure CLI and use a device code to authenticate with Azure using the terminal

        ```bash
        az login --use-device-code
        ```

2. **Install Terraform**:
    - Install Terraform and set up the configuration files for Azure resource provisioning

3. **Provision Resources Using Terraform**:  
    - Navigate to the Terraform directory and run the following commands in the terminal:

        ```bash
        terraform init
        terraform validate
        terraform plan
        terraform apply
        ```

    ***Note:***
    - `terraform init` is used to initialize terraform  
    - `terraform validate` is used to validate the configuration.  
    - `terraform plan` previews the changes that Terraform will make.  
    - `terraform apply` applies the configuration to create the resources.  

4. **Verify Resource Creation in Azure Portal**:  
    - Check the Azure Resource Group to confirm the resources have been successfully created

        ![](/images/1.resource_group.png "")

5. **Verify Storage Account Configuration**:  
    - Open the Storage Account and ensure that the containers (e.g., bronze, silver, and gold) have been created

        ![](/images/2.azure_storage.png "")

6. **Set Up SQL Server User**:  
    - Open SQL Server Management Studio and create a user account for connecting Azure Data Factory to the on-premises SQL Server

        ![](/images/9.ssms_DW2022.png "")

7. **Install Self-Hosted Integration Runtime**: 
    - In Azure Data Factory Studio, download and set up a Self-Hosted Integration Runtime to facilitate a connection between the on-premises SQL Server and Azure Data Factory

8. **Create Azure Data Factory Pipeline**: 
    - Create a pipeline in Azure Data Factory to extract data from the AdventureWorksDW2022 database into the Storage Account (bronze container)

        ![](/images/3.azure_adf.png "")

        *Note: The attached image shows the complete Azure Data Factory pipeline, encompassing all stages of the data flow, not just the extraction to the bronze layer.*

9. **Set Up Azure Databricks Workspace**: 
    - Open Azure Databricks Studio and create a new workspace for data transformation and analytics

        ![](/images/4.adb_workspace.png "")

10. **Create Databricks Secret Scope**: 
    - Set up a secret scope in Databricks to securely store and access credentials from Azure Key Vault

        ![](/images/4.adb_secretscope.png "")

11. **Store Secrets in Azure Key Vault**: 
    - Use Azure Key Vault to securely store the Storage Account key and other sensitive credentials

        ![](/images/6.azure_keyvault.png "")

12. **Mount Storage Containers in Databricks**: 
    - Create a Databricks notebook to mount the bronze, silver, and gold storage containers

        ![](/images/4.adb_storageMount.png "")

13. **Perform Data Transformations in Databricks**: 
    - Create and execute a notebook to perform data transformations for the silver and gold layers

    - You can view the complete transformation notebook here

        ```plaintext
        https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/3584113975543867/3069332466541837/5462809743132410/latest.html
        ```

14. **Verify Data in Storage Account**: 
    - Check each container (bronze, silver, and gold) in the Storage Account to ensure the data has been transformed correctly

15. **Set Up Synapse Studio**: 
    - Open Synapse Studio and create a SQL Database using the built-in serverless pool
    
16. **Create Stored Procedure for Views**: 
    - Develop a stored procedure in Synapse Studio to create views for the tables stored in the gold container

        ![](/images/5.synapse_storedproc.png "")

17. **Automate View Creation with Synapse Pipeline**: 
    - Integrate the stored procedure with a Synapse Pipeline to automatically create views for all tables

        ![](/images/5.synapse_pipeline.png "")

18. **Verify SQL Database Views**: 
    - Go to the SQL Database section in Synapse Studio and confirm that the views have been created successfully

        ![](/images/5.synapse_result.png "")

19. **Load Views into Power BI**: 
    - Open Power BI Desktop and load the views created in Synapse Studio

        ![](/images/7.pbi_dataload.png "")

    - Open the Model View and check if the table relationships are correct

        ![](/images/7.pbi_semantic.png "")

20. **Destroy all resources with Terraform**: 
    - After the project is done, we can perform terraform destroy to delete all of the Azure resource quickly

## Power BI Dashboard
The dashboard analyzes the views created in Synapse for tables stored in the gold container. It connects to Synapse Serverless SQL Pool via the Serverless SQL Endpoint, ensuring that each refresh reflects the latest processed data

### Additional Table:
I intentionally added a static table, budget, to simulate scenarios such as comparing monthly sales against budgeted values—for example, determining whether sales in January exceeded the budget

### **Features:**
- `Interactive Tooltips`: Hover over visualizations to see detailed information

- `Bookmarks:` Use bookmarks to navigate between different views and filters seamlessly

    - Here’s a preview of the dashboard in action:

        ![](/images/8.dashboard.gif "")

### **Insights**:
Using the dashboard, we can gain insight such as:
- `Top 3 Best Selling Product`: Visualized using a bar chart

- `Sales by Region and Product Sub Category`: Displayed as a stacked bar chart

- `Monthly Sales vs Budget`: Shown in a combo chart (bars for sales, line for budget)

- `Yearly Sales Growth`: Illustrated with a waterfall chart

- `Sales by Product Category`: Represented in a bar chart

## Conclusion
This project creates an end-to-end Azure Data Engineering pipeline using Terraform for infrastructure provisioning. It handles data extraction, transformation, and loading, visualized in Power BI. Although functional, the pipeline can be enhanced by fully automating resource provisioning with Terraform. The provided steps and resources aim to simplify the process for similar projects

## Future Enhancements
1. **Complete Terraform Automation**:
    - Fully automate resource provisioning with Terraform for Databricks clusters, linked services, notebooks, etc.

2. **Data Quality Checks and Validation**:
    - Implement automated validation tests during ETL for data consistency and quality

3. **Implement CDC (Change Data Capture)**:
    - Track and process only data changes from source systems for improved pipeline performance

4. **Implement Monitoring**:
    - Add monitoring and alerting with Azure Monitor or custom logging for pipeline health and performance

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.