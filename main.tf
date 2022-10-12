# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm"{
   version = "3.0.0"
    features  {}
}
# Create a resource group
resource "azurerm_resource_group" "tf_test"{
    name = "tf_rg_blobstore"
    location = "Canada Central"
    container = "tfstate"
    key ="terraform.state"
}

resource "azurerm_container_group" "tfcg_test" {
  name     = "weahterapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

   ip_address_type     = "Public"
  dns_name_label      = "mesutguzelwa"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "mesutguzel/weatherapi"
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

}

