# HomeRack Ansible Configuration

Ansible playbooks and roles for configuring Raspberry Pi nodes and CM3588 NAS in the HomeRack setup.

## Quick Reference Commands

### Essential Commands (Copy & Paste Ready)

```bash
cd ~/code/homerack/ansible

# Test connectivity
ansible all -m ping

# Full setup (new Pi)
ansible-playbook site.yml

# Quick system upgrade
ansible-playbook playbooks/upgrade.yml

# System info
ansible-playbook playbooks/info.yml

# Reboot (if needed)
ansible-playbook playbooks/reboot.yml

# Deploy dotfiles only
ansible-playbook site.yml --tags dotfiles
```

---

## Currently Configured Hosts

| Host | Address | User | Description |
|------|---------|------|-------------|
| `pi5cam` | `pi5cam.local` | `rege` | Raspberry Pi 5 - AI Camera |

---

## Command Reference

### 🔌 Connectivity & Testing

```bash
# Ping all hosts
ansible all -m ping

# Ping specific host
ansible pi5cam -m ping

# Ping group
ansible pis -m ping

# Verbose ping (troubleshooting)
ansible all -m ping -vvv
```

### 🚀 Full Setup

```bash
# Run full setup on all hosts
ansible-playbook site.yml

# Run on specific host
ansible-playbook site.yml --limit pi5cam

# Run on Pi group only
ansible-playbook site.yml --limit pis

# Dry run (check what would change)
ansible-playbook site.yml --check --diff

# Verbose output
ansible-playbook site.yml -v
ansible-playbook site.yml -vv   # more verbose
```

### 📦 Package Management

```bash
# Install packages only
ansible-playbook site.yml --tags packages

# Upgrade all packages
ansible-playbook playbooks/upgrade.yml

# Upgrade with auto-reboot if needed
ansible-playbook playbooks/upgrade.yml -e reboot_after_upgrade=true

# Quick install a single package
ansible all -m apt -a "name=htop state=present" --become

# Remove a package
ansible all -m apt -a "name=nano state=absent" --become
```

### 📊 System Information

```bash
# Full system info
ansible-playbook playbooks/info.yml

# Quick uptime check
ansible all -a "uptime"

# Disk usage
ansible all -a "df -h"

# Memory usage
ansible all -a "free -h"

# CPU temperature (Raspberry Pi)
ansible pis -m shell -a "vcgencmd measure_temp" --become

# Running processes
ansible all -m shell -a "ps aux --sort=-%mem | head -10"

# Check for pending updates
ansible all -m shell -a "apt list --upgradable" --become
```

### 🔄 Reboot & Power

```bash
# Safe reboot (only if required)
ansible-playbook playbooks/reboot.yml

# Force reboot
ansible-playbook playbooks/reboot.yml -e force_reboot=true

# Reboot specific host
ansible-playbook playbooks/reboot.yml --limit pi5cam

# Shutdown
ansible all -a "shutdown -h now" --become

# Quick reboot via ad-hoc
ansible all -a "reboot" --become
```

### 🔧 Run Specific Tasks (Tags)

```bash
# Available tags:
#   common, packages, upgrade, hostname, timezone,
#   locale, ssh, security, swap, watchdog, reboot,
#   cleanup, dotfiles

# Examples:
ansible-playbook site.yml --tags upgrade
ansible-playbook site.yml --tags packages
ansible-playbook site.yml --tags dotfiles
ansible-playbook site.yml --tags "packages,ssh"
ansible-playbook site.yml --skip-tags reboot
```

### 🖥️ Ad-hoc Commands

```bash
# Run any command
ansible all -a "whoami"
ansible all -a "cat /etc/os-release"
ansible all -a "uname -a"

# With sudo
ansible all -a "apt update" --become

# Using shell module (for pipes, redirects)
ansible all -m shell -a "cat /proc/cpuinfo | grep 'model name'" --become

# Copy file to hosts
ansible all -m copy -a "src=./myfile dest=/tmp/myfile"

# Fetch file from hosts
ansible all -m fetch -a "src=/etc/hostname dest=./fetched/"

# Restart a service
ansible all -m service -a "name=ssh state=restarted" --become
```

### 🎯 Target Selection

```bash
# All hosts
ansible-playbook site.yml

# Specific host
ansible-playbook site.yml --limit pi5cam

# Multiple hosts
ansible-playbook site.yml --limit "pi5cam,pi5-1"

# Group
ansible-playbook site.yml --limit pis

# Exclude hosts
ansible-playbook site.yml --limit 'all:!nas'

# Pattern matching
ansible-playbook site.yml --limit 'pi*'
```

