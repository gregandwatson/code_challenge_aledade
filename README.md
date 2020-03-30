# code_challenge_aledade

## Deploying PostgreSQL cluster

This document outlines the steps it takes to deploy a PostgreSQL cluster to AWS. We make use of mod_locals to configure the resources for both prod and dev. The environment_id variable is the key to this. By using a environment_id variable we can cut down on the amount of code needed by specifying resources once and then using mod_locals to configure the resources per environment specifications.

The environment_id variable is the key in all of this. It specifies what environment the resources are being deployed to. This variable can be a pipeline variable that gets passed in during deployment. There would be separate pipelines, one for dev and one for prod.

This pipeline variable would get passed to a build agent [the build agent would run the terraform plan and apply steps] as an environment variable TF_VAR_environment_id which would override the terraform variable during the build. This would allow us to assign the value "dev", "test", "stage", "prod" etc to the variable so that we can build out each environment.

The general steps taken during the deployment process are as follows:

  - Create VPC
  - Create vpc subnet
  - Create AWS instance
  - Create subnet
  - Create ssh key pair
  - Install PostgreSQL via Ansible
  - Create Database in PostgreSQL
  - Create users
  - Set up PostgreSQL cluster


### VPC module

I modularized the creation of the AWS VPC and VPC subnet in modules/vpc. It does the following:
- Creates the AWS VPC
- Creates a subnet to be used inside the vpc

### AWS instance_type

I modularized the creation of the AWS instance modules/postgres_vm. It does the following:
- Creates an AWS instance
- Uses user data to install python
- Uses a local-exec provisioner to run the ansible-playbook command

### Locals

I used local variables to do the configuration based on environment. This allows for smaller and more simple code base.

### Root module
- The root module instantiates both the vpc and aws instance modules and configures them respectively.
- The root module also creates a key pair resource for accessing the aws instance
- The root module also creates the Ansible host file based on a template 

## Ansible

Which ansible playbook file to run is based on the environment_id as stated previously. I used a postgresql role which installs postgres, creates the database, creates the users and sets up the Postgres cluster. The steps to do that is as follows:

### Ansible role tasks
- Makes sure that a few packages are up to date
- Installs PostgreSQL
- Ensures PostgreSQL service is started
- Creates database (db1)
- Creates admin user
- Creates service1 user
- Creates PostgreSQL directory
- Changes ownership of the directory to pgsql user
- Initialize Postgres DB cluster
- Copies postgres.conf file

### Main ansible playbooks
There is an ansible playbook for both dev and prod with the only differences being that dev creates two additional users.
