# 安装节点
# Example for hostnames: ips="ds1,ds2,ds3,ds4,ds5", Example for IPs: ips="192.168.8.1,192.168.8.2,192.168.8.3,192.168.8.4,192.168.8.5"
ips=${ips:-"ds1,ds2,ds3,ds4,ds5"}

# Port of SSH protocol, default value is 22. For now we only support same port in all `ips` machine
# modify it if you use different ssh port
sshPort=${sshPort:-"22"}


# Example for hostnames: feNodes="ds1,ds2", Example for IPs: feNodes="192.168.8.1,192.168.8.2"
feNodes=${feNodes:-"ds1,ds2,ds3"}

feFollowers=${feFollowers:-"ds1"}
feObserver=${feObserver:-"ds2,ds3"}

fe_query_port=9030
fe_dit_log_port=9010
be_heartbeat_service_port=9050

# Example for hostnames: beNodes="ds1,ds2", Example for IPs: beNodes="192.168.8.1,192.168.8.2"
beNodes=${beNodes:-"be1,be2,be3"}

# Do not set this configuration same as the current path (pwd). Do not add quotes to it if you using related path.
installPath=${installPath:-"/tmp/doris"}

# to be created by this user
deployUser=${deployUser:-"root"}