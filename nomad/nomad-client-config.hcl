client {
  enabled = true
  node_class = "droplet"

  meta {
    name = "ape-1"
  }

  server_join {
    retry_join = [ "100.76.28.61"]
  }
}
