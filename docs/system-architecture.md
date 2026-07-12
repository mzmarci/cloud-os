# System Architecture Discovery

## Purpose

The objective of this document is to understand the overall architecture of the Puter application before designing its production deployment.

Rather than focusing on deployment, this document identifies the application's major components, external dependencies, communication patterns, and infrastructure requirements.

This architecture analysis will serve as the foundation for later phases of the project, including:

- Docker containerization
- Kubernetes deployment
- Terraform infrastructure
- GitOps
- Observability
- Disaster Recovery
- Security


## Architecture Overview

Puter follows a service-oriented architecture where the main application depends on several external infrastructure services.

Instead of embedding all functionality inside the application, responsibilities are distributed across specialized services.

The application currently consists of:

- Reverse Proxy
- Application Server
- SQL Database
- Cache Layer
- Key-Value Store
- Object Storage

This separation improves scalability, maintainability, and fault isolation.


## Nginx

### Purpose

Acts as the reverse proxy for incoming HTTP requests.

### Responsibilities

- Accept client requests
- Forward requests to Puter
- TLS termination (future)
- Virtual host routing

### Type

Infrastructure Service

### Stateful

No

### Public

Yes

### Depends On

- Puter

### Evidence

docker-compose.yml


## Puter Application

### Purpose

Main application responsible for business logic.

### Responsibilities

- User authentication
- API handling
- File operations
- Workspace management
- Business logic

### Type

Application Service

### Stateful

No

### Public

No

### Depends On

- MariaDB
- Valkey
- DynamoDB
- RustFS


## MariaDB

### Purpose

Primary relational database.

### Responsibilities

- Store users
- Store metadata
- Store application data

### Type

Database

### Stateful

Yes

### Public

No

### Depends On

None


## Valkey

### Purpose

Redis-compatible caching service.

### Responsibilities

- Cache data
- Session storage
- Performance optimization

### Type

Cache

### Stateful

Yes

### Public

No


## DynamoDB Local

### Purpose

Key-value data store.

### Responsibilities

- Store application key-value data
- Fast lookups

### Type

NoSQL Database

### Stateful

Yes

### Public

No


## RustFS

### Purpose

S3-compatible object storage.

### Responsibilities

- File uploads
- Object storage
- Static assets

### Type

Object Storage

### Stateful

Yes

### Public

No

### Service Dependencies

| Service  | Depends On |
| -------- | ---------- |
| Nginx    | Puter      |
| Puter    | MariaDB    |
| Puter    | Valkey     |
| Puter    | DynamoDB   |
| Puter    | RustFS     |
| MariaDB  | None       |
| Valkey   | None       |
| DynamoDB | None       |
| RustFS   | None       |



### Stateful vs Stateless

| Component | Type      | Reason            |
| --------- | --------- | ----------------- |
| Nginx     | Stateless | Reverse proxy     |
| Puter     | Stateless | Business logic    |
| MariaDB   | Stateful  | Stores data       |
| Valkey    | Stateful  | Cache persistence |
| DynamoDB  | Stateful  | Key-value storage |
| RustFS    | Stateful  | Stores files      |

### External Dependencies

| Dependency | Purpose         |
| ---------- | --------------- |
| MariaDB    | SQL Database    |
| Valkey     | Cache           |
| RustFS     | Object Storage  |
| DynamoDB   | Key-value Store |



### Communication

Client

↓

HTTP

↓

Nginx

↓

HTTP

↓

Puter

↓

SQL

↓

MariaDB

↓

Redis Protocol

↓

Valkey

↓

S3 API

↓

RustFS

↓

AWS SDK

↓

DynamoDB

### Networking

# Public

Nginx

# Internal

Puter
MariaDB
Valkey
DynamoDB
RustFS


### Persistence

| Service  | Persistent? | Why       |
| -------- | ----------- | --------- |
| MariaDB  | Yes         | Database  |
| Valkey   | Yes         | Cache     |
| RustFS   | Yes         | Files     |
| DynamoDB | Yes         | KV Store  |
| Puter    | No          | Stateless |
| Nginx    | No          | Stateless |


### Security Considerations

Current observations

✓ Internal databases are not exposed

✓ Reverse proxy sits in front

✓ Environment variables store secrets

Future improvements

- TLS
- Secrets Manager
- Kubernetes Secrets
- RBAC
- Network Policies


### Kubernetes Impact

| Component | Kubernetes Resource |
| --------- | ------------------- |
| Puter     | Deployment          |
| Nginx     | Deployment          |
| MariaDB   | StatefulSet         |
| Valkey    | StatefulSet         |
| RustFS    | StatefulSet         |
| DynamoDB  | StatefulSet         |



### Risks

Single points of failure

Database outage

Storage corruption

Object storage unavailable

Redis unavailable

Disk exhaustion

Network partition

Misconfigured secrets

TLS expiration



### Future Architecture Improvements

Future Improvements

Deploy to Kubernetes

GitOps

Prometheus

Grafana

Loki

Tempo

Alertmanager

Horizontal Pod Autoscaler

Cluster Autoscaler

Pod Disruption Budgets

ArgoCD

External Secrets

AWS Secrets Manager

Terraform

Disaster Recovery

Chaos Engineering

Multi-AZ deployment

Multi-region backup

SLOs

Synthetic Monitoring

