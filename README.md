<!-- 该文档是模板生成，手动修改的内容会被覆盖，详情参见：https://github.com/quicklyon/template-toolkit -->
# QuickOn ZincSearch 应用镜像

[![GitHub Workflow Status](https://github.com/quicklyon/zincsearch-docker/actions/workflows/docker.yml/badge.svg)](https://github.com/quicklyon/zincsearch/actions/workflows/docker.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/easysoft/zincsearch?style=flat-square)
![Docker Image Size](https://img.shields.io/docker/image-size/easysoft/zincsearch?style=flat-square)
![GitHub tag](https://img.shields.io/github/v/tag/quicklyon/zincsearch-docker?style=flat-square)

> 申明: 该软件镜像是由QuickOn打包。在发行中提及的各自商标由各自的公司或个人所有，使用它们并不意味着任何从属关系。

## 快速参考

- 通过 [渠成软件百宝箱](https://www.qucheng.com/app-install/install-zincsearch-<number>.html) 一键安装 **ZincSearch**
- [Dockerfile 源码](https://github.com/quicklyon/zincsearch-docker)
- [ZincSearch 源码](https://github.com/zinclabs/zinc)
- [ZincSearch 官网](https://zincsearch.com/)

## 一、关于 ZincSearch

<!-- 这里写应用的【介绍信息】 -->
Zinc 是一款支持全文索引的搜索引擎。是 Elasticsearch 的轻量级替代品，只需要很少的资源就可以运行。它使用 bluge 作为底层索引库。

它非常简单且易于操作，而 Elasticsearch 需要几十个概念与配置来理解和调整，Zinc 可以在 2 分钟内启动和使用它。

如果您只是使用 API 获取数据并使用 kibana 进行搜索，它是 Elasticsearch 的直接替代品（Zinc 不支持 Kibana。Zinc 提供了自己的 UI）。

![screenshots](https://raw.githubusercontent.com/quicklyon/zincsearch-docker/master/.template/screenshot.jpeg)

ZincSearch官网：[https://zincsearch.com/](https://zincsearch.com/)

<!-- 这里写应用的【附加信息】 -->
## 1.1 为什么使用Zinc

虽然 Elasticsearch 是一个非常好的产品，但它很复杂，需要大量资源，并且已有十多年的历史。 我们构建了 Zinc，这样人们就可以更轻松地使用全文搜索索引，而无需做很多工作。

## 1.2 特性

- 提供全文索引功能
- 用于安装和运行的独立二进制文件。 支持多平台运行。
- 用 Vue 编写的数据的 Web UI用于数据查询。
- 与 Elasticsearch API 兼容以获取数据（单记录和批量 API）
- 开箱即用的身份验证
- Schema less - 无需预先定义模式，同一索引中的不同文档可以有不同的字段。
- 支持磁盘中的索引存储（默认）、s3 或 minio（实验性）
- 聚合支持

## 二、支持的版本(Tag)

由于版本比较多,这里只列出最新的5个版本,更详细的版本列表请参考:[可用版本列表](https://hub.docker.com/r/easysoft/zincsearch/tags/)

<!-- 这里是镜像的【Tag】信息，通过命令维护，详情参考：https://github.com/quicklyon/template-toolkit -->
- [latest](https://github.com/zinclabs/zinc/releases)
- [0.2.9](https://github.com/zinclabs/zinc/releases/tag/v0.2.9)

## 三、获取镜像

推荐从 [Docker Hub Registry](https://hub.docker.com/r/easysoft/zincsearch) 拉取我们构建好的官方Docker镜像。

```bash
docker pull easysoft/zincsearch:latest
```

如需使用指定的版本,可以拉取一个包含版本标签的镜像,在Docker Hub仓库中查看 [可用版本列表](https://hub.docker.com/r/easysoft/zincsearch/tags/)

```bash
docker pull easysoft/zincsearch:[TAG]
```

## 四、持久化数据

如果你删除容器，所有的数据都将被删除，下次运行镜像时会重新初始化数据。为了避免数据丢失，你应该为容器提供一个挂在卷，这样可以将数据进行持久化存储。

为了数据持久化，你应该挂载持久化目录：

- /data 持久化数据

如果挂载的目录为空，首次启动会自动初始化相关文件

```bash
$ docker run -it \
    -v $PWD/data:/data \
docker pull easysoft/zincsearch:latest
```

或者修改 docker-compose.yml 文件，添加持久化目录配置

```bash
services:
  ZincSearch:
  ...
    volumes:
      - /path/to/persistence:/data
  ...
```

## 五、环境变量

<!-- 这里写应用的【环境变量信息】 -->
| 变量名           | 默认值        | 说明                             |
| ---------------- | ------------- | -------------------------------- |
| EASYSOFT_DEBUG   | false         | 是否打开调试信息，默认关闭       |
| GIN_MODE   | release         | 默认生产模式       |
| DEFAULT_ADMIN_USER| admin        | 默认管理员名称             |
| DEFAULT_ADMIN_PASSWORD | pass4Zinc | 默认管理员密码 |

## 六、运行

### 6.1 单机Docker-compose方式运行

```bash
# 启动服务
make run

# 查看服务状态
make ps

# 查看服务日志
docker-compose logs -f zincsearch

```

<!-- 这里写应用的【make命令的备注信息】位于文档最后端 -->
**说明:**

- 启动成功后，打开浏览器输入 `http://<你的IP>:8080` 访问管理后台
- 默认用户名：`admin`，默认密码：`pass4Zinc`
- [VERSION](https://github.com/quicklyon/zincsearch-docker/blob/master/VERSION) 文件中详细的定义了Makefile可以操作的版本
- [docker-compose.yml](https://github.com/quicklyon/zincsearch-docker/blob/master/docker-compose.yml)

## 七、版本升级

<!-- 这里是应用的【应用升级】信息，通过命令维护，详情参考：https://github.com/quicklyon/doc-toolkit -->
容器镜像已为版本升级做了特殊处理，当检测数据（数据库/持久化文件）版本与镜像内运行的程序版本不一致时，会进行数据库结构的检查，并自动进行数据库升级操作。

因此，升级版本只需要更换镜像版本号即可：

> 修改 docker-compose.yml 文件

```diff
...
  zincsearch:
-    image: easysoft/zincsearch:0.2.8-20220701
+    image: easysoft/zincsearch:0.2.9-20220822
    container_name: zincsearch
...
```

更新服务

```bash
# 是用新版本镜像更新服务
docker-compose up -d

# 查看服务状态和镜像版本
docker-compose ps
```