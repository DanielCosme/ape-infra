terraform {
  cloud {
    organization = "cosmo-softworks"

    workspaces {
      name = "main-ape"
    }
  }
}