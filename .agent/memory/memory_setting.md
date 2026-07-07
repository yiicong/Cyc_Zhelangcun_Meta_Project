
# 项目介绍
- 这是一个个人网站项目，未来会在里面添加各种小功能。
- 本项目目前已完成后端基础框架的初始化，技术栈如下：
  - JDK 8
  - Spring Boot 2.1.13.RELEASE
  - Maven 依赖管理
  - 数据库：MariaDB (驱动包：`mariadb-java-client`)
  - 日志系统：Log4j2 (排除了 Spring Boot 默认的 logging，引入了 `spring-boot-starter-log4j2`)

# 项目结构
- 这是个多目录的工作区
  - 项目代码统一放在了 cyc_zhelangcun 文件夹下面。
  - 本项目已重构为 Maven 多模块项目，结构划分如下：
    - `cyc-start` (系统启动模块)
    - `cyc-static` (前端静态资源模块)：专门用于统一承载所有的前端 HTML/CSS/JS 静态网页文件及媒体资源，不包含任何 Java 源码。
    - `cyc-api` (前端接口模块)：包含核心接口控制器（Controller）与登录过滤器（Filter）。
    - `cyc-service` (业务核心模块)：承载系统的核心业务 Service 逻辑。
    - `cyc-infra` (基础设施模块)：包含持久层实体 与 Mapper 数据库访问接口及 XML 映射文件。

# 表结构设计
- 如果你需要了解表结构，表结构设计在工程根目录的 docs/项目所有表结构.sql

# 详细设计
- 如果你需要了解系统详细设计，文档在 docs/详细设计.md
- 如果新加/修改了功能，你一定要同步更新详细设计

