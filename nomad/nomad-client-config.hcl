client {
  enabled = true
  node_class    = "droplet"

  meta {
    name = "ape-1"
  }
  # servers = ["127.0.0.1"]
  # server_join {
  #   retry_join     = [ "1.1.1.1", "2.2.2.2" ]
  #   retry_max      = 3
  #   retry_interval = "15s"
  }
}
