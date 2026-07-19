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