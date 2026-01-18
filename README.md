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

## Power Strategy: USB-C Centralized Power

### USB-C PD Hub Approach
Power everything from a single high-wattage USB-C PD hub connected to UPS.

**Power Requirements:**
- 2x Pi 5: ~30W each = 60W
- CM3588 NAS: 48W (12V 4A via USB-C PD trigger or adapter)
- Network switch: ~15W (check USB-C compatibility)
- 5G Antenna: ~20W (verify USB-C option)
- **Total: ~140-150W**

**Recommended Hub:**
- [Anker 735 (GaNPrime 65W)](https://www.amazon.com/Anker-Charger-GaNPrime-Compact-Foldable/dp/B0B2MH6Y94) x2 = $80
- OR [UGREEN 200W USB-C Charger](https://www.amazon.com/UGREEN-Charger-Desktop-Charging-Station/dp/B0C6DX66TN) 6-port = $100
- OR [Satechi 165W USB-C PD Compact GaN](https://www.amazon.com/Satechi-Charger-Desktop-MacBook-Samsung/dp/B09FT7MJC3) 4-port = $120

**Benefits:**
- Single AC cable from UPS to hub
- Cleaner than AC PDU + multiple adapters
- More efficient (GaN technology)
- Compact mounting behind rack
- Easy cable management

**Considerations:**
- Verify CM3588 supports USB-C PD 12V trigger (or use USB-C to barrel adapter)
- Check if switch has USB-C option (or use small AC/DC adapter)
- May need USB-C to barrel jack cables for some devices

## Missing/Needed Items

### Network & Connectivity

**Selected: MikroTik hAP ac²** (~$60)
- 5-port Gigabit switch (enough for 2 Pis + NAS + WAN + spare)
- Dual-band WiFi: 2.4GHz (300Mbps) + 5GHz (867Mbps)
- **WiFi Range:** ~30-50ft indoors (typical for internal antennas)
  - Good for apartment/small home
  - Limited range - router inside metal rack may reduce signal
  - Consider external placement if WiFi coverage needed
- PoE output: 24V passive PoE on port 5 (max 2A / 48W)

**⚠️ T-Mobile 5G Antenna Compatibility Issue:**
- Your antenna: **FWA-ED309B** (Vistron NeWeb)
- **Power requirement:** Likely 802.3at PoE+ (25.5W) or proprietary
- **MikroTik hAP ac²:** Only supports 24V passive PoE (incompatible with 802.3af/at)

**Solutions:**
1. **Use included T-Mobile power adapter** (recommended)
   - Keep antenna on separate power
   - No PoE needed
2. **Add 802.3at PoE injector** (~$25)
   - [TP-Link TL-PoE160S](https://www.amazon.com/TP-Link-Injector-Gigabit-Adapter-TL-PoE160S/dp/B003CFATQK) (802.3at, 30W)
   - Between hAP ac² and antenna
3. **Upgrade router** to one with 802.3af/at PoE
   - More expensive, not recommended

**Decision: Use T-Mobile's included power adapter for antenna**
- Simpler and reliable
- No compatibility issues
- Antenna stays on UPS via USB-C hub or direct AC

### Power Distribution
- [ ] High-wattage USB-C PD hub (150W+ total, 4-6 ports)
  - Option 1: [UGREEN 200W 6-port](https://www.amazon.com/UGREEN-Charger-Desktop-Charging-Station/dp/B0C6DX66TN) ~$100
  - Option 2: [Satechi 165W 4-port GaN](https://www.amazon.com/Satechi-Charger-Desktop-MacBook-Samsung/dp/B09FT7MJC3) ~$120
- [ ] Short USB-C cables (6-12")
- [ ] USB-C to barrel jack adapters (if needed for NAS/switch)

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

### Power Budget (USB-C Centralized)
- Pi 5 (each): ~27W actual, 30W allocated
- CM3588 NAS: 48W (12V 4A via USB-C PD)
- Network switch: ~15W (USB-C or small adapter)
- 5G Antenna: ~20W (verify USB-C compatibility)
- **Total: ~140-150W from USB hub**
- UPS runtime: ~1.5-2hrs at full load (288Wh / 150W)
- **Hub requirement: 150W+ multi-port USB-C PD**

### Network Topology
**Devices to connect:**
1. 2x Pi 5
2. CM3588 NAS
3. 5G Antenna (via PoE from router)
4. Router WiFi for wireless devices

**Total wired ports needed: 3** (2 Pis + NAS)

**Recommended Setup:**
- MikroTik hAP ac² as main router
- Built-in 5-port switch (enough for 2 Pis + NAS + WAN + 1 spare)
- PoE output port for 5G antenna
- WiFi AP included
- Compact, can mount behind rack

**WiFi Coverage Considerations:**
- hAP ac² inside metal rack will reduce WiFi range
- Options if WiFi coverage insufficient:
  1. Mount router outside rack (on desk/wall)
  2. Add separate WiFi AP later
  3. Use mesh system for whole-home coverage

## Mounting Strategy

### Option A: Minimal Stack (Recommended)
1. Bottom/Front: Pi nodes + CM3588 NAS (2U custom shelf)
2. Bottom/Rear: WiFi router (behind rack, no U space)
3. External: 5G antenna (desk/wall mount), UPS (under rack)
4. **Total: 2U only**

### Option B: Premium Rackmount
1. Bottom: MikroTik RB5009 router (1U rackmount)
2. Top: Pi nodes + CM3588 NAS (2U bracket/shelf)
3. External: 5G antenna, UPS
4. **Total: 3U**

## Price Estimate

### Owned
- Rack: ~$110
- Pi 5 (x2): ~$160
- CM3588 NAS kit: ~$300-400
- 5G Antenna: (varies)
- UPS: ~$200

### To Buy
- WiFi router with PoE: $60-200 (or router + PoE injector ~$75)
- Mounting hardware: $100-150
- USB-C PD hub (150W+): $100-120
- Cables + adapters: $40-60
- **Additional spend: ~$300-530**

**Total project: ~$1,070-1,530**

## Next Steps
1. ✅ Router decision: MikroTik hAP ac² confirmed
2. ✅ Antenna power: Use T-Mobile's included adapter (not PoE)
3. Verify CM3588 NAS supports USB-C PD 12V or get USB-C to barrel adapter
4. Test hAP ac² WiFi range from rack location (may need external placement)
5. Measure CM3588 NAS kit dimensions for mounting
6. Choose USB-C PD hub (150W+ with 4-6 ports)
7. Order mounting brackets/hardware
8. Plan cable management strategy

## Notes
- Verify Pi 5 NVMe HAT compatibility with mounting bracket
- Check if CM3588 NAS kit includes rack ears
- Consider active cooling if stacking tightly
- Test UPS runtime under actual load before production use
- **T-Mobile antenna:** Model FWA-ED309B by Vistron NeWeb
- hAP ac² WiFi may have limited range inside metal rack - test before permanent mounting