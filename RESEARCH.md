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
- **[ASUS RT-AC1200G+](https://www.asus.com/networking/rt-ac1200g-plus/)** Wireless-AC1200 Dual-band Gigabit Router
  - Model: RT-AC1200G+
  - LAN: 4x Gigabit ports
  - WAN: 1x Gigabit port
  - WiFi: AC1200 (2.4GHz 300Mbps + 5GHz 867Mbps)
  - Power: 12V 2A (24W)

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

**⚠️ IMPORTANT: T-Mobile Antenna is PoE-Only Powered**
- Your antenna: **FWA-ED309B** (Vistron NeWeb) - **Ethernet connector ONLY**
- **Power:** 802.3at PoE+ (standard, ~25.5W) via Ethernet
- Currently using T-Mobile's PoE injector/router (want to replace)

**Port Requirements:**
- 5G antenna (PoE, WAN/internet source)
- 2x Raspberry Pi 5
- 1x CM3588 NAS
- **Total: 1 PoE WAN + 3 LAN ports minimum**

**Router Options:**

**Option A: UniFi Dream Router 7 (UDR7)** (~$279) ✅ RECOMMENDED
- [UniFi Dream Router 7](https://store.ui.com/us/en/products/udr7) ~$279
  - **4x 2.5GbE ports:** Multi-gig for all devices
  - **1x 802.3af PoE port (15.4W)** - powers your antenna natively!
  - **WiFi 7** integrated (better range/speed than WiFi 5/6)
  - Coverage: ~1,750 sq ft
  - 10G SFP+ WAN port (future-proof)
  - **No separate PoE injector needed!**
  - UniFi management (cloud or local)

**Option B: MikroTik hAP ac² + PoE Injector** (~$85 total)
- Router: [MikroTik hAP ac²](https://mikrotik.com/product/hap_ac2) ~$60
  - **5-port Gigabit:** 1 WAN + 4 LAN (plenty for your needs)
  - Dual-band WiFi: 2.4GHz (300Mbps) + 5GHz (867Mbps)
  - **WiFi Range:** ~30-50ft indoors (mount outside rack)
  - **Issue:** Only 24V passive PoE (incompatible with antenna)
- **Required:** [TP-Link TL-PoE160S](https://www.amazon.com/TP-Link-Injector-Gigabit-Adapter-TL-PoE160S/dp/B003CFATQK) 802.3at injector ~$25
  - Place between hAP ac² WAN port and antenna
  - Small, can mount behind rack

**Option C: Keep T-Mobile PoE Injector + Basic Router** (~$60)
- Use existing T-Mobile PoE adapter
- Any WiFi router with 4+ LAN ports
- [TP-Link AX3000](https://www.amazon.com/TP-Link-WiFi-6-Router/dp/B09G5W8C8R) ~$60
- Simpler but keeps extra power brick

**Option D: Minimal Budget - Keep Existing Setup** (~$25) 💰 CHEAPEST
- **Keep your current T-Mobile router** (already have antenna + PoE)
- Add small switch for mini rack devices
- [TP-Link 5-Port Gigabit Switch](https://www.amazon.com/TP-Link-TL-SG105-Gigabit-Ethernet-Optimization/dp/B00A128S24) ~$15
- OR [Netgear GS305](https://www.amazon.com/NETGEAR-5-Port-Gigabit-Ethernet-Unmanaged/dp/B07S98YLHM) ~$20
- Run single Ethernet from T-Mobile router to switch in rack
- **Perfect starter setup** - upgrade router later when budget allows
- WiFi stays on existing router (separate from rack)

**Option E: ASUS RT-AC1200G+ (You Already Own This!)** (~$0) ✅ FREE UPGRADE
- **Use your ASUS RT-AC1200G+ router** with T-Mobile PoE injector
- Setup:
  - T-Mobile PoE injector → 5G antenna (internet source)
  - PoE injector data out → ASUS WAN port
  - ASUS LAN ports: Pi 5 #1, Pi 5 #2, CM3588 NAS (+ 1 spare port)
- **Benefits:**
  - Better WiFi than T-Mobile router (AC1200 vs basic router)
  - Gigabit ports for all devices
  - More configuration options (QoS, DDNS, VPN, etc.)
  - Can use USB-C PD trigger cable for 12V power (cleaner cable management)
- **Mounting:** Place behind/beside rack for optimal WiFi coverage (not rack-mountable)
- **Power:** 12V 2A (24W) - use USB-C PD 12V trigger cable from hub
- **No switch needed** - router has 4 LAN ports (perfect for your 3 devices)

**Recommendation: Start with Option E (free!), upgrade to Option A later if you need 2.5GbE/WiFi 7**
- Native 802.3af PoE output - clean single-cable solution
- WiFi 7 + 2.5GbE ports future-proof the build
- Premium UniFi ecosystem (expandable)
- Worth $194 premium for integrated solution
- **Budget option:** Option B saves $194 but adds PoE injector

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

**Total wired ports needed: 3** (2 Pis + NAS) + 1 uplink to router

**Phase 1: Use ASUS RT-AC1200G+ (Option E - RECOMMENDED START):**
- Connect T-Mobile PoE injector → 5G antenna → ASUS WAN port
- ASUS LAN ports → Pi 5 #1, Pi 5 #2, CM3588 NAS (direct connections)
- Mount ASUS behind/beside rack for WiFi coverage
- Power ASUS with USB-C PD 12V trigger cable from hub
- **Total cost: $0 (you own everything)**
- No switch needed!

**Phase 1 Alternative: Minimal Budget (Option D):**
- Keep T-Mobile router where it is (antenna + WiFi)
- Run single Ethernet from router to mini rack
- 5-port Gigabit switch in rack
  - Port 1: Uplink to T-Mobile router
  - Port 2-4: Pi 5 #1, Pi 5 #2, CM3588 NAS
  - Port 5: Spare
- **Total cost: ~$15-25 for switch only**
- Upgrade router later when budget allows

**Phase 2: Premium Setup (Dream Router 7):**
- Dream Router 7 PoE port → 5G antenna (internet source, powered via PoE)
- Dream Router 7 LAN ports: Pi 5 #1, Pi 5 #2, CM3588 NAS (2.5GbE each!)
- WiFi 7 included for wireless devices (~1,750 sq ft coverage)
- Mount router outside/beside rack for optimal WiFi coverage
- No separate PoE injector needed

**Alternative (hAP ac² + PoE Injector) - Budget:**
- hAP ac² WAN port → PoE injector → 5G antenna
- hAP ac² LAN ports: Pi 5 #1, Pi 5 #2, CM3588 NAS (+ 1 spare)
- Saves $194 but adds extra device

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

**Option E - ASUS RT-AC1200G+ (Start Here - You Own It!):** ✅ RECOMMENDED
- USB-C PD 12V trigger cable for ASUS: $10-15
- Mounting hardware: $100-150
- USB-C PD hub (150W+): $100-120
- Cables + adapters: $30-50
- **Additional spend: ~$240-335**
- **Total project: ~$1,010-1,335**
- **Saves $15-20 vs Option D (no switch needed!)**

**Option D - Minimal Budget:**
- 5-port Gigabit switch: $15-25
- Mounting hardware: $100-150
- USB-C PD hub (150W+): $100-120
- Cables + adapters: $40-60
- **Additional spend: ~$255-355**
- **Total project: ~$1,025-1,355**

**Option B - Mid Budget:**
- WiFi router: $85 (hAP ac² + PoE injector)
- Mounting hardware: $100-150
- USB-C PD hub (150W+): $100-120
- Cables + adapters: $40-60
- **Additional spend: ~$325-415**
- **Total project: ~$1,095-1,415**

**Option A - Premium:**
- WiFi router: $279 (Dream Router 7)
- Mounting hardware: $100-150
- USB-C PD hub (150W+): $100-120
- Cables + adapters: $40-60
- **Additional spend: ~$519-609**
- **Total project: ~$1,289-1,609**

## Next Steps

**Recommended Path - Using ASUS RT-AC1200G+:** ✅ START HERE
1. ✅ Use your ASUS RT-AC1200G+ router (already owned!)
2. Keep T-Mobile PoE injector for antenna
3. Order USB-C PD 12V trigger cable for ASUS (~$10-15)
4. Verify CM3588 NAS supports USB-C PD 12V or get USB-C to barrel adapter
5. Confirm T-Mobile antenna PoE requirement is 802.3af (15.4W max)
6. Measure CM3588 NAS kit dimensions for mounting
7. Choose USB-C PD hub (150W+ with 4-6 ports) - UGREEN 200W recommended
8. Order mounting brackets, cables
9. Connect: T-Mobile PoE injector → Antenna → ASUS WAN port → LAN ports to devices
10. Mount ASUS behind/beside rack for WiFi coverage
11. Plan cable management strategy

**Alternative: Minimal Budget Path (If Not Using ASUS):**
1. Keep existing T-Mobile router + antenna
2. Order 5-port Gigabit switch (~$15-25)
3. Run single Ethernet from T-Mobile router to switch in rack

**Future Upgrade (When Budget Allows):**
- Replace ASUS + PoE injector with Dream Router 7 (integrated PoE + WiFi 7)
- OR keep ASUS and add Dream Router 7 as access point for WiFi 7 coverage

## Detailed Dimensional Analysis

### Rack Space Available (DeskPi RackMate TT)
- **Total:** 3U = 5.25" height
- **Width:** 10" (254mm) internal
- **Depth:** 8" (203mm) usable

### Component Dimensions (Verified)

**Bottom Layer - 1U (1.75"):**
- 2x Raspberry Pi 5 + NVMe HAT
- Each: 3.4" × 3.5" × 1" tall
- Side-by-side: 7" × 3.5" × 1" (fits in 10" width ✓)
- Mounted on: GeeekPi 1U shelf

**Middle Layer - 1U (1.75"):**
- CM3588 NAS Kit
- Estimate: 7" × 5" × 1.5-2" tall
- ⚠️ **Need to verify actual height!**
- Mounted on: GeeekPi 1U shelf

**Top Layer - 1U (1.75"):**
- ASUS RT-AC1200G+
- Size: 7.5" × 5" × 1.5" tall
- Fits with 3D printed bracket ✓

**USB-C PD Hub (fits under/behind shelf):**
- See comparison below
- Mount location: Under NAS shelf or on side rail

**T-Mobile PoE Injector:**
- Size: ~4" × 2.5" × 1.5"
- **Could fit on side/back of rack frame!**
- Alternative: Keep external

**UPS (Too Large - Must Stay External):**
- Allpowers P300: 9" × 5" × 8"
- Location: Under/beside rack

### Can Everything Fit Inside? 
**YES! With careful mounting:**
- 3U for devices (all fit ✓)
- Hub mounts under shelf or on side rail ✓
- PoE injector could mount on rear frame ✓
- Only UPS must stay external ✓

## USB-C PD Hub Comparison (Most Compact Options)

### Option 1: Anker 735 GaNPrime 65W (MOST COMPACT) ✅ RECOMMENDED
- **Size:** 4" × 3" × 1" (102mm × 76mm × 25mm)
- **Ports:** 3x USB-C (2×65W, 1×30W)
- **Total:** 65W max
- **Price:** ~$50
- **Pros:** Smallest footprint, perfect for tight spaces
- **Cons:** Need 2 units for full power (130W), or accept reduced power
- **Mount:** Velcro under shelf or side wall
- **Link:** [Amazon](https://www.amazon.com/Anker-Charger-GaNPrime-Compact-Foldable/dp/B0B2MH6Y94)

### Option 2: UGREEN 100W 4-Port (COMPACT + ADEQUATE)
- **Size:** 4.1" × 2.8" × 1.1" (105mm × 72mm × 28mm)
- **Ports:** 2x USB-C (100W, 30W) + 2x USB-A
- **Total:** 100W shared
- **Price:** ~$60
- **Pros:** Good balance size/power, single unit
- **Cons:** May need to reduce device power slightly
- **Mount:** Velcro under shelf
- **Link:** [Amazon](https://www.amazon.com/UGREEN-Charger-Compact-MacBook-Laptop/dp/B0C6F8DY47)

### Option 3: Satechi 165W 4-Port GaN (POWERFUL BUT LARGER)
- **Size:** 4.3" × 3.5" × 1.3" (110mm × 89mm × 33mm)
- **Ports:** 4x USB-C
- **Total:** 165W shared
- **Price:** ~$120
- **Pros:** Plenty of power for all devices
- **Cons:** Larger footprint, higher cost
- **Mount:** Fits under shelf (barely)
- **Link:** [Amazon](https://www.amazon.com/Satechi-Charger-Desktop-MacBook-Samsung/dp/B09FT7MJC3)

### Option 4: UGREEN 200W 6-Port (MAXIMUM POWER)
- **Size:** 4.5" × 3" × 1.3" (115mm × 75mm × 33mm)
- **Ports:** 4x USB-C + 2x USB-A
- **Total:** 200W shared
- **Price:** ~$100
- **Pros:** Most power, 6 ports (future expansion)
- **Cons:** Larger, heavier
- **Mount:** Under shelf or side rail
- **Link:** [Amazon](https://www.amazon.com/UGREEN-Charger-Desktop-Charging-Station/dp/B0C6DX66TN)

### Power Requirements Analysis
```
Device          | Required | With Margin
----------------|----------|-------------
Pi 5 #1         | 27W      | 30W
Pi 5 #2         | 27W      | 30W
CM3588 NAS      | 48W      | 50W
ASUS Router     | 24W      | 25W
----------------|----------|-------------
TOTAL           | 126W     | 135W
```

### Recommendation by Priority:

**Budget + Compact:** Anker 735 × 2 = $100, 130W total
- Smallest size, mount one under each shelf
- 130W total (slightly under requirement, but workable)

**Best Balance:** UGREEN 100W = $60, single unit
- Adequate power if devices don't peak simultaneously
- Very compact, easiest mounting

**No Compromise:** UGREEN 200W = $100, single unit
- Plenty of power + expansion ports
- Still fits under shelf or side mount

**Recommended:** **UGREEN 100W ($60)** or **UGREEN 200W ($100)**
- Both fit inside rack easily
- 200W gives more headroom and future expansion
- Single unit = cleaner than dual Anker setup

## Notes
- Verify Pi 5 NVMe HAT compatibility with mounting bracket
- Check if CM3588 NAS kit includes rack ears
- **⚠️ CRITICAL:** Measure CM3588 NAS actual height (affects 2U fit)
- Consider active cooling if stacking tightly
- Test UPS runtime under actual load before production use
- **T-Mobile antenna:** FWA-ED309B (Vistron NeWeb) - PoE-only powered, requires 802.3af/at
- **ASUS RT-AC1200G+:** 3D print 1U bracket for rack mounting
- ASUS can be powered via USB-C PD 12V trigger cable for cleaner cable management
- **USB-C PD 12V trigger cables:** [Amazon search](https://www.amazon.com/s?k=usb+c+pd+12v+trigger+cable) ~$10-15
- **PoE Injector:** Consider mounting inside rack on rear frame (saves external clutter)
- Dream Router 7 has 802.3af PoE (15.4W) - verify antenna requirement ≤15.4W
- If antenna needs >15.4W (802.3at/25.5W), use hAP ac² + 802.3at injector instead