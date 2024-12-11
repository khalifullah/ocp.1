$TTL 1W
@   IN  SOA ns1.vcenterlocalhost.com. root.vcenterlocalhost.com. (
            2024112701  ; serial (updated from 2019070700)
            3H          ; refresh (3 hours)
            30M         ; retry (30 minutes)
            2W          ; expiry (2 weeks)
            1W )        ; minimum (1 week)
    IN  NS  ns1.vcenterlocalhost.com.
    IN  MX 10 smtp.vcenterlocalhost.com.

pocenv.local                 IN  A 172.20.22.53
ns1.vcenterlocalhost.com.             IN  A 172.40.20.200  ; Primary nameserver
smtp.vcenterlocalhost.com.            IN  A 172.40.20.200  ; Mail server
helper.vcenterlocalhost.com.          IN  A 172.40.20.200  ; Helper server
api.mohammed.vcenterlocalhost.com.        IN  A 172.40.20.200  ; API server
api-int.mohammed.vcenterlocalhost.com.    IN  A 172.40.20.200  ; Internal API load balancer
*.apps.mohammed.vcenterlocalhost.com.     IN  A 172.40.20.200  ; Wildcard record for applications

mohammed-bootstrap.mohammed.vcenterlocalhost.com. 86400 IN A 172.40.20.206   ; Bootstrap node

mohammed-master-1.mohammed.vcenterlocalhost.com.  IN  A 172.40.20.201  ; Control plane node 0
mohammed-master-2.mohammed.vcenterlocalhost.com.  IN  A 172.40.20.202  ; Control plane node 1
mohammed-master-3.mohammed.vcenterlocalhost.com.  IN  A 172.40.20.203  ; Control plane node 2

mohammed-worker-1.mohammed.vcenterlocalhost.com.    IN  A 172.40.20.204  ; Worker node 0
mohammed-worker-2.mohammed.vcenterlocalhost.com.    IN  A 172.40.20.205  ; Worker node 1
mohammed-worker-3.mohammed.vcenterlocalhost.com.    IN  A 172.40.20.207  ; Worker node 2
