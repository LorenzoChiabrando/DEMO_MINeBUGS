# DEMO_MINeBUGS

First draft of the MINeBUGS microbiome simulation service.

## Getting Started

### Prerequisites
Ensure that **Docker** and **Docker Compose** are installed on your system.

### Execution

**1. Start the services**

Navigate to the project root directory and execute the following command:

```bash
docker compose up -d
```

> **Important: Initialization Period**

> The initial startup requires approximately **5 to 10 minutes** to load and index the AGORA2 database. The service may appear unresponsive during this phase. Please wait for this process to complete.

**2. Access the Application**

Once the initialization is finished, access the web interface via your browser at:
http://localhost:3000

### Monitoring

To monitor the database loading progress and verify when the service is ready, use the following command:

```bash
docker compose logs -f
```

### Shutdown

To stop the service, execute:

```bash
docker compose down
```