---

## Project Structure

```
ansible/
├── ansible.cfg              # Ansible configuration
├── inventory.yml            # Host inventory (with command reference)
├── site.yml                 # Main playbook
├── requirements.yml         # Ansible Galaxy dependencies
├── .gitignore               # Git ignore file
├── README.md                # This file
├── group_vars/
│   ├── all.yml              # Variables for all hosts
│   └── pis.yml              # Raspberry Pi specific vars
├── host_vars/               # Per-host variables
├── playbooks/
│   ├── upgrade.yml          # Quick system upgrade
│   ├── info.yml             # Gather system info
│   └── reboot.yml           # Safe reboot playbook
└── roles/
    ├── common/              # Basic setup role
    │   ├── tasks/main.yml
    │   └── handlers/main.yml
    ├── packages/            # Package management role
    │   ├── tasks/main.yml
    │   └── vars/main.yml
    └── dotfiles/            # User configuration files
        ├── tasks/main.yml
        └── files/
            ├── vimrc        # Vim configuration
            └── tmux.conf    # Tmux configuration
```

---

## What Gets Deployed

### Installed Packages

| Category | Packages |
|----------|----------|
| **Monitoring** | `btop`, `htop`, `iotop`, `ncdu`, `fastfetch` |
| **Network** | `net-tools`, `dnsutils`, `mtr-tiny`, `iperf3`, `nmap` |
| **Utilities** | `vim`, `git`, `curl`, `wget`, `tmux`, `jq`, `rsync`, `tree`, `unzip` |

### Dotfiles

- **`.vimrc`** - Standalone vim config with:
  - Space as leader key
  - Line numbers, syntax highlighting
  - 2-space indentation
  - Smart search (case-insensitive unless uppercase)
  - Netrw file browser configured
  - Custom key mappings for buffers, windows
  - Persistent undo

- **`.tmux.conf`** - Tmux config with:
  - Ctrl-a as prefix (instead of Ctrl-b)
  - Mouse support
  - Vi-style copy mode
  - Split with `|` and `-`
  - Vim-style pane navigation (hjkl)
  - Nice status bar

- **`.bashrc`** additions - Shell aliases:
  - `ll`, `la`, `l` - ls variants
  - `gs`, `gd`, `gl`, `gp` - git shortcuts
  - `update` - apt update && upgrade
  - `temp` - show Pi temperature

---

## Adding New Hosts

1. Edit `inventory.yml`:

```yaml
pis:
  hosts:
    pi5cam:
      ansible_host: pi5cam.local
      ansible_user: rege
    
    # Add new host:
    pi5-new:
      ansible_host: 192.168.1.105
      ansible_user: pi
```

2. Copy SSH key to new host:
```bash
ssh-copy-id pi@192.168.1.105
```

3. Test and provision:
```bash
ansible pi5-new -m ping
ansible-playbook site.yml --limit pi5-new
```

---

## Customization

### Adding Packages

Edit `group_vars/all.yml`:

```yaml
common_packages:
  - btop
  - htop
  - your-new-package
```

### Host-specific Variables

Create `host_vars/pi5cam.yml`:

```yaml
extra_packages:
  - python3-picamera2
  - libcamera-apps
```

### Modify Vim Config

Edit `roles/dotfiles/files/vimrc` and redeploy:

```bash
ansible-playbook site.yml --tags dotfiles
```

### Change Timezone

Edit `group_vars/all.yml`:

```yaml
timezone: "America/New_York"
```

---

## Troubleshooting

### SSH Issues

```bash
# Test SSH manually
ssh rege@pi5cam.local

# Verbose Ansible connection
ansible all -m ping -vvv

# Clear SSH known hosts
ssh-keygen -R pi5cam.local
```

### Sudo Issues

```bash
# If sudo requires password
ansible-playbook site.yml --ask-become-pass
```

### Check Ansible Version

```bash
ansible --version
```

### View Cached Facts

```bash
ls -la .ansible_cache/
cat .ansible_cache/pi5cam
```

---

## First-time Setup (New Control Machine)

```bash
# 1. Install Ansible
brew install ansible          # macOS
sudo apt install ansible      # Ubuntu/Debian

# 2. Install required collections
cd ~/code/homerack/ansible
ansible-galaxy install -r requirements.yml

# 3. Setup SSH key
ssh-keygen -t ed25519 -C "homerack"
ssh-copy-id rege@pi5cam.local

# 4. Test and run
ansible all -m ping
ansible-playbook site.yml
```
