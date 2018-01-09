# Author mxl

# 异常情况退出shell
set -e

export PATH=$PATH:/usr/local/bin

if [[ -n $1 ]]; then
	#statements
	echo -e "\033[31m-----请加上电脑密码作为参数运行(ex:./autoJumpStep1 password)----\033[0m"
	exit 1
fi

auto_jump_root_path="/Users/${USER}/Desktop/autoscripts"

LOGS_DIR=${auto_jump_root_path}/logs

if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi

STDOUT_FILE=$LOGS_DIR/bootstrap.log

echo "${auto_jump_root_path}"

auto_jump_path="${auto_jump_root_path}/xl_jump_root_path"


if [[ ! -d "${auto_jump_path}" ]]; then
	mkdir "${auto_jump_path}"
fi

cd ${auto_jump_path}

# 

wda_path="${auto_jump_path}/WebDriverAgent"

if [[ ! -d "${wda_path}" ]]; then

	# git clone https://github.com/facebook/WebDriverAgen
	
	echo -e "\033[32m-----${wda_path}-----\033[0m"

	echo -e "\033[32m-----wda下载完成-----\033[0m"
fi

if [[ ! -d "${wda_path}" ]]; then
	echo -e "\033[31m-----wda下载失败-----\033[0m"
	exit 1
fi

cd ${wda_path}

# ./Scripts/bootstrap.sh

# echo -n "输入电脑密码:?"
# read answer
# if echo "$answer" | grep -iq "^" ;then
# 	echo Yes
# else
# 	echo No
# fi

# echo -n "输入电脑密码:"

# read name

PASSWORD="$1"

security unlock-keychain -p $PASSWORD ~/Library/Keychains/login.keychain

# 获取设备的UDID
UDID=$(idevice_id -l | head -n1)

# ideviceinfo -s

# 运行测试
xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner -destination "id=$UDID" test





