# HomeRack Mini Rack Build

Based on [geerlingguy/mini-rack#4](https://github.com/geerlingguy/mini-rack/issues/4)

## Rack
- **[DeskPi RackMate TT](https://www.amazon.com/DeskPi-RackMate-Raspberry-Rack-Mount/dp/B0CTKWRMM5)** - 10" mini rack

## Current Hardware Inventory

### Compute Nodes
1. **[Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/) + [NVMe HAT](https://www.raspberrypi.com/products/m2-hat-plus/)** (Web Server)
   - Role: Web server
   - Storage: NVMe SSD
   - Power: USB-C

2. **[Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/) + [NVMe HAT](https://www.raspberrypi.com/products/m2-hat-plus/)** (Home Server)
   - Role: Home server
   - Storage: NVMe SSD
   - Power: USB-C

3. **[FriendlyElec CM3588 Plus NAS](https://www.friendlyelec.com/index.php?route=product/product&product_id=294)**
   - Model: CM3588 NAS Kit
   - RAM: 16GB
   - eMMC: 64GB
   - Storage: 3x 1TB SSD
   - MicroSD: [SanDisk Ultra 32GB Class 10 UHS-I](https://www.amazon.com/SanDisk-Ultra-UHS-I-Memory-Adapter/dp/B00M55C0VU)
   - Power: 12V 4A Universal Adapter

### Networking
- **[T-Mobile 5G Home Office ODU](https://www.t-mobile.com/business/solutions/5g-products/5g-home-office)** (FWA Antenna)
  - Primary internet connection

### Power
- **[Allpowers Volix P300](https://www.allpowers.com/products/allpowers-p300-portable-power-station)**
  - Capacity: 288Wh
  - Output: 300W
  - Type: Powerbank UPS

## Missing/Needed Items

### Network Switch
- [ ] 10" rack-mountable switch (5-8 ports minimum)
- Options: [Mikrotik CSS610-8G-2S+in](https://mikrotik.com/product/css610_8g_2s_in) (~$110) or similar

### Power Distribution
- [ ] [USB-C PD hub/charger](https://www.amazon.com/Charger-GaN-Charging-Station-MacBook/dp/B0C6DX66TN) for Pi 5s (65W per Pi recommended)
- [ ] 10" rack PDU for AC outlets ([Tupavco](https://www.amazon.com/Tupavco-TP1552-Rackmount-Power-Strip/dp/B00FUXYBCU) ~$45)
- [ ] Short USB-C cables (6-12")

### Mounting Hardware
- [ ] Pi mounting bracket ([DeskPi 2U 4x Pi NVMe Mount](https://www.amazon.com/DeskPi-Raspberry-Rackmount-Bracket-Standard/dp/B0CQV99MPM) ~$100 or custom)
- [ ] CM3588 mounting solution (check NAS kit compatibility)
- [ ] Switch mounting brackets/rails ([Mikrotik RMK-2/10](https://mikrotik.com/product/rmk_2_10) for Mikrotik)
- [ ] Cable management clips

### Cables
- [ ] Short Ethernet cables ([Monoprice SlimRun 6"](https://www.amazon.com/Monoprice-SlimRun-Cat6A-Ethernet-Network/dp/B01BGV2T7S) for clean routing)
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