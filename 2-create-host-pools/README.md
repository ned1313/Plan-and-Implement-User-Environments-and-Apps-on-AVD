# Creating Host Pools and Application Groups

This set of Terraform files will create the following resources:

* A resource group for AVD
* A host pool for multisession hosts
* An application group referencing the host pool
* A workspace for the application group
* A registration token for session hosts

It will not create a session host in the host pool, which should help to save on cost. Later we will deploy session hosts to the pool.

## Using the files

You should already be logged into the Azure CLI from the previous deployment, but if you are not go ahead and run the following:

```bash
# Login to Azure
az login

# Select the subscription you want to use
az account set -S SUBSCRIPTION_NAME
```

After that, simply follow the standard Terraform workflow:

```bash
terraform init
terraform plan
terraform apply
```

The output will include the name of the resource group, the name of the host pool, and the registration token for session hosts. The token is good for 24 hours, after which you'll need to generate a new one to add hosts.