# HomeRack Power Management Guide

Complete guide for safely powering off devices in your HomeRack setup.

## Table of Contents
- [Device Inventory](#device-inventory)
- [Shutdown Commands](#shutdown-commands)
- [Rack-Based Shutdown](#rack-based-shutdown)
- [Emergency Procedures](#emergency-procedures)
- [Best Practices](#best-practices)

## Device Inventory

### Rack: `pi5main`
| Hostname  | Description                    | IP/Address       | Status |
|-----------|--------------------------------|------------------|--------|
| pi5main   | Raspberry Pi 5 - Rails Staging | pi5main.local    | Active |

### Rack: `nas`
| Hostname  | Description                    | IP/Address       | Status |
|-----------|--------------------------------|------------------|--------|
| cm3588    | CM3588 NAS                     | 192.168.1.103    | Inactive* |

*Note: NAS device is currently commented out in inventory and not deployed.

### Rack: `pi5cam`
| Hostname  | Description                    | IP/Address       | Status |
|-----------|--------------------------------|------------------|--------|
| pi5cam    | Raspberry Pi 5 - AI Camera     | pi5cam.local     | Active |

## Shutdown Commands

### Shutdown All Devices
```bash
ansible-playbook playbooks/shutdown.yml
```
This will shut down ALL active devices in the HomeRack, one at a time.

### Shutdown Specific Rack

#### Shutdown pi5main rack:
```bash
ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main
```

#### Shutdown nas rack:
```bash
ansible-playbook playbooks/shutdown.yml -e target_rack=nas
```

#### Shutdown pi5cam rack:
```bash
ansible-playbook playbooks/shutdown.yml -e target_rack=pi5cam
```

### Shutdown Specific Device
```bash
# Shutdown pi5main only
ansible-playbook playbooks/shutdown.yml --limit pi5main

# Shutdown pi5cam only
ansible-playbook playbooks/shutdown.yml --limit pi5cam

# Shutdown all Raspberry Pi nodes
ansible-playbook playbooks/shutdown.yml --limit pis
```

### Advanced Options

#### Custom Shutdown Delay
By default, shutdown occurs after 10 seconds. To customize:
```bash
# Wait 60 seconds before shutdown
ansible-playbook playbooks/shutdown.yml -e shutdown_delay=60

# Immediate shutdown (0 seconds)
ansible-playbook playbooks/shutdown.yml -e shutdown_delay=0
```

#### Force Shutdown (Ignore Logged-in Users)
By default, the playbook will abort if users are logged in. To force shutdown:
```bash
ansible-playbook playbooks/shutdown.yml -e force=true
```

#### Dry Run (Preview Without Shutting Down)
```bash
ansible-playbook playbooks/shutdown.yml --check
```

#### Combine Options
```bash
# Force shutdown pi5main rack with 30 second delay
ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main -e shutdown_delay=30 -e force=true
```

## Rack-Based Shutdown

### One Command to Rule Them All

**Shutdown pi5main and nas racks together:**
```bash
ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main && \
ansible-playbook playbooks/shutdown.yml -e target_rack=nas
```

Or create a convenience script:

```bash
#!/bin/bash
# shutdown-main-racks.sh
# Shutdown pi5main and nas racks

echo "Shutting down pi5main rack..."
ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main

echo "Shutting down nas rack..."
ansible-playbook playbooks/shutdown.yml -e target_rack=nas

echo "All specified racks have been shut down."
```

Make it executable:
```bash
chmod +x shutdown-main-racks.sh
./shutdown-main-racks.sh
```

## Emergency Procedures

### Emergency Shutdown (All Hosts Immediately)
```bash
ansible all -a "shutdown -h now" --become
```
⚠️ **WARNING:** This bypasses safety checks and shuts down immediately!

### Cancel Scheduled Shutdown
If you initiated a shutdown and need to cancel:
```bash
ansible all -a "shutdown -c" --become
```

### Check if Shutdown is Scheduled
```bash
ansible all -a "systemctl status systemd-shutdownd.service" --become
```

### Power Cycle (Reboot Instead of Shutdown)
```bash
ansible-playbook playbooks/reboot.yml
ansible-playbook playbooks/reboot.yml -e force_reboot=true
```

## Best Practices

### 1. Graceful Shutdown Order
When shutting down the entire rack, follow this order:
1. Application servers (pi5main, pi5cam)
2. Storage/NAS devices (nas rack)
3. Network infrastructure (if applicable)
4. UPS (last)

### 2. Before Shutdown Checklist
- [ ] Check for running jobs or deployments
- [ ] Notify users if services will be affected
- [ ] Verify backups are complete
- [ ] Check for logged-in users: `ansible all -a "who" --become`

### 3. After Shutdown
- Wait for all devices to fully power off before disconnecting power
- If using UPS, shut it down last
- Document the shutdown in your maintenance log

### 4. Startup Procedures
To start devices back up:
1. Power on UPS first (if applicable)
2. Power on network infrastructure
3. Power on NAS/storage devices
4. Power on application servers
5. Verify all services: `ansible all -m ping`

### 5. Regular Testing
- Test shutdown procedures monthly
- Verify email notifications work
- Ensure all devices respond to Ansible commands
- Check that services restart properly after shutdown

## Monitoring Shutdown Status

### Check Host Status
```bash
# Quick ping test
ansible all -m ping

# Check uptime
ansible all -a "uptime"

# Detailed system info
ansible-playbook playbooks/info.yml
```

### View System Logs
```bash
# Check shutdown logs on specific host
ansible pi5main -a "journalctl -u shutdown.target -n 50" --become
```

## Troubleshooting

### Host Not Responding to Shutdown Command
```bash
# Try direct SSH
ssh rege@pi5main.local
sudo shutdown -h now

# If SSH fails, physical power button or power cycle may be needed
```

### Shutdown Takes Too Long
- Increase `shutdown_delay` parameter
- Check for stuck processes: `ansible HOST -a "ps aux" --become`
- Force kill hung processes if necessary

### Playbook Fails
```bash
# Run with verbose output
ansible-playbook playbooks/shutdown.yml -vvv

# Check Ansible connectivity
ansible all -m ping

# Verify sudo access
ansible all -a "whoami" --become
```

## Related Commands

### System Status
```bash
# Check if reboot is required
ansible all -a "test -f /var/run/reboot-required && echo 'Reboot required' || echo 'No reboot needed'"

# Check system temperature
ansible pis -a "vcgencmd measure_temp" --become

# Check disk space
ansible all -a "df -h"
```

### Maintenance
```bash
# Run maintenance
ansible-playbook playbooks/maintenance.yml

# Upgrade systems
ansible-playbook playbooks/upgrade.yml

# Get system info
ansible-playbook playbooks/info.yml
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `ansible-playbook playbooks/shutdown.yml` | Shutdown all hosts |
| `ansible-playbook playbooks/shutdown.yml -e target_rack=pi5main` | Shutdown pi5main rack |
| `ansible-playbook playbooks/shutdown.yml -e target_rack=nas` | Shutdown nas rack |
| `ansible-playbook playbooks/shutdown.yml --limit pi5main` | Shutdown specific host |
| `ansible-playbook playbooks/shutdown.yml -e force=true` | Force shutdown |
| `ansible-playbook playbooks/shutdown.yml --check` | Dry run |
| `ansible all -a "shutdown -c" --become` | Cancel shutdown |
| `ansible all -m ping` | Check if hosts are up |

---

**Last Updated:** 2024
**Maintained By:** HomeRack Team