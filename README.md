# azure-hytale

Terraform configuration for hosting a Hytale server on Azure Container Instances (ACI) with persistent storage via Azure File Share.

## Requirements

- Terraform >= 1.6.0
- Azure CLI authenticated (`az login`)

## Usage

1. Set `container_image` in `terraform.tfvars` to your Hytale server Docker image.
2. Update `mount_path` in `main.tf` to match the data directory used by your image.
3. Add any Hytale-specific environment variables to the `environment_variables` block in `main.tf`.

```bash
terraform init
terraform plan
terraform apply
```

## Variables

| Name | Default | Description |
|------|---------|-------------|
| `project_name` | — | Project name used in resource naming |
| `location` | — | Azure region |
| `env` | — | Environment tag (e.g. `PROD`, `DEV`) |
| `quota` | — | File share size in GiB |
| `cpu` | `2` | vCPU for the container |
| `memory_gb` | `6` | Memory (GiB) for the container |
| `container_image` | `your-hytale-server-image:latest` | Hytale server Docker image |
| `server_port` | `5520` | TCP port the server listens on |
| `max_players` | `4` | Maximum concurrent players |

## Outputs

| Name | Description |
|------|-------------|
| `fqdn` | Public FQDN for the Hytale client to connect to |
| `public_ip` | Public IP of the container (can change on recreation) |
