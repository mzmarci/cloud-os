## ADR-001

## Decision

# Use

10.0.0.0/16

# for the VPC

# Reason

Provides enough address space for future growth while allowing multiple public and private subnets across Availability Zones.

## ADR-002

## Decision

# Use

/22

# subnets.

# Reason

Provides sufficient IP capacity for Kubernetes worker nodes, pods, VPC endpoints, and future scaling.

## ADR-003

## Decision

# Deploy worker nodes inside private subnets.

# Reason

Worker nodes don't require direct inbound internet access. This reduces exposure while allowing outbound connectivity through the NAT Gateway.


## Why did you deploy only one NAT Gateway?

For development and learning environments, a single NAT Gateway reduces cost while still providing outbound internet access for private subnets. In production, I would deploy one NAT Gateway per Availability Zone to avoid a single point of failure and prevent cross-AZ routing costs.

## Why did you use depends_on

Terraform usually infers dependencies from resource references. However, depends_on can be used when there is an operational dependency that isn't fully captured by attribute references, ensuring resources are created in the correct order.