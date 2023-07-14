#!/bin/bash

# shellcheck disable=SC2086
workDir=$(dirname $0)
workDir=$(cd ${workDir} || exit;pwd)

source ${workDir}/env/install_env.sh

echo "1.create directory"

# If install Path equal to "/" or related path is "/" or is empty, will cause directory "/bin" be overwrite or file adding,
# so we should check its value. Here use command `realpath` to get the related path, and it will skip if your shell env
# without command `realpath`.
if [ ! -d "$installPath" ];then
  sudo mkdir -p "$installPath"
  # shellcheck disable=SC2154

  sudo chown -R $deployUser:$deployUser $installPath
elif [[ -z "${installPath// }" || "${installPath// }" == "/" || ( $(command -v realpath) && $(realpath -s "${installPath}") == "/" ) ]]; then
  echo "Parameter installPath can not be empty, use in root path or related path of root path, currently use ${installPath}"
  exit 1
fi

echo "2.scp resource"
bash ${workDir}/scp-hosts.sh
# shellcheck disable=SC2181
if [ $? -eq 0 ];then
	echo 'scp copy completed'
else
	echo 'scp copy failed to exit'
	exit 1
fi

echo "3.stop server"
bash ${workDir}/stop-all.sh


echo "4.startup"
bash ${workDir}/start-all.sh

echo "5.config mysql"
bash ${workDir}/config-mysql.sh