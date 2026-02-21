# Tailscale Network Setup

## Overview

This homelab uses [Tailscale](https://tailscale.com/) to create a secure mesh VPN across all devices, enabling remote access and secure communication between devices regardless of their physical location.

## Network Topology

```
Tailscale Mesh Network (100.x.x.x/10)
    ├── mac-mini-darek (Control Node, macOS)
    ├── macbook-pro-apple (Development, macOS)
    ├── iphone-12 (Mobile Access, iOS)
    ├── nas-photoprism (CM3588 NAS, Ubuntu/Debian)
    ├── pi5cam (Raspberry Pi 5, AI Camera)
    └── pi5main (Raspberry Pi 5, Rails Staging)
```

## Device List

| Device | Tailscale Name | Local IP | User | Role |
|--------|----------------|----------|------|------|
| Mac Mini | `mac-mini-darek` | - | `rege` | Control/Admin Node |
| MacBook Pro | `macbook-pro-apple` | - | `rege` | Development |
| iPhone 12 | `iphone-12` | - | - | Mobile Access |
| CM3588 NAS | `nas-photoprism` | 192.168.0.10 | `rege` | Storage, PhotoPrism |
| Raspberry Pi 5 #1 | `pi5cam` | .local | `rege` | AI Camera Server |
| Raspberry Pi 5 #2 | `pi5main` | .local | `rege` | Rails Staging Server |

## Quick Start

### SSH Access

#### Using Tailscale Hostnames Directly
```bash
ssh rege@nas-photoprism
ssh rege@pi5cam
ssh rege@pi5main
ssh rege@macbook-pro-apple
```

#### Using SSH Config Aliases
```bash
# First, include the SSH config in ~/.ssh/config:
echo "Include ~/code/homerack/ssh_config" >> ~/.ssh/config

# Create socket directory for connection sharing
mkdir -p ~/.ssh/sockets

# Then use short aliases:
ssh nas
ssh pi5cam
ssh pi5main
ssh macbook
```

### Ansible with Tailscale

The Ansible inventory is configured to use Tailscale hostnames by default:

```bash
# Test connectivity over Tailscale
ansible all -m ping

# Run playbooks
ansible-playbook site.yml
ansible-playbook playbooks/upgrade.yml

# Ad-hoc commands
ansible all -a "uptime"
ansible nas -a "df -h"
```

## Installation

### Installing Tailscale on New Devices

#### Debian/Ubuntu (Raspberry Pi, CM3588 NAS)
```bash
# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# Start and authenticate
sudo tailscale up

# Enable IP forwarding (optional, for subnet routing)
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Set hostname (if needed)
sudo hostnamectl set-hostname pi5cam
# or
sudo hostnamectl set-hostname pi5main
# or
sudo hostnamectl set-hostname nas-photoprism
```

#### macOS
```bash
# Install via Homebrew
brew install tailscale

# Or download from https://tailscale.com/download/mac

# Start Tailscale
sudo tailscale up
```

#### iOS/Android
Install the Tailscale app from App Store or Google Play Store.

## Features & Configuration

### MagicDNS

Tailscale provides automatic DNS resolution for all devices:
- Each device is reachable via its hostname (e.g., `nas-photoprism`)
- No need to remember IP addresses
- Works from anywhere with internet connection

### SSH Access

Tailscale provides built-in SSH functionality:

```bash
# Check SSH status
tailscale status

# SSH via Tailscale (alternative to direct SSH)
tailscale ssh rege@nas-photoprism
```

### Exit Nodes (Optional)

Use your homelab as an exit node for secure internet access:

```bash
# On the exit node (e.g., NAS):
sudo tailscale up --advertise-exit-node

# On client devices:
tailscale up --exit-node=nas-photoprism
```

### Subnet Routes (Optional)

Expose local networks (192.168.x.x) via Tailscale:

```bash
# On the subnet router (e.g., NAS):
sudo tailscale up --advertise-routes=192.168.0.0/24

# Approve in Tailscale admin console:
# https://login.tailscale.com/admin/machines
```

## Security Best Practices

### Key Management
- ✅ Use strong authentication (SSO recommended)
- ✅ Enable MFA on Tailscale account
- ✅ Regularly review device access in admin console

### Access Control Lists (ACLs)
Consider implementing Tailscale ACLs for fine-grained access control:
https://login.tailscale.com/admin/acls

Example ACL policy:
```json
{
  "acls": [
    {
      "action": "accept",
      "src": ["autogroup:member"],
      "dst": ["*:22", "*:80", "*:443"]
    },
    {
      "action": "accept",
      "src": ["nas-photoprism"],
      "dst": ["*:*"]
    }
  ]
}
```

### SSH Key Management
- ✅ Use SSH keys instead of passwords
- ✅ Store keys securely
- ✅ Use `ForwardAgent yes` only when necessary

## Troubleshooting

### Check Tailscale Status
```bash
tailscale status
tailscale netcheck
tailscale ping nas-photoprism
```

### Restart Tailscale Service
```bash
# Linux
sudo systemctl restart tailscaled
sudo tailscale up

# macOS
sudo tailscale down
sudo tailscale up
```

### Connection Issues

1. **Cannot reach device by hostname:**
   ```bash
   # Check if MagicDNS is enabled
   tailscale status
   
   # Try using Tailscale IP directly
   ssh rege@100.x.x.x
   ```

2. **SSH connection refused:**
   ```bash
   # Verify SSH is running on target
   ansible pi5cam -m service -a "name=ssh state=started" --become
   
   # Check firewall
   ansible pi5cam -a "sudo ufw status" --become
   ```

3. **Tailscale not starting on boot:**
   ```bash
   # Enable Tailscale service
   sudo systemctl enable tailscaled
   sudo systemctl start tailscaled
   ```

### Force Reconnection
```bash
sudo tailscale down
sudo tailscale up --force-reauth
```

## Monitoring

### Check Device Status
```bash
# View all devices
tailscale status

# Check specific device
tailscale ping pi5cam
tailscale ping nas-photoprism
```

### View Logs
```bash
# Linux
sudo journalctl -u tailscaled -f

# macOS
log stream --predicate 'process == "Tailscale"'
```

## Administration

### Tailscale Admin Console
Access the admin console at: https://login.tailscale.com/admin/machines

From here you can:
- View all connected devices
- Approve subnet routes and exit nodes
- Configure ACLs
- Manage device keys and expiration
- View connection logs

### Device Management

#### Rename a Device
```bash
# On the device or in admin console
tailscale up --hostname=new-hostname
```

#### Remove a Device
```bash
# From admin console: https://login.tailscale.com/admin/machines
# Or from CLI:
tailscale logout
```

#### Disable Key Expiry
```bash
# On the device:
sudo tailscale up --authkey=<key> --advertise-tags=tag:persistent
```

Or in the admin console: Machines → Select device → Disable key expiry

## Integration with Homelab

### Ansible Inventory
The inventory (`ansible/inventory.yml`) uses Tailscale hostnames:
- `pi5cam` → Tailscale hostname
- `pi5main` → Tailscale hostname  
- `nas-photoprism` → Tailscale hostname

### SSH Config
The SSH config (`ssh_config`) provides short aliases:
- `ssh nas` → `ssh rege@nas-photoprism`
- `ssh pi5cam` → `ssh rege@pi5cam`
- `ssh pi5main` → `ssh rege@pi5main`

### Benefits
- ✅ Access from anywhere with internet
- ✅ No port forwarding required
- ✅ Encrypted end-to-end
- ✅ No need for VPN server setup
- ✅ Works across different networks
- ✅ Automatic failover between local and remote

## Resources

- [Tailscale Documentation](https://tailscale.com/kb/)
- [Tailscale Admin Console](https://login.tailscale.com/admin)
- [Tailscale GitHub](https://github.com/tailscale/tailscale)
- [Tailscale Blog](https://tailscale.com/blog/)

## Common Tasks

### Connect to NAS
```bash
# SSH
ssh nas

# SCP files
scp file.txt nas:/home/rege/

# SFTP
sftp nas

# Rsync
rsync -avz ~/photos/ nas:/mnt/storage/photos/
```

### Deploy with Ansible
```bash
# Update all devices
ansible-playbook playbooks/upgrade.yml

# Update only NAS
ansible-playbook playbooks/upgrade.yml --limit nas

# Check connectivity
ansible all -m ping
```

### Access Web Services
With Tailscale MagicDNS, access web services directly:
- PhotoPrism: `http://nas-photoprism:2342`
- Rails Staging: `http://pi5main:3000`
- Camera Stream: `http://pi5cam:8080`

(Adjust ports based on your actual service configurations)