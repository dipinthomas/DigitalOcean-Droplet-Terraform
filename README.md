# DigitalOcean Deployment

This repository provides terraform scripts written in HashiCorp Configuration Language (HCL) for deploying a DigitalOcean VM (droplet) and installing the Docker dependencies required for deploying a reactJS application.

Follow below steps to deploy a droplet

# Generate API Key

Terraform requires DigitalOcean API key for authentication, steps to generate API key can be found [here](https://www.digitalocean.com/community/tutorials/how-to-create-a-digitalocean-space-and-api-key)

# Update Configuration

terraform.tfvars  is the configration file which contains all environment values required to deploy a cloud infrastructure. 

Update variable value in terraform.tfvars with api key generated above

**do_token = "694507a9ae35e3382"**


# Install Terraform

Terraform should be installed on the laptop/system where you plan to run this script from. Steps to install terraform is provided [here](https://www.terraform.io/cli/install/apt)

# Generate ssh key

SSH will be used to secure connection with remote droplet running on DigitalOcean. 

By running below command pair of private and public will be generated in *~/.ssh* directory

> ssh-keygen

*Note: Instructions to use existing ssh key pair is provided in droplet.tf & provider.tf*

# Deploy Droplet

After above dependency are met, clone this repository and change directory to this repo. 

## init
Process to install terraform dependency

> terraform init

## plan
Terraform will generate the action to be performed

> terraform plan

## apply
Terraform command to apply current configuration

> terraform apply

## show
environment summary can be seen by using show

> terraform show

Above command will return lot of useful information about the environment, please review it. 

**Public IP** / **droplet_floating_addr** is required for next steps, keep it handy.

# Build reactJS docker image

We will use a simple reactJS application to validate our deployment.

Application repository is here

## Update .env files

Navigate to *.env* file which is present in the **frontend** folder. Update value for variable "REACT_APP_PROXY_HOST", with the IP address which was return in the **terraform show** command

## build & push

Follow the instructions provided in the repository to build & push the docker image

# Deploy Application

docker-compose in github [gist](https://gist.github.com/dipinthomas/82fb48d6ef2ad67deaf6e3d38772ec79) can be used for deploying the application. 

> wget https://gist.githubusercontent.com/dipinthomas/82fb48d6ef2ad67deaf6e3d38772ec79/raw/3df380925683a2290603034ad9e20143d96c4b2d/docker-compose.yaml

> docker-compose up -d

*note: if the image name or tag has changed, please make sure in docker-compose.yaml file is updated*


# Validation

Once the above steps are successful, you can access the application using droplet VM public IP address, which is found in the output of terraform commands.


![](./img/public_ip.png)
