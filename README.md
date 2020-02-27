# quarkus-hello project

This project uses Quarkus, the Supersonic Subatomic Java Framework.

If you want to learn more about Quarkus, please visit its website: https://quarkus.io/ .

This project has index page with Lorem ipsum and a supercat.(at 8080 port)


## Creating a native executable

Or you can use Docker to build the native executable using: `mvn package -Pnative -Dquarkus.native.container-build=true`.

You can then execute your binary: `./target/quarkus-hello-1.0.0-SNAPSHOT-runner`

## Cloud config

- This project has terraform configuration under `src/main/terraform`.

- Terraform configuration has s3 backend with DynomoDB lock.

<b> Terraform configuration includes all the following(besides backend): </b>

- vpc

- subnet

- route table

- security group

- internet gateway

- key-pair(local ssh key)

- ingress, egress

- 2 instances

## Configure instances and install Kubernetes
- Put `id_rsa` and `id_rsa.pub` files in project path(they are gitignored)
- `cd provision-aws`

<b>To test installation:</b>
- `vagrant up`
- `vagrant provision ansible --provision-with vagrant`

<b>To install on AWS:</b>
- Edit inventories/aws/inventory file to correctly show aws instance ips
- `vagrant up ansible`
- `vagrant provision ansible --provision-with aws`

<b>To deploy app on Kubernetes:</b>

Manifests are `src/main/manifests`

Visit any ec2 instance with 32000 port. For example deployed app URL: 

`http://34.243.89.194:32000`

# Lambda Deployment

İt is included in main terraform directory. All needed config files starts with "lambda-*".

It deploys a serverless fuction that lists all VPCs and Subnets and writes them to DynomoDB. This function is integrated with API Gateway.

Source code for application can be found in `src/main/lambda-project/main.py`.