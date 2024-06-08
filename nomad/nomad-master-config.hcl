# lives in /etc/nomad.d/nomad.hcl
name = "ubi-prime"
datacenter = "ape-cluster"
data_dir = "/datapool/data/nomad"

bind_addr = "0.0.0.0"

server {
  # license_path is required for Nomad Enterprise as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/license.hclic"
  enabled          = true
  bootstrap_expect = 1 # server count?
    # server_join {
    #     retry_join     = [ "1.1.1.1", "2.2.2.2" ]
    #     retry_max      = 3
    #     retry_interval = "15s"
    # }
}

client {
  enabled = true
  servers = ["127.0.0.1"]
}
