#!/bin/bash

# __define-ocg__: Advanced System Monitor Dashboard with Trends and Custom Services
# Author: Tarun shori
# Date: $(date +"%Y-%m-%d")

refresh_interval=2

# Customize monitored services here
custom_services=("sshd" "nginx" "iptables" "docker" "mysql")

# Store old network bytes for bandwidth calculation
prev_rx=0
prev_tx=0

# For CPU/Memory trend graph
cpu_trend=()
mem_trend=()

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Generate a progress bar
progress_bar() {
    local value=$1
    local total=20
    local filled=$(( (value * total) / 100 ))
    local empty=$(( total - filled ))
    printf '%0.s#' $(seq 1 $filled)
    printf '%0.s.' $(seq 1 $empty)
}

# Create tiny trend graph
trend_graph() {
    local -n arr=$1
    local out=""
    for val in "${arr[@]}"; do
        if (( val < 20 )); then out+="."; 
        elif (( val < 40 )); then out+=":"; 
        elif (( val < 60 )); then out+="*"; 
        elif (( val < 80 )); then out+="o"; 
        else out+="O"; 
        fi
    done
    printf "%-20s" "$out"
}

cpu_info() {
    read cpu_idle < <(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    load_avg=$(uptime | awk -F'load average:' '{ print $2 }' | sed 's/ //g')
    cpu_bar=$(progress_bar ${cpu_idle%.*})

    cpu_trend+=(${cpu_idle%.*})
    [[ ${#cpu_trend[@]} -gt 20 ]] && cpu_trend=("${cpu_trend[@]:1}")

    printf "| CPU Usage:     | %-20s | %3s%% | Load Avg: %s |\n" "$cpu_bar" "${cpu_idle%.*}" "$load_avg"
}

memory_info() {
    mem_total=$(free -m | awk '/Mem:/ {print $2}')
    mem_used=$(free -m | awk '/Mem:/ {print $3}')
    mem_percent=$((mem_used * 100 / mem_total))

    swap_used=$(free -m | awk '/Swap:/ {print $3}')
    swap_total=$(free -m | awk '/Swap:/ {print $2}')

    mem_bar=$(progress_bar $mem_percent)

    mem_trend+=(${mem_percent})
    [[ ${#mem_trend[@]} -gt 20 ]] && mem_trend=("${mem_trend[@]:1}")

    printf "| Memory:        | %-20s | %3s%% | Swap: ${swap_used}MB / ${swap_total}MB |\n" "$mem_bar" "$mem_percent"
}

disk_info() {
    disk_percent=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    disk_bar=$(progress_bar $disk_percent)

    var_usage=$(df /var 2>/dev/null | awk 'NR==2 {print $5}' | tr -d '%')
    if [[ -n $var_usage && $var_usage -ge 90 ]]; then
        var_status="${RED}Warning: /var ${var_usage}% used!${NC}"
    else
        var_status="OK"
    fi

    printf "| Disk:          | %-20s | %3s%% | %-22s |\n" "$disk_bar" "$disk_percent" "$var_status"
}

top_processes() {
    echo -e "\nTop Processes (CPU & Mem)"
    echo "-------------------------------------"
    echo "# | Process Name | CPU (%) | Mem (MB) |"
    echo "--|--------------|---------|----------|"
    ps -eo comm,%cpu,%mem --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "%d | %-12s | %-7s | %-8s\n", NR-1, $1, $2, $3}' 
    echo "-------------------------------------"
}

network_info() {
    echo -e "\nNetwork Monitoring"
    echo "-------------------------------------"

    rx_bytes=$(cat /sys/class/net/$(ip route get 8.8.8.8 | awk '{print $5}')/statistics/rx_bytes)
    tx_bytes=$(cat /sys/class/net/$(ip route get 8.8.8.8 | awk '{print $5}')/statistics/tx_bytes)

    if [[ $prev_rx -gt 0 ]]; then
        rx_diff=$((rx_bytes - prev_rx))
        tx_diff=$((tx_bytes - prev_tx))
        rx_mbps=$(awk "BEGIN {print $rx_diff*8/1024/1024/$refresh_interval}")
        tx_mbps=$(awk "BEGIN {print $tx_diff*8/1024/1024/$refresh_interval}")
    else
        rx_mbps=0
        tx_mbps=0
    fi

    active_conn=$(ss -tun | tail -n +2 | wc -l)
    packet_drops=$(netstat -s | grep -i "dropped" | awk '{sum+=$1} END {print sum+0}')

    printf "Active Connections: %-5s | Packet Drops: %-5s\n" "$active_conn" "$packet_drops"
    printf "Download: %6.2f Mbps | Upload: %6.2f Mbps\n" "$rx_mbps" "$tx_mbps"
    echo "-------------------------------------"

    prev_rx=$rx_bytes
    prev_tx=$tx_bytes
}

services_info() {
    echo -e "\nServices Status"
    echo "--------------------------------------------------------------"
    for service in "${custom_services[@]}"; do
        if systemctl is-active --quiet $service; then
            printf "| %-10s: [${GREEN}RUNNING${NC}] " "$service"
        else
            printf "| %-10s: [${RED}STOPPED${NC}] " "$service"
        fi
    done
    echo "|"
    echo "--------------------------------------------------------------"
}

trend_section() {
    echo -e "\nCPU & Memory Usage Trend"
    echo "--------------------------------------------------------------"
    printf "CPU : "
    trend_graph cpu_trend
    echo
    printf "MEM : "
    trend_graph mem_trend
    echo
    echo "--------------------------------------------------------------"
}

full_dashboard() {
    clear
    echo "---------------------- SYSTEM MONITOR DASHBOARD ----------------------"
    cpu_info
    memory_info
    disk_info
    echo "----------------------------------------------------------------------"
    top_processes
    network_info
    services_info
    trend_section
    echo -e "\nPress [Q] to exit | Refreshing every ${refresh_interval}s..."
}

while true; do
    full_dashboard
    read -t $refresh_interval -n 1 key
    if [[ $key == "q" || $key == "Q" ]]; then
        echo "Exiting..."
        exit 0
    fi
done
