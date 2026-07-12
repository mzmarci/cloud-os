
## Database Analysis

### Overview

Puter uses MariaDB as its primary relational database in the self-hosted production deployment.

The database stores persistent application data including user accounts, metadata, permissions, configuration, and other relational information required by the application.

Repository analysis also shows SQLite support, but this is primarily used for testing and in-memory development environments rather than production deployments.

### Database Type

## Database Type

Primary Database

- MariaDB 11

Testing Database

- SQLite (In-Memory)

Evidence

- docker-compose.yml
- backend test configuration

## Responsibilities

The relational database is responsible for storing:

- User accounts
- Authentication data
- File metadata
- Permissions
- Configuration
- Application state

## Container Configuration

Container Name

puter-mariadb

Image

mariadb:11

Persistence

Data is stored inside

./puter/data/mariadb

using a mounted volume.

## Environment Variables

MARIADB_ROOT_PASSWORD

MARIADB_DATABASE

MARIADB_USER

MARIADB_PASSWORD


## Persistence

The database uses persistent storage through Docker volumes.

Volume:

./puter/data/mariadb

This ensures database data survives container restarts.


## Health Check

MariaDB exposes a health check that verifies the database is accepting authenticated connections before dependent services are started.


## Kubernetes Considerations

MariaDB is a Stateful workload.

Deployment considerations:

- PersistentVolume
- PersistentVolumeClaim
- Backups
- Restore testing
- Resource limits
- Monitoring


## Risks

Database outage

Storage corruption

Disk exhaustion

Slow queries

Connection pool exhaustion

Backup failures



## Monitoring Requirements

Monitor:

- CPU
- Memory
- Disk usage
- Active connections
- Slow queries
- Query latency
- Replication status
- Storage utilization