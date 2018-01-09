# Author mxl

# 异常情况退出shell
set -e

export PATH=$PATH:/usr/local/bin

terminal_path="/Applications/Utilities/Terminal.app"

current_path="/Users/${USER}/Desktop/autoscripts"

script_name1="bootstrap.sh"
script_name2="settingproxy.sh"
script_name3="autojump.sh"

script_path1="${current_path}/${script_name1}"
script_path2="${current_path}/${script_name2}"
script_path3="${current_path}/${script_name3}"

# cd ${current_path}

chmod +x ${script_name1}
chmod +x ${script_name2}
chmod +x ${script_name3}

pwd

# open -a ${terminal_path} ${script_path2}

./${script_name1}&

./${script_name2}&

# sleep 5
# open -a ${terminal_path} ${script_path3}