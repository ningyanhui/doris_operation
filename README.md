# doris_operation
apache doris集群一键部署、启动与停止
## 使用步骤
### 使用前提
1. 完成java环境、时区同步、机器节点互通等系统环境配置
2. 下载或编译doris二进制包并解压
3. 执行节点已安装mysql客户端
4. 执行节点上已完成fe.conf,be.conf相关端口、数据存储、网络等相关配置
### 脚本使用步骤
1. 配置install_env.sh相关环境变量
2. 执行install.sh
3. 启停集群使用start-all.sh 和stop-all.sh
