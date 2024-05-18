#!/bin/bash

# Revision of sgrep v1.2 (Jacob O.)

# JetSwapper v1.2.4

########################
### Color  Variables ###
########################
green='\e[32m'
blue='\e[34m'
clear='\e[0m'
orange='\e[33m'
red='\e[31m'

#########################
###  Color Functions  ###
#########################

ColorGreen(){
    echo -ne $green$1$clear
}
ColorBlue(){
    echo -ne $blue$1$clear
}
ColorRed(){
    echo -ne $red$1$clear
}
ColorOrange(){
    echo -ne $orange$1$clear
}

# Upgraded smem function
function smem () {
    overall=0
    echo -e "$(ColorBlue "Name")\t\t\t\t\t$(ColorBlue "Total Swap")"
    echo -e "-----------------------------------------------------------------------------"
    declare -A proc_swap

    for status_file in /proc/*/status; do
        if [ -e "$status_file" ]; then
            swap_mem=$(grep VmSwap "$status_file" | awk '{ print $2 }')
            if [ "$swap_mem" ] && [ "$swap_mem" -gt 0 ]; then
                pid=$(basename $(dirname "$status_file"))
                name=$(grep Name "$status_file" | awk -F':' '{ print $2 }' | tr -d '[:space:]')
                swap_size=$(echo "$swap_mem*1024" | bc) # convert to bytes
                overall=$((overall+swap_size))
                if [[ ! ${proc_swap[$name]} ]]; then
                    proc_swap[$name]=$swap_size
                else
                    proc_swap[$name]=$((proc_swap[$name]+swap_size))
                fi
            fi
        fi
    done

    for name in "${!proc_swap[@]}"; do
        printf "%-40s%s\n" "$name" "$(numfmt --to=iec-i --suffix=B --padding=9 ${proc_swap[$name]})"
    done | sort -k2 -h -r

    echo -e "-----------------------------------------------------------------------------"
    printf "%-65s%s\n" "$(ColorBlue "Total Swapped Memory:")" "$(numfmt --to=iec-i --suffix=B --padding=9 $overall)"
}

# Print fallback
function fallback () {
    echo -e "$(ColorOrange "jrctl service command not found. Falling back to jrctl SERVER...")"
}

function finished () {
    echo -e "$(ColorGreen "RESTARTED")"
}

echo ""
echo -e "$(ColorGreen "SGREP.SH v1.3")"
echo -e "\nChecking Swap...\n"

# jrctl access check
if jrctl service list 2>&1 | grep 'No entries' &> /dev/null; then
    echo "jrctl service does not have access to restart services. Exiting..."
    exit 0
fi

if jrctl server list 2>&1 | grep 'No entries' &> /dev/null; then
    echo -e "\njrctl server does not have access to restart services. Exiting..."
    exit 0
fi

# Save smem output to file to save time (1 run vs multiple)
smem > .smem-temp
# Grab php-fpm versions
grep php-fpm .smem-temp > .phpfpm-temp

echo -e "Common Services Breakdown\n"

echo -e "$(ColorGreen "MYSQL")"
grep mysql .smem-temp
echo -e ""

echo -e "$(ColorGreen "ELASTICSEARCH")"
grep java .smem-temp
echo -e ""

echo -e "$(ColorGreen "REDIS")"
grep redis .smem-temp
echo -e ""

echo -e "$(ColorGreen "VARNISH")"
grep cache-main .smem-temp
echo -e ""

# Process php-fpm versions into a nicer format for jrctl
echo -e "$(ColorGreen "PHP-FPM VERSIONS")"
cut -f1 -d' ' .phpfpm-temp | sort | uniq > .phpfpmversions
sed -i 's/fpm/fpm-/g' .phpfpmversions
grep -Eo 'php-fpm-[0-9].[0-9]' .phpfpmversions > .phpfpmversions-clean
cat .phpfpmversions-clean
echo -e ""

# Build array for jrctl-compatible php-fpm version names
mapfile -t phpversions < <(cat .phpfpmversions-clean)

# Service restarts with check/fallback for service vs server
function restart_service {
    local service=$1
    read -p "Would you like to restart $service? " -n 1 -r
    echo -e "\n"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if jrctl service restart $service 2>&1 | grep 'Error' &> /dev/null; then
            fallback
            jrctl server restart $service
        fi
        finished
    fi
    echo -e "\n"
}

restart_service "PHP-FPM services" ${phpversions[@]}
restart_service "ELASTICSEARCH" "elasticsearch"
restart_service "VARNISH" "varnish"
restart_service "REDIS" "redis-cache"

echo -e "$(ColorGreen "SCRIPT COMPLETE. EXITING...")"

# File cleanup
rm .smem-temp
rm .phpfpm-temp
rm .phpfpmversions
rm .phpfpmversions-clean
