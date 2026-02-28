resource "azurerm_resource_group" "rg" {
  name     = "RG-${var.env}-${var.project_name}"
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = lower("sa${var.env}${var.project_name}")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "FileStorage"
  account_tier             = "Premium"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "data" {
  name               = lower("fs${var.env}${var.project_name}")
  storage_account_name = azurerm_storage_account.sa.name
  quota              = var.quota
}

resource "azurerm_container_group" "aci" {
  name                = "ACI-${var.env}-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = lower("${var.env}${var.project_name}")
  os_type             = "Linux"

  exposed_port {
    port     = var.server_port
    protocol = "UDP"
  }

  container {
    name   = "hytale"
    image  = var.container_image
    cpu    = var.cpu
    memory = var.memory_gb

    ports {
      port     = var.server_port
      protocol = "UDP"
    }

    environment_variables = {
      PUID             = "1000"
      PGID             = "1000"
      SERVER_NAME      = var.server_name
      DEFAULT_PORT     = tostring(var.server_port)
      MAX_PLAYERS      = tostring(var.max_players)
      VIEW_DISTANCE    = tostring(var.view_distance)
      AUTH_MODE        = var.auth_mode
      MAX_MEMORY       = var.max_memory
      ENABLE_BACKUPS   = var.enable_backups ? "true" : "false"
      BACKUP_FREQUENCY = tostring(var.backup_frequency)
      DISABLE_SENTRY   = var.disable_sentry ? "true" : "false"
      USE_AOT_CACHE    = "true"
      PATCHLINE        = var.patchline
      DOWNLOAD_ON_START = "true"
    }

    volume {
      name                 = "data"
      mount_path           = "/home/hytale/server-files"
      read_only            = false
      share_name           = azurerm_storage_share.data.name
      storage_account_name = azurerm_storage_account.sa.name
      storage_account_key  = azurerm_storage_account.sa.primary_access_key
    }
  }
}
