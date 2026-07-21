## Why do you prefer aws_vpc_security_group_ingress_rule

Managing Security Group rules as separate Terraform resources improves lifecycle management. Individual rules can be added, modified, or removed without forcing Terraform to recreate or replace the entire Security Group. This reduces operational risk and makes infrastructure changes more predictable.

## Why are separate Security Group rule resources considered safer?

Separate rule resources allow Terraform to manage each rule independently. This minimizes unnecessary changes, reduces the likelihood of replacing the Security Group itself, and results in safer deployments for production environments.


## Why does the ingress rule require security_group_id

The ingress rule is now managed independently from the Security Group. Terraform needs to know which Security Group the rule belongs to, so the rule references the Security Group ID.


## Why use referenced_security_group_id instead of cidr_ipv4?

Using referenced_security_group_id follows the Principle of Least Privilege. Instead of allowing traffic from every resource inside the VPC, it only allows traffic from resources that are members of the referenced Security Group. This reduces the attack surface, avoids relying on IP ranges, and automatically adapts when resources are replaced or scaled.
