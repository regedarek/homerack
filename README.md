# HomeRack

A compact mini rack setup for home lab and homeserver applications.

## Overview

This project documents my custom-built mini rack designed for a home lab environment. The setup provides a professional-grade solution in a compact form factor, perfect for home offices, apartments, or small spaces where a full-size server rack isn't practical.

## Build Guide

### Planning

Before starting the build, consider:
- **Available space**: Measure the area where the rack will be placed
- **Power requirements**: Calculate total power consumption of all equipment
- **Cooling needs**: Plan for adequate ventilation
- **Cable management**: Design cable routing strategy
- **Future expansion**: Leave room for additional equipment

### Materials Needed

#### Rack Components
- Mini rack enclosure (6U-12U recommended for home use)
- Mounting rails and cage nuts
- Shelf for non-rack-mountable equipment
- Cable management panel
- Power distribution unit (PDU)

#### Tools Required
- Screwdriver set (Phillips and flathead)
- Cage nut tool (optional but recommended)
- Cable ties and velcro straps
- Label maker for cable identification
- Measuring tape

### Assembly Steps

1. **Prepare the Rack**
   - Unpack and inspect all components
   - Assemble the rack frame according to manufacturer instructions
   - Install mounting rails on both sides

2. **Install Power Distribution**
   - Mount the PDU at the top or bottom of the rack
   - Ensure easy access to power switches and outlets
   - Connect to main power source (consider UPS placement)

3. **Mount Equipment**
   - Install heaviest equipment at the bottom for stability
   - Use proper rack screws and cage nuts
   - Leave 1U spacing between equipment for ventilation where possible

4. **Cable Management**
   - Route power cables separately from network cables
   - Use cable management panels or arms
   - Label all cables at both ends
   - Leave some slack for equipment removal/maintenance

5. **Final Setup**
   - Double-check all connections
   - Test power sequencing
   - Verify cooling and airflow
   - Document the final configuration

## Specifications

### Physical Dimensions
- **Rack Size**: 9U mini rack
- **Width**: 19" (482.6mm) standard rack width
- **Depth**: 450mm (adjustable rails)
- **Height**: ~500mm
- **Weight Capacity**: Up to 50kg

### Equipment List

#### Network Equipment
- **Router/Firewall**: 1U rackmount unit
  - Processing: Quad-core CPU
  - Memory: 8GB RAM
  - Ports: Multiple gigabit ethernet ports
  - Power: 25W

- **Network Switch**: 1U managed switch
  - Ports: 24-port gigabit ethernet
  - Features: VLAN, QoS, LACP support
  - Power: 30W

#### Compute/Storage
- **Main Server**: 2U rackmount server
  - CPU: Modern multi-core processor
  - RAM: 32GB ECC (expandable to 64GB)
  - Storage: 4x SSD/HDD bays
  - Network: Dual gigabit NICs
  - Power: 150W (typical), 300W (max)

- **NAS/Storage**: 2U storage server
  - Bays: 4-8 hot-swap drive bays
  - RAID: Hardware RAID controller
  - Capacity: Expandable up to 32TB+
  - Power: 100W

#### Power Management
- **UPS**: 1U or 2U rack-mount UPS
  - Capacity: 1000VA / 600W
  - Runtime: 15-30 minutes at full load
  - Features: Auto-shutdown, surge protection

- **PDU**: Rack-mount power distribution
  - Outlets: 8-12 outlets
  - Input: Single phase 230V or 120V
  - Features: Individual outlet switches, surge protection

### Power Consumption
- **Total Maximum Load**: ~600W
- **Typical Operation**: ~300W
- **Idle**: ~150W

### Cooling
- **Ambient Temperature**: Maintain below 25°C (77°F)
- **Equipment Fans**: Built-in fans in each device
- **Rack Ventilation**: Open sides for passive airflow
- **Optional**: 1U rack fan unit for forced ventilation

### Network Configuration
- **Internal Network**: 1Gbps copper ethernet
- **WAN Connection**: Gigabit fiber/cable connection
- **VLANs**: Segregated networks (management, guest, IoT, production)
- **Wireless**: Separate access points (not rack-mounted)

## Use Cases

This mini rack serves multiple purposes:
- **Home Lab**: Testing and development environment
- **Media Server**: Plex/Jellyfin for streaming
- **Network Attached Storage**: Centralized file storage
- **Virtualization**: Running multiple VMs for various services
- **Home Automation**: IoT hub and automation server
- **Network Security**: Firewall, VPN, and network monitoring

## Maintenance

### Regular Tasks
- **Weekly**: Check system status and logs
- **Monthly**: Dust filters and clean ventilation
- **Quarterly**: Verify backup systems
- **Annually**: Check UPS battery health, update firmware

### Monitoring
- Temperature monitoring via SNMP/IPMI
- Power consumption tracking
- Network bandwidth monitoring
- Storage capacity alerts
- UPS status monitoring

## Cost Estimate

Budget breakdown for a typical mini rack setup:
- **Rack Enclosure**: $150-300
- **Network Equipment**: $200-500
- **Main Server**: $500-1500
- **Storage/NAS**: $400-1000
- **UPS**: $200-400
- **Accessories** (cables, PDU, shelves): $100-200
- **Total**: $1,550-3,900 (depending on specifications)

## Future Expansion

Planned upgrades:
- Additional storage capacity
- Network upgrade to 10GbE
- GPU for compute tasks
- Enhanced monitoring system

## Safety Considerations

- Ensure proper grounding of all equipment
- Use surge protection for all devices
- Maintain adequate ventilation
- Don't exceed rack weight capacity
- Keep rack away from water sources
- Use appropriate gauge power cables
- Consider fire suppression in equipment room

## Resources

### Documentation
- Equipment manuals stored in `/docs` folder
- Network diagrams available in repository
- Configuration backups maintained

### Useful Links
- [Server Fault - Home Lab Questions](https://serverfault.com)
- [/r/homelab](https://reddit.com/r/homelab) - Community support
- [ServeTheHome](https://servethehome.com) - Hardware reviews

## License

This documentation is provided as-is for informational purposes. Feel free to use and adapt for your own home rack projects.

## Contributing

Suggestions and improvements are welcome! Feel free to open an issue or submit a pull request.

---

*Last updated: January 6, 2026*
