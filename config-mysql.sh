#!/bin/bash

# shellcheck disable=SC2086
workDir=$(dirname $0)
# shellcheck disable=SC2164
workDir=$(cd ${workDir};pwd)

source ${workDir}/env/install_env.sh

# shellcheck disable=SC2206
feFollowerHost=(${feFollowers//,/ })
# shellcheck disable=SC2068
# shellcheck disable=SC2154
for follower in ${feFollowerHost[@]}

do
  echo "add fe follower $follower "
	statement="ALTER SYSTEM ADD FOLLOWER "$follower:$edit_log_port""
	echo "mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e \"$statement\" "
	mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e "$statement"
done

# shellcheck disable=SC2206
feObserverHost=(${feObserver//,/ })
# shellcheck disable=SC2068
# shellcheck disable=SC2154
for observer in ${feObserverHost[@]}

do
  echo "add fe observer $observer "
	statement="ALTER SYSTEM ADD FOLLOWER "$observer:$edit_log_port""
	echo "mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e \"$statement\" "
	mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e "$statement"
done

# shellcheck disable=SC2206
beHost=(${beNodes//,/ })
# shellcheck disable=SC2068
# shellcheck disable=SC2154
for be in ${beHost[@]}

do
  echo "add be BACKEND  $be "
	statement=" ALTER SYSTEM ADD BACKEND "$be:$be_heartbeat_service_port""
	echo "mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e \"$statement\" "
	mysql -h ${feFollowerHost[0]} -u root -P $fe_query_port -e "$statement"
done
