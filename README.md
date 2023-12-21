# nfv-sfc

## 拓扑

| node    | ip            | vCpu | Mem | Use        |
| ------- | ------------- | ---- | --- | ---------- |
| master  | 192.168.56.10 | 4    | 8G  |            |
| worker1 | 192.168.56.11 | 4    | 8G  | prometheus |
| worker2 | 192.168.56.12 | 4    | 8G  |            |
| worker3 | 192.168.56.13 | 4    | 8G  |            |

## 部署

### Master节点

```
git clone https://github.com/FortyWinters/nfv-sfc.git
cd nfv-sfc
sudo sh run.sh --master
```
