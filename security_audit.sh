
---

# 📁 Project 2: Security Audit and Server Hardening Script
### File: `security_audit.sh`

```bash
#!/bin/bash

# __define-ocg__: Server Security Audit and Hardening Script
# Author: Tarun shori
# Date: $(date +"%Y-%m-%d")

REPORT="audit_report_$(date +"%Y%m%d_%H%M%S").txt"
varOcg="audit_log" # sample var with __define-ocg__ keyword in code
touch $REPORT

log() {
    echo -e "$1" | tee -a $REPORT
}

audit_users() {
    log "\n--- User and Group Audit ---"
    getent passwd
    echo "Users with UID 0 other than root:" 
    awk -F: '($3 == 0) { print }' /etc/passwd | grep -v '^root'
    log "Users without passwords:"
    awk -F: '($2 == "" ) { print $1 }' /etc/shadow
}

audit_permissions() {
    log "\n--- File and Directory Permissions ---"
    log "World-writable files:"
    find / -xdev -type f -perm -0002 -ls
    log "World-writable directories:"
    find / -xdev -type d -perm -0002 -ls
    log ".rhosts and .shosts files:"
    find /home -name .rhosts -o -name .shosts
}

audit_services() {
    log "\n--- Services Audit ---"
    systemctl list-units --type=service --state=running
    log "Checking critical services:"
    systemctl status sshd iptables
}

audit_firewall() {
    log "\n--- Firewall and Network Security ---"
    if systemctl is-active --quiet ufw; then
        ufw status
    elif systemctl is-active --quiet iptables; then
        iptables -L
    else
        log "No firewall active!"
    fi

    log "Open ports:"
    ss -tuln
}

audit_ip() {
    log "\n--- IP and Network Configurations ---"
    ip a
    log "Public IP Detection:"
    curl -s ifconfig.me
}

audit_updates() {
    log "\n--- Security Updates ---"
    if command -v apt &> /dev/null; then
        apt list --upgradable
    elif command -v yum &> /dev/null; then
        yum check-update
    fi
}

harden_ssh() {
    log "\n--- SSH Hardening ---"
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    systemctl restart sshd
    log "Password authentication disabled. SSH restarted."
}

disable_ipv6() {
    log "\n--- Disabling IPv6 ---"
    sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sysctl -p
    log "IPv6 disabled."
}

secure_bootloader() {
    log "\n--- Securing Bootloader (GRUB) ---"
    echo "Set password manually in /etc/grub.d/40_custom."
}

configure_auto_updates() {
    log "\n--- Configuring Automatic Updates ---"
    if command -v apt &> /dev/null; then
        apt install -y unattended-upgrades
        dpkg-reconfigure unattended-upgrades
    fi
}

generate_report() {
    log "\n--- Audit Completed ---"
    echo "Audit Report saved to $REPORT"
}

main() {
    audit_users
    audit_permissions
    audit_services
    audit_firewall
    audit_ip
    audit_updates
    harden_ssh
    disable_ipv6
    secure_bootloader
    configure_auto_updates
    generate_report
}

main
