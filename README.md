# End-to-End Azure Data Pipeline with Terraform

## Introduction
This project demonstrates the implementation of an end-to-end Azure Data Engineering pipeline. It extracts data from the AdventureWorksDW2022 database hosted on an on-premises SQL Server and loads it into Azure Storage. The data is then transformed following the Medallion Architecture (bronze, silver, and gold layers). Finally, Power BI is used to visualize the insights effectively.

## Architecture

![Pipeline Flow](/images/0.project_architecture.png "Project Architecture")

This project leverages Azure services such as Azure Data Factory, Azure Databricks, Azure Storage, Synapse Studio, and Key Vault to build an end-to-end ETL data pipeline. It also integrates Terraform as the infrastructure provisioning tool.

## Project Flow

1. **Install and Authenticate Azure CLI**:  
   Execute Airflow DAGs to:
    - Install Azure CLI and use a device code to authenticate with Azure

2. **Install Terraform**:
    - Install Terraform and set up the configuration files for Azure resource provisioning

3. **Provision Resources Using Terraform**:  
    - Navigate to the Terraform directory and run the following commands:

        ```bash
        terraform validate
        terraform plan
        terraform apply
        ```

    *Note:*  
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

20. **Create Dashboards in Power BI**: 
    - Design dashboards in Power BI to visualize the data and generate actionable insights

        ![](/images/8.dashboard.gif "")

21. **Destroy all resources with Terraform**: 
    - After the project is done, we can perform terraform destroy to delete all of the Azure resource quickly

## Additional Notes

- Terraform does not provision:
  - Azure Linked Services.
  - Azure Databricks clusters and notebooks

- These configurations must be set up manually before running the pipeline.

## Prerequisites

1. **Azure Subscription**: 
    - Ensure you have an active Azure subscription with Owner or Contributor access to provision the required resources.
2. **Azure CLI**:
    - Install Azure CLI to authenticate with Azure for Terraform provisioning.
3. **Terraform**: 
    - Install Terraform and set up the configuration files for Azure resource provisioning.

## Conclusion
This project showcases the implementation of an end-to-end Azure Data Engineering pipeline using Terraform for infrastructure provisioning. It demonstrates how to extract, transform, and load data efficiently and visualize insights with Power BI. The detailed steps and provided resources aim to simplify the process for anyone looking to build a similar pipeline.

## References
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/)
- [Terraform](https://www.terraform.io/docs/)

