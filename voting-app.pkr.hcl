packer {
  required_plugins {
    docker = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# ----------------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------------
variable "image_name" {
  type    = string
  default = "voting-app"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "base_image" {
  type    = string
  default = "python:3.13"
}

# ----------------------------------------------------------------------------
# Source : conteneur Docker servant de support au provisioning Ansible
# ----------------------------------------------------------------------------
source "docker" "voting-app" {
  image  = var.base_image
  commit = true

  # Métadonnées appliquées à l'image au moment du commit
  # (équivalent des instructions WORKDIR / EXPOSE / CMD du Dockerfile).
  # paybook.yml copie "./azure-vote" (sans slash) vers /app : Ansible place donc
  # les fichiers dans /app/azure-vote/. Le WORKDIR pointe sur ce dossier.
  changes = [
    "WORKDIR /app/azure-vote",
    "ENV REDIS=azure-vote-back",
    "EXPOSE 80",
    "CMD [\"python\", \"main.py\"]"
  ]
}

# ----------------------------------------------------------------------------
# Build
# ----------------------------------------------------------------------------
build {
  name    = "voting-app"
  sources = ["source.docker.voting-app"]

  # Exécute le playbook Ansible historique dans le conteneur.
  # use_proxy (true par défaut) permet à Ansible de communiquer avec le
  # conteneur via le communicateur "docker" sans serveur SSH dans l'image.
  provisioner "ansible" {
    playbook_file = "./paybook.yml"
    user          = "root"

    # -O : compat scp avec les versions récentes d'OpenSSH utilisées par le proxy.
    extra_arguments = [
      "--scp-extra-args", "'-O'"
    ]
  }

  # Tague l'image résultante : voting-app:latest
  post-processor "docker-tag" {
    repository = var.image_name
    tags       = [var.image_tag]
  }
}
