# lego-tls-certs-generator

使用 lego 生成 https 证书

在 runner 所在的集群中启动一个 container

1. 使用 lego 进行申请证书
2. 使用 mc 上传到 cos 中

> **弃用** ansible 在远程机器上执行 lego 命令。


## 使用方式

创建一个新的分支, 并推送即可。

```bash
git checkout -b <provider/domains>
```

## 参数描述

```bash
# provider/domains
aliyun/wild.rockontrol.com
qcloud/wild.querycap.com
```

1. `provider`: `aliyun/qcloud` 是为了区分不同的 token
2. `domains`: wild 意味着通配置证书 `*.rockontrol.com`
3. 生成后， 会压缩并发送到 s3
  + https://ops-software-binary-1255440668.cos.ap-chengdu.myqcloud.com/nginx-certs/${domains}.tgz

