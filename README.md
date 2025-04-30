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

