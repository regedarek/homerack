# HomeRack Mini Rack Build

Based on [geerlingguy/mini-rack#4](https://github.com/geerlingguy/mini-rack/issues/4)

## Rack
- **DeskPi RackMate TT** - 10" mini rack

## Current Hardware Inventory

### Compute Nodes
1. **Pi 5 + NVMe HAT** (Web Server)
   - Role: Web server
   - Storage: NVMe SSD
   - Power: USB-C

2. **Pi 5 + NVMe HAT** (Home Server)
   - Role: Home server
   - Storage: NVMe SSD
   - Power: USB-C

3. **FriendlyElec CM3588 Plus NAS**
   - Model: CM3588 NAS Kit
   - RAM: 16GB
   - eMMC: 64GB
   - Storage: 3x 1TB SSD
   - MicroSD: SanDisk Ultra 32GB Class 10 UHS-I
   - Power: 12V 4A Universal Adapter

### Networking
- **T-Mobile 5G Home Office ODU** (FWA Antenna)
  - Primary internet connection

### Power
- **Allpowers Volix P300**
  - Capacity: 288Wh
  - Output: 300W
  - Type: Powerbank UPS

## Missing/Needed Items

### Network Switch
- [ ] 10" rack-mountable switch (5-8 ports minimum)
- Options: Mikrotik CSS610-8G-2S+in (~$110) or similar

### Power Distribution
- [ ] USB-C PD hub/charger for Pi 5s (65W per Pi recommended)
- [ ] 10" rack PDU for AC outlets (Tupavco ~$45)
- [ ] Short USB-C cables (6-12")

### Mounting Hardware
- [ ] Pi mounting bracket (DeskPi 2U 4x Pi NVMe Mount ~$100 or custom)
- [ ] CM3588 mounting solution (check NAS kit compatibility)
- [ ] Switch mounting brackets/rails
- [ ] Cable management clips

### Cables
- [ ] Short Ethernet cables (6-12" for clean routing)
- [ ] Power cables for UPS distribution

## Sizing Considerations

### Rack Space (U)
- Pi mounting: 2U (if using DeskPi bracket)
- CM3588 NAS: 1-2U (verify NAS kit dimensions)
- Network switch: 1U
- 5G Antenna: External or top mount
- UPS: External or bottom shelf
- **Total: ~4-5U minimum**

### Power Budget
- Pi 5 (each): ~25W peak (use 65W PD charger for headroom)
- CM3588 NAS: ~48W (12V 4A)
- Network switch: ~10-15W
- 5G Antenna: ~20W
- **Total: ~150-180W continuous**
- UPS runtime: ~1.5-2hrs at full load (288Wh)

### Network
- All devices: 1Gbps minimum
- CM3588 NAS: 2.5Gbps capable (verify switch support if needed)
- Uplink: 5G antenna speed dependent

## Mounting Strategy

### Option A: Compact Stack
1. Bottom: Network switch (1U)
2. Middle: Pi nodes (2U bracket)
3. Top: CM3588 NAS (custom mount)
4. External: 5G antenna (side/top), UPS (under rack)

### Option B: Distributed
1. Pi nodes + CM3588 on single custom shelf (2U)
2. Network switch (1U)
3. PDU on rear
4. 5G antenna external mount

## Price Estimate

### Owned
- Rack: ~$110
- Pi 5 (x2): ~$160
- CM3588 NAS kit: ~$300-400
- 5G Antenna: (varies)
- UPS: ~$200

### To Buy
- Network switch: $110
- Mounting hardware: $100-150
- USB-C PD charger: $25-50
- Cables + PDU: $70-100
- **Additional spend: ~$305-410**

**Total project: ~$1,075-1,380**

## Next Steps
1. Measure CM3588 NAS kit dimensions for mounting
2. Decide on network switch (1Gbps vs 2.5Gbps)
3. Choose USB-C power delivery solution
4. Order mounting brackets/hardware
5. Plan cable management strategy

## Notes
- Verify Pi 5 NVMe HAT compatibility with mounting bracket
- Check if CM3588 NAS kit includes rack ears
- Consider active cooling if stacking tightly
- Test UPS runtime under actual load before production use