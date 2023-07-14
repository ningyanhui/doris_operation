#!/bin/bash

# shellcheck disable=SC2086
workDir=$(dirname $0)
# shellcheck disable=SC2164
workDir=$(cd ${workDir};pwd)

source ${workDir}/env/install_env.sh



# shellcheck disable=SC2206
hostsArr=(${ips//,/ })
# shellcheck disable=SC2068
# shellcheck disable=SC2154
for host in ${hostsArr[@]}
do

  # shellcheck disable=SC2154
  if ! ssh -o StrictHostKeyChecking=no -p $sshPort $host test -e $installPath; then
    ssh -o StrictHostKeyChecking=no -p $sshPort $host "sudo mkdir -p $installPath; sudo chown -R $deployUser:$deployUser $installPath"
  fi

  echo "scp dirs to $host/$installPath starting"

  for i in ${!workerNames[@]}; do
    # shellcheck disable=SC2053
    if [[ ${workerNames[$i]} == $host ]]; then
      workerIndex=$i
      break
    fi
  done

done
