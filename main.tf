resource "azurerm_resource_group" "this" {
  name     = "RG-${var.env}-${var.project_name}"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = lower("sa${var.env}${var.project_name}")
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_kind             = "FileStorage"
  account_tier             = "Premium"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "world" {
  name               = lower("fs${var.env}${var.project_name}")
  storage_account_id = azurerm_storage_account.this.id
  quota              = var.quota
}

resource "azurerm_container_group" "this" {
  name                = "ACI-${var.env}-${var.project_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  ip_address_type     = "Public"
  dns_name_label      = lower("${var.env}${var.project_name}")
  os_type             = "Linux"

  exposed_port {
    port     = var.server_port
    protocol = "TCP"
  }

  container {
    name   = "minecraft"
    image  = var.container_image
    cpu    = var.cpu
    memory = var.memory_gb

    ports {
      port     = var.server_port
      protocol = "TCP"
    }

    environment_variables = {
      EULA          = "TRUE"
      TYPE          = var.server_type    # PAPER, VANILLA, FABRIC, FORGE, etc.
      VERSION       = var.server_version # e.g., "1.21.1"
      MEMORY        = "${var.memory_gb}G"
      MOTD          = var.motd
      DIFFICULTY    = var.difficulty # peaceful/easy/normal/hard
      PVP           = var.pvp ? "true" : "false"
      VIEW_DISTANCE = tostring(var.view_distance)
      MAX_PLAYERS   = tostring(var.max_players)
      # ENABLE_WHITELIST = var.enable_whitelist ? "true" : "false"
      # OPS              = join(",", var.ops)       # comma-separated
      # WHITELIST        = join(",", var.whitelist) # comma-separated
      # SPAWN_PROTECTION = tostring(var.spawn_protection)
      # Uncomment if you want RCON
      # ENABLE_RCON      = "true"
      # RCON_PASSWORD   = var.rcon_password
      # RCON_PORT       = tostring(var.rcon_port)
      SERVER_PORT = tostring(var.server_port)
    }

    volume {
      name                 = "world"
      mount_path           = "/data"
      read_only            = false
      share_name           = azurerm_storage_share.world.name
      storage_account_name = azurerm_storage_account.this.name
      storage_account_key  = azurerm_storage_account.this.primary_access_key
    }
  }
}
