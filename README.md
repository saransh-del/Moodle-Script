# 🚀 Moodle One-Click Installer (Ubuntu)

This project provides a **one-click Bash script** to install and configure Moodle LMS on any **Ubuntu** system (Docker or Non-Docker).

---

## 📦 What This Script Does

- Installs Apache, MariaDB, PHP, and required extensions
- Downloads Moodle (version `MOODLE_403_STABLE`)
- Sets up Moodle database and user
- Fixes all PHP limits (like `max_input_vars = 5000`)
- Creates and configures `moodledata` directory
- Handles folder permissions
- Cleans old cache/temp/session data (for reused volumes)
- Ensures Moodle runs without errors on browser setup page

---

## ⚙️ Prerequisites

- Ubuntu 20.04 / 22.04 / 24.04
- Root/sudo access
- Internet connection

✅ Works on:
- Ubuntu Docker container  
- Physical server  
- Virtual machine  
- WSL (Windows Subsystem for Linux)  

---

## 🛠️ How to Use

1. **Clone or download this repo** (or just get the `setup.sh` file)

2. **Give execute permission:**
   ```bash
   chmod +x setup.sh
Run the script:

bash
Copy
Edit
./setup.sh
Wait for setup to complete...

🌐 After Setup
Once script finishes:

Open your browser:

arduino
Copy
Edit
http://<your-ip>:8080/moodle
Replace <your-ip> with localhost, container IP, or server IP

Complete the visual site setup (admin account, password, etc)
