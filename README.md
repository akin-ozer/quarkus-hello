# quarkus-hello project

This project uses Quarkus, the Supersonic Subatomic Java Framework.

If you want to learn more about Quarkus, please visit its website: https://quarkus.io/ .

This project has index page with Lorem ipsum and a supercat.(at 8080 port)


## Creating a native executable

Or you can use Docker to build the native executable using: `mvn package -Pnative -Dquarkus.native.container-build=true`.

You can then execute your binary: `./target/quarkus-hello-1.0.0-SNAPSHOT-runner`

## Cloud config

- This project has terraform configuration under "src/main/terraform".

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
