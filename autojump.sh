# Author mxl

# iPhone5,1	iPhone 5
# iPhone5,2	iPhone 5 (GSM+CDMA)
# iPhone5,3	iPhone 5c (GSM)
# iPhone5,4	iPhone 5c (GSM+CDMA)
# iPhone6,1	iPhone 5s (GSM)
# iPhone6,2	iPhone 5s (GSM+CDMA)
# iPhone7,1	iPhone 6 Plus
# iPhone7,2	iPhone 6
# iPhone8,1	iPhone 6s
# iPhone8,2	iPhone 6s Plus
# iPhone8,4	iPhone SE
# iPhone9,1	国行、日版、港行iPhone 7
# iPhone9,2	港行、国行iPhone 7 Plus
# iPhone9,3	美版、台版iPhone 7
# iPhone9,4	美版、台版iPhone 7 Plus

#iPhone10,1 和 iPhone10,4  8
#iPhone10,2 和 iPhone10,5  8p
set -e

export PATH=$PATH:/usr/local/bin

google_path='/Applications/Google Chrome.app'
safari_path="/Applications/Safari.app"
listen_url="http://localhost:8100/status"

desktop_path="/Users/${USER}/Desktop"

auto_jump_path="${desktop_path}/xl_jump_root_path"

auto_jump_root_path="${auto_jump_path}/wechat_jump_game"

auto_jump_config_path="${auto_jump_root_path}/config.json"


product_type=$(ideviceinfo -s -k ProductType)

screen_file="1280x720"

case ${product_type} in
	"iPhone7,2" ) # 6
		screen_file="1280x720"
		;;
	"iPhone8,1" ) # 6s
		screen_file="1280x720"
		;;
	"iPhone9,1" ) # 7
		screen_file="1280x720"
		;;
	"iPhone9,3" ) # 7
		screen_file="1280x720"
		;;
	"iPhone10,1" ) # 8
		screen_file="1280x720"
		;;
	"iPhone10,4" ) # 8
		screen_file="1280x720"
		;;

	"iPhone7,1" ) # 6p
		screen_file="1920x1080"
		;;
	"iPhone8,2" ) # 6sp
		screen_file="1920x1080"
		;;
	"iPhone9,2" ) # 7p
		screen_file="1920x1080"
		;;
	"iPhone9,4" ) # 7p
		screen_file="1920x1080"
		;;
 	"iPhone10,2" ) # 8p
		screen_file="1920x1080"
		;;
	"iPhone10,5" ) # 8p
		screen_file="1920x1080"
		;;
	*)
		echo -e "\033[31m-----没有找到跟你手机对应的配置文件-----\033[0m"
		exit 1
	;;
esac

auto_jump_configs_path="${auto_jump_root_path}/config/${screen_file}/config.json"

function checkfileExist() {
	if [[ -d '$1' ]]; then
		return 1
	else
		return 0
	fi
}

right="1"
has_google_file="1"

if [ -d '/Applications/Google Chrome.app' ]; then
  # Control will enter here if $DIRECTORY exists.
  	has_google_file="1"
else
	has_google_file="0"
fi

# echo -e "\033[32m-----${right} ${has_google_file}-----\033[0m"

if test ${right} -eq ${has_google_file}

then
	#statements
	open -a '/Applications/Google Chrome.app' "${listen_url}"
else
	open -a ${safari_path} '${listen_url}'
fi

# 检查是否安装python3
function assertHasPY3() {
	if ! command -v python3 > /dev/null; then
    	echo -e "\033[31m-----没有安装 python3 -----\033[0m"
    	echo -e "\033[32m-----正在安装 python3 -----\033[0m"
    	brew install python3
	fi
}

pythonfile_version=(python3 --version)

echo -e "\033[32m-----${pythonfile_version}-----\033[0m"

# if [[ test  ]]; then
	#statements
# fi

# wda_path="/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/wda"

pip3 install --pre facebook-wda

cd ${auto_jump_path}

# git clone https://github.com/mxl123/wechat_jump_game.git

cd ${auto_jump_root_path}

if [[ -f "${auto_jump_config_path}" ]]; then
	#statements
	echo -e "\033[32m-----delete file at path ${auto_jump_config_path}-----\033[0m"
	rm -rf "${auto_jump_config_path}"
fi

cp -R ${auto_jump_configs_path} ${auto_jump_root_path}

python3 wechat_jump_auto_iOS.py

