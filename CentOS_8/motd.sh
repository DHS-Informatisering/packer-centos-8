#!/bin/bash
clear
DISTRIB_DESCRIPTION=$(cat /etc/centos-release)
DISPLAYNAME=$(hostname -s)
IP=$(hostname -I)
#change 'CentOS' to something else, if you want to name your server or display a phrase
#DISPLAYNAME=CentOS
LOLCAT=/usr/local/bin/lolcat #whereis lolcat if your system put it somewhere else
printf "\n"
figlet $DISPLAYNAME | $LOLCAT -f
printf "\n"

printf "Hostname:\t$(hostname -f)"
printf "\n"
printf "IPv4:\t\t$IP\n"
printf "OS:\t\t%s\nKernel:\t\t%s\n" "$DISTRIB_DESCRIPTION" "$(uname -r)"
printf "\n"


date=$(date)
LOAD1=$(cat /proc/loadavg | awk '{print $1}')
LOAD5=$(cat /proc/loadavg | awk '{print $2}')
LOAD15=$(cat /proc/loadavg | awk '{print $3}')

# uptime
uptime=$(cat /proc/uptime | cut -f1 -d.)
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))

# filesystem info
root_usage=$(df -h / | awk '/\// {print $4}'|grep -v "^$")

# memory
memory_usage=$(free -t -m | grep Total | awk '{print $3;}')
total_memory=$(free -t -m | grep "Mem" | awk '{print $2" MB";}')
swap_usage=$(free -m | awk '/Swap/ { printf("%3.1f%%", $3/$2*100) }')

# users
users=$(users | wc -w)

# processes
processes=$(ps aux | wc -l)

printf "System information as of: %s\n\n" "$date"
printf "System Load:\t%s %s %s\n" "$LOAD1", "$LOAD5", "$LOAD15"
printf "System Uptime:\t%s days %s hours %s min %s sec\n" "$upDays" "$upHours" "$upMins" "$upSecs"
printf "Memory Usage:\t%s\n" "$memory_usage"/"$total_memory"
printf "Swap Usage:\t%s\n" "$swap_usage"
printf "Free on Disk:\t%s\n" "$root_usage"
printf "Processes:\t%s\t\t\t\n" "$processes"
printf "SFTP Accounts:\t%s\n\n" "$users"
#include the updater; sourced from update-check.sh
#source /etc/update-motd.d/90-updates-available
printf "\n\n"