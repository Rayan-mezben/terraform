
terraform {
  required_providers {
    openstack = {
      source = "terraform-providers/openstack"
    }
  }
  required_version = ">= 1.0.0"
}
terraform {
  backend "http" {
    address = "https://terraform-backend.edu.artheriom.fr/votre_identifiant_ldap"
  }
}

provider "openstack" {
  cloud = "credentials"
}
