# DEMO_MINeBUGS

First draft of the MINeBUGS microbiome simulation service.

## Getting Started

### Prerequisites

Ensure that **Docker**, **Docker Compose**, and **Make** are installed on your system.

### Execution

**1. Start the services**

- **Option A: Make (Recommended)**  
  Automatically handles database seeding logic.
  
  ```bash
  make up
  ```

- **Option B: Docker Compose**

  - **First Run (Seed DB)**

    ```bash
    docker compose --profile init up
    ```

  - **Regular Run**

    ```bash
    docker compose up -d
    ```

**Important: Initialization Period**

The initial startup requires approximately **5 to 10 minutes** to load and index the **AGORA2** database. The service may appear unresponsive during this phase. Wait for this process to complete.

**2. Access the Application**

Once the initialization is finished, access the web interface via your browser at:

- http://localhost:3000

## Monitoring

To monitor the database loading progress and verify when the service is ready:

```bash
make logs
# OR
docker compose logs -f
```

## Shutdown

To stop the service:

```bash
make down
# OR
docker compose down
```

## Example Datasets

The repository includes sample files to help you test the upload and mapping functionalities immediately.

### Custom Diet Configuration

- **Location:** `diet_example/true-high-fibre.json`
- **Usage:** Use this JSON file to test the custom diet upload feature. It provides a template for defining a specific nutritional profile (e.g., high fibre).

### Community Mapping Inputs

- **Location:** `input_for_upload_example/`
- **Usage:** Use these CSV files to verify the taxonomic mapping capabilities of the service:
  - `big_community.csv`: A generic large dataset to test processing capacity.
  - `multiple_sclerosis.csv`: A specific case study dataset for mapping tests.
