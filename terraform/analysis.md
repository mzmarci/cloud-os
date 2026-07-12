### Overview of the terraform code

When a code is given, below are some of the important questions that needs to be asked 

You first answer these questions:

What cloud provider? → AWS
What region? → We'll choose one.
How many environments? → Dev, Staging, Production
Where will Terraform state be stored?
How will engineers collaborate?
What naming convention will we use?
What tagging strategy will we use?



## 1. Why do we have a bootstrap folder?

Terraform cannot store its state in an S3 bucket that doesn't exist yet.

So something has to create:

S3 Bucket
DynamoDB Lock Table

That "something" is called the bootstrap.

After the bootstrap runs once, every other Terraform module will use the remote backend.

# Why S3?

Terraform stores:

Resource IDs
Dependencies
Current infrastructure state

Without the state file, Terraform doesn't know what it created.

# Why DynamoDB?

Imagine you run terraform apply and another engineer runs terraform apply at the same time, Both modify the same infrastructure. The result can be state corruption or conflicting changes. The DynamoDB lock prevents this by allowing only one Terraform operation at a time.
