# README

整合实现 [vector + loki 实现 mosdns 数据看板](https://icyleaf.com/2023/08/using-vector-transform-mosdns-logging-to-grafana-via-loki/#prometheus)
- 数据已持久化, 无需重复配置.
- 效果与 blog 中一致.

LOG
- 2024-05-2: 初版, 还未尽力非常长时间测试, 有 bug 请评论或提 issue.

## 使用前

更新 prometheus/prometheus.yml

```yaml
    static_configs:
      - targets:
          - 192.168.1.1:8338 # mosdns 监听地址, 更新为 host ip 地址
```

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

## 使用

```bash
docker compose up -d
```

启动后访问 `ip:3000`

如 [vector + loki 实现 mosdns 数据看板#grafana](https://icyleaf.com/2023/08/using-vector-transform-mosdns-logging-to-grafana-via-loki/#grafana) 章节配置.
- 添加 prometheus 和 loki 的数据源后,导入 mosdns v5 看板.

## 调试

ip:9090 为 prometheus 端口