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
  description = "Memory (GiB) for ACI container."
  type        = number
  default     = 6
}

# Image/options
variable "container_image" {
  description = "Minecraft server container image."
  type        = string
  default     = "itzg/minecraft-server:latest"
}

# Server config (itzg/minecraft-server)
variable "server_type" {
  description = "Server type: VANILLA, PAPER, FABRIC, FORGE, etc."
  type        = string
  default     = "PAPER"
}

variable "server_version" {
  description = "Minecraft version (e.g. 1.21.1). Leave empty for latest of type."
  type        = string
  default     = "1.21.1"
}

variable "server_port" {
  description = "Minecraft TCP port."
  type        = number
  default     = 25565
}

variable "motd" {
  type        = string
  default     = "Azure ACI Minecraft"
}

variable "difficulty" {
  type        = string
  default     = "normal"
}

variable "pvp" {
  type        = bool
  default     = false
}

variable "view_distance" {
  type        = number
  default     = 10
}

variable "max_players" {
  type        = number
  default     = 4
}