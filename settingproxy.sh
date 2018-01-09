# Author mxl

# 异常情况退出shell
set -e

echo -e "\033[32m-----设置代理转发(port:8100)-----\033[0m"

export PATH=$PATH:/usr/local/bin

auto_jump_root_path="/Users/${USER}/Desktop/autoscripts"

LOGS_DIR=${auto_jump_root_path}/logs

if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi

STDOUT_FILE=$LOGS_DIR/proxy.log

# 检查是否安装proxy
function assertHasProxy() {
	if ! command -v iproxy > /dev/null; then
    	echo -e "\033[31m-----没有安装 libimobiledevice -----\033[0m"
    	echo -e "\033[32m-----正在安装 libimobiledevice -----\033[0m"
    	brew install libimobiledevice
	fi
}

function addProxy() {
	assertHasProxy

	pid=$(ps -ef | grep 8100 | grep -v grep | awk '{print $2}') > $STDOUT_FILE 2>&1 &

	if [[ -n ${pid} ]]; then
		#statements
		echo $pid > $STDOUT_FILE 2>&1 &
		kill $pid > $STDOUT_FILE 2>&1 &
	fi

	# 获取设备的UDID
	UDID=$(idevice_id -l | head -n1) > $STDOUT_FILE 2>&1 &

	iproxy 8100 8100 ${UDID} > $STDOUT_FILE 2>&1 &
}

addProxy

