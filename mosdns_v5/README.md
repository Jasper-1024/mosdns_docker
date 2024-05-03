
## 使用前

dashboard/mosdns/config/dns.yaml 的 addr 为本地运营商 dns 地址

```yaml
  # local dns
  - tag: local
    type: forward
    args:
      concurrent: 1
      upstreams:
        - addr: "udp://192.168.1.1:53" # 更新为本地 dns 地址, 一般是 网关地址
```

dashboard/mosdns/config/dat_exec.yaml 的 preset 为本地公网 ip

```yaml
  # 附加 ecs cn 信息
  - tag: ecs_cn
    type: "ecs_handler"
    args:
      forward: false # 是否转发来自下游的 ecs
      preset: 202.120.2.100 # 发送预设 ecs
      send: false # 是否发送 ecs
      mask4: 24 # ipv4 掩码。默认 24
      mask6: 48 # ipv6 掩码。默认 48
```