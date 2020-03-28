[{{ env }}-dbserver]
host1 ansible_host={{ host_ip }}

[dev-dbserver:vars]
max_connections={{ max_conns }}
