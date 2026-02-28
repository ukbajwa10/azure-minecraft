variable "project_name" {
  type = string
}

variable "location" {
  type = string
}

variable "env" {
  type = string
}

variable "quota" {
  type = number
}

# Container sizing
variable "cpu" {
  description = "vCPU for ACI container."
  type        = number
  default     = 2
}

variable "memory_gb" {
  description = "Memory (GiB) for ACI container. Must exceed MAX_MEMORY to avoid OOM."
  type        = number
  default     = 10
}

# Image
variable "container_image" {
  description = "Hytale server container image."
  type        = string
  default     = "indifferentbroccoli/hytale-server-docker:latest"
}

# Server config (indifferentbroccoli/hytale-server-docker)
variable "server_name" {
  description = "Server display name."
  type        = string
  default     = "Azure Hytale Server"
}

variable "server_port" {
  description = "Hytale server UDP port."
  type        = number
  default     = 5520
}

variable "max_players" {
  description = "Maximum concurrent players."
  type        = number
  default     = 20
}

variable "view_distance" {
  description = "Chunk render distance."
  type        = number
  default     = 12
}

variable "auth_mode" {
  description = "Authentication mode: authenticated or offline."
  type        = string
  default     = "authenticated"
}

variable "max_memory" {
  description = "JVM max heap size (e.g. 8G). Keep below memory_gb."
  type        = string
  default     = "8G"
}

variable "enable_backups" {
  description = "Enable automatic world backups."
  type        = bool
  default     = false
}

variable "backup_frequency" {
  description = "Backup interval in minutes."
  type        = number
  default     = 30
}

variable "disable_sentry" {
  description = "Disable Sentry crash reporting."
  type        = bool
  default     = true
}

variable "patchline" {
  description = "Server patchline: release or pre-release."
  type        = string
  default     = "release"
}
