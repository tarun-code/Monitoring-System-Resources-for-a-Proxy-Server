# 📊 Advanced System Monitor Dashboard

A lightweight, interactive, real-time **System Monitoring Tool** written entirely in **Bash**.  
It monitors **CPU**, **Memory**, **Disk**, **Top Processes**, **Network Usage**, and **Service Status** with live trends, bandwidth calculation, and colored output.

---

## 🛠 Features

- ✅ **CPU Usage** with Load Average
- ✅ **Memory & Swap Usage** monitoring
- ✅ **Disk Usage** with /var warning alert
- ✅ **Top CPU and Memory Consuming Processes**
- ✅ **Network Monitoring**:
  - Active Connections
  - Packet Drops
  - Live Download/Upload Speed (Mbps)
- ✅ **Customizable Services Monitoring** (like `nginx`, `sshd`, `docker`, `mysql`)
- ✅ **Live CPU and Memory Trend Graphs** (ASCII-based)
- ✅ **Color-coded Status** (Running / Stopped Services)
- ✅ **Press Q to exit** gracefully
- ✅ **Auto-refresh every 2 seconds**

---

## 📋 Requirements

- Bash Shell
- Linux environment
- Basic system utilities like `top`, `ps`, `ss`, `df`, `ip`, `awk`, etc.

> **No external packages or dependencies needed!**

---

## 🚀 How to Run

1. **Clone or Download the Script**:

```bash
git clone <your-repo-url>
cd <project-directory>
```

2. **Make the Script Executable**:

```bash
chmod +x system_monitor_advanced.sh
```

3. **Start the Monitor**:

```bash
./system_monitor_advanced.sh
```

4. **Exit anytime** by pressing `Q`.

---

## ⚙️ Customization

- **Services to Monitor**:
  
  You can add your own services in the script:

```bash
custom_services=("sshd" "nginx" "docker" "mysql")
```

Modify this list to suit your server setup!

- **Refresh Interval**:
  
  Change how often the dashboard refreshes:

```bash
refresh_interval=2  # 2 seconds
```

---

## 📸 Screenshot

```
---------------------- SYSTEM MONITOR DASHBOARD ----------------------
| CPU Usage:     | ##########...... | 55% | Load Avg: 0.38 0.85 1.02 |
| Memory:        | ############.... | 70% | Swap: 500MB / 4GB        |
| Disk:          | ##########...... | 58% | Warning: /var 92% used!  |
----------------------------------------------------------------------
Top Processes (CPU & Mem)
-------------------------------------
# | Process Name | CPU (%) | Mem (MB) |
--|--------------|---------|----------|
1 | safesquid    | 25.4    | 1500     |
2 | clamav       | 18.2    | 1200     |
-------------------------------------

Network Monitoring
-------------------------------------
Active Connections: 128 | Packet Drops: 33
Download: 12.5 Mbps     | Upload: 3.7 Mbps
-------------------------------------

Services Status
-----------------------------------------
| sshd: [RUNNING] | nginx: [RUNNING] | docker: [STOPPED] |
-----------------------------------------

CPU & Memory Usage Trend
--------------------------------------------------------------
CPU : ...*oOoOoOoOoOoOoOoOoOo
MEM : ....:*oOoOoOoOoOoOoOoOo
--------------------------------------------------------------

Press [Q] to exit | Refreshing every 2s...
```

---

## 📦 Project Structure

| File                        | Purpose                                 |
|------------------------------|-----------------------------------------|
| `system_monitor_advanced.sh` | Main Bash script for system monitoring |
| `README.md`                  | Project documentation                  |

---

## 📢 Future Improvements (Optional)

- 📈 Export data to log file every minute
- 📢 Trigger alerts for high CPU, memory, or disk usage
- 📜 Support JSON export for integration with other tools
- 🌐 Remote Monitoring over SSH

---

## 🧑‍💻 Author

**Tarun Shori**  
Passionate about DevOps, Linux, and building efficient automation tools.  
Feel free to connect or collaborate! 🚀

---

## 📝 License

This project is licensed under the MIT License - feel free to use it, modify it, and distribute it.

---

# 🔥 If you liked it, don't forget to ⭐ star the repo!



# 🛡️ Server Security Audit and Hardening Script

A complete **Bash script** that performs **security auditing** and applies essential **server hardening** steps.  
Generates a detailed **audit report** automatically after execution.

---

## 📋 Features

- 🔎 User & Group auditing (find users with UID 0, users without passwords)
- 🔒 File & Directory permission checks (world-writable files, `.rhosts` detection)
- ⚙️ Service audit (status of critical services like SSHD, IPTABLES)
- 🌐 Network security checks (open ports, active firewalls, IP configuration)
- 🚀 System update checks (APT/YUM pending updates)
- 🛑 SSH Hardening (disable password authentication)
- 🚫 Disable IPv6
- 🔐 Bootloader (GRUB) security suggestions
- 🔄 Configure automatic security updates
- 📝 Generates a complete timestamped `audit_report.txt`

---

## 📂 File Structure

| File                | Purpose                                |
|---------------------|----------------------------------------|
| `security_audit.sh` | Main security audit and hardening script |
| `README.md`         | Project documentation                  |

---

## 📦 Requirements

- Bash Shell
- Linux (Debian/Ubuntu, RHEL/CentOS, etc.)
- `ss`, `ip`, `curl`, `systemctl`, `apt` or `yum`
- Sudo privileges

---

## 🚀 How to Use

1. **Clone the Repository**:

```bash
git clone <your-repo-url>
cd <project-directory>
```

2. **Make Script Executable**:

```bash
chmod +x security_audit.sh
```

3. **Run the Script as Root**:

```bash
sudo ./security_audit.sh
```

4. **Audit Report** will be generated with a timestamp:

```bash
audit_report_YYYYMMDD_HHMMSS.txt
```

---

## ⚙️ What Happens Inside

- Logs are captured in a dynamically created report file.
- **Important system hardening steps** like SSH PasswordAuthentication disabling are applied automatically.
- IPv6 is disabled via `sysctl`.
- Services are checked and suggestions are provided if necessary.
- Public IP is fetched using `curl`.

---

## ✨ Example Audit Output

```
--- User and Group Audit ---
root:x:0:0:root:/root:/bin/bash
...
Users with UID 0 other than root:
(none)

--- File and Directory Permissions ---
World-writable files:
...

--- Services Audit ---
sshd.service - OpenSSH Daemon running
iptables.service - Running
...

--- Firewall and Network Security ---
Firewall: active (ufw)

Open Ports:
LISTEN 0 128 *:22 *:*
LISTEN 0 100 127.0.0.1:3306
...

--- IP and Network Configurations ---
eth0: 192.168.1.10/24
Public IP: 102.45.123.22

--- Security Updates ---
12 packages can be updated.
...
```

---

## ⚠️ Important Notes

- **Backup `/etc/ssh/sshd_config`** before applying SSH hardening.
- Bootloader (GRUB) security needs manual password setting.
- Always verify after hardening steps to avoid locking yourself out!

---

## 📢 Future Improvements

- Email Audit Report to Admin
- Slack or Telegram Notification on critical findings
- Automatic Remediation for Common Vulnerabilities
- Dockerize the Audit Process

---

## 👨‍💻 Author

**Tarun Shori**  
DevOps & Security Enthusiast | Automation Explorer 🚀

---

## 📝 License

This project is licensed under the MIT License.

---

# ⚡ If you found it helpful, star it 🌟 and fork it 🍴!


