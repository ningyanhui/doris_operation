#!/bin/bash

# shellcheck disable=SC2086
workDir=$(dirname $0)
workDir=$(cd ${workDir} || exit;pwd)

source ${workDir}/env/install_env.sh

# shellcheck disable=SC2206

feHost=(${feNodes//,/ })
# shellcheck disable=SC2068
for fe in ${feHost[@]}
do
  echo "$fe fe server is stopping"
	# shellcheck disable=SC2154
	ssh -o StrictHostKeyChecking=no -p $sshPort $fe  "cd $installPath/; bash fe/bin/stop_fe.sh ;"

done

# shellcheck disable=SC2206
beHost=(${beNodes//,/ })
# shellcheck disable=SC2068
for be in ${beHost[@]}
do
  echo "$be be server is stopping"
	# shellcheck disable=SC2154
	ssh -o StrictHostKeyChecking=no -p $sshPort $be  "cd $installPath/; bash be/bin/stop_be.sh ;"

done