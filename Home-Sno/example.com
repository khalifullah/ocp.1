$TTL 1W
@   IN  SOA ns1.example.com. root.example.com. (
            2025080701  ; Updated serial
            3H          ; refresh
            30M         ; retry
            2W          ; expiry
            1W )        ; minimum
    IN  NS  ns1.example.com.
    IN  MX 10 smtp.example.com.

ns1.example.com.                IN  A 192.168.0.200
smtp.example.com.               IN  A 192.168.0.200
bastion-node.example.com.       IN  A 192.168.0.200
api.uae-ocp-v.example.com.       IN  A 192.168.0.201
api-int.uae-ocp-v.example.com.   IN  A 192.168.0.201 
*.apps.uae-ocp-v.example.com.    IN  A 192.168.0.201
dns.example.com.                IN  A 192.168.0.100
