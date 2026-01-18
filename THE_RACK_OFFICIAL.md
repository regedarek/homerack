# THE RACK - Physical Layout & Connections

## Rack Specs
- **DeskPi RackMate TT** - 10" mini rack
- **Available:** 3U total = 5.25" (133mm) height
- **Width:** 10" (254mm) internal
- **Depth:** ~8" (203mm) usable
- **Usable volume per U:** 10" × 8" × 1.75" per U

## DETAILED Component Dimensions Analysis

### Computing Devices (Target: Fit in Rack)

1. **2x Raspberry Pi 5 + NVMe HAT**
   - Each Pi: 3.37" × 3.54" × 0.79" (85mm × 90mm × 20mm)
   - With NVMe HAT: 3.37" × 3.54" × 1.18" (30mm total height)
   - **Side-by-side:** 7" × 3.5" × 1.2" (fits in 10" width ✅)
   - **Space needed:** 0.7U (1.2" height)

2. **CM3588 NAS Kit (FriendlyElec)**
   - Board: ~5.5" × 4.7" × 1" (140mm × 120mm × 25mm)
   - With 3x 2.5" drives stacked: ~5.5" × 4.7" × 2.5"
   - **Space needed:** 1.4U (2.5" height)
   - **Critical:** Verify actual kit dimensions!

3. **ASUS RT-AC1200G+**
   - Dimensions: 7.5" × 5" × 1.5" (190mm × 127mm × 38mm)
   - With antennas: adds ~3" height (can angle backward)
   - **Space needed:** 0.9U (1.5" height)

**Subtotal: 3U** (1.2" + 2.5" + 1.5" = 5.2" ≈ 5.25" available ✅)

### Network/Power Infrastructure

4. **USB-C PD Hub (150W+)** - COMPACT OPTIONS:
   
   **Option A: Anker 735 GaNPrime 65W** (Need 2x for redundancy)
   - Size: 2.56" × 2.36" × 1.18" (65mm × 60mm × 30mm)
   - Ports: 3 (2× USB-C, 1× USB-A)
   - Power: 65W total
   - **Mount:** Side wall, velcro
   - **Cost:** $40 each × 2 = $80
   
   **Option B: UGREEN 200W Nexode Desktop** ⭐ RECOMMENDED
   - Size: 4.33" × 2.95" × 1.30" (110mm × 75mm × 33mm)
   - Ports: 6 (4× USB-C 100W + 2× USB-A)
   - Power: 200W total (perfect for all devices!)
   - **Mount:** Under NAS shelf or side wall
   - **Cost:** $100
   
   **Option C: Satechi 165W USB-C 4-Port GaN** 
   - Size: 4.25" × 3.46" × 1.26" (108mm × 88mm × 32mm)
   - Ports: 4 USB-C
   - Power: 165W total
   - **Mount:** Under shelf
   - **Cost:** $120
   
   **Option D: SMALLEST - Anker 747 GaNPrime 150W** ⭐ MOST COMPACT
   - Size: 3.94" × 3.15" × 1.38" (100mm × 80mm × 35mm)
   - Ports: 4 (3× USB-C, 1× USB-A)
   - Power: 150W total (tight but workable)
   - **Mount:** Fits ANYWHERE in rack
   - **Cost:** $90

5. **T-Mobile PoE Injector** (Can fit inside!)
   - Typical size: 4" × 2.5" × 1.5" (100mm × 60mm × 38mm)
   - **Mount:** Side wall or under shelf
   - **Space:** 0.2U equivalent if mounted efficiently

6. **T-Mobile 5G Antenna**
   - **Must stay external** (needs antenna placement)

7. **Allpowers P300 UPS**
   - Size: 9.13" × 5.31" × 8.07" (232mm × 135mm × 205mm)
   - **TOO LARGE - stays external**

## OPTIMIZED Physical Layout (All Components Inside!)

### Height Budget Analysis:
- **Available:** 5.25" total (3U)
- **Pi layer:** 1.2" (0.7U)
- **NAS layer:** 2.5" (1.4U) 
- **Router layer:** 1.5" (0.9U)
- **Total devices:** 5.2" = 2.97U ≈ **3U EXACTLY!** ✅

### Space for USB-C Hub + PoE Injector:
- **Hub:** Mount on SIDE RAIL or UNDER shelf (outside device footprint)
- **PoE Injector:** Mount on SIDE RAIL or rear frame
- Both fit in DEPTH dimension (rack is 8" deep, devices only ~5-7" deep)

## Physical Layout (Bottom to Top)

```
┌─────────────── RACK (3U) ───────┐
│ 3U (1.5")                       │
│ ╔════════════════════════════╗  │
│ ║ ASUS RT-AC1200G+ Router    ║  │
│ ║ [3D Printed Bracket]       ║  │
│ ╚════════════════════════════╝  │
│                                  │
│ 2U (2.5")                   [P] │ ← PoE Injector
│ ╔════════════════════════╗  [o] │   (side mounted)
│ ║ CM3588 NAS + 3x SSD    ║  [E] │
│ ║ [GeeekPi 1U Shelf]     ║      │
│ ╚════════════════════════╝ [USB]│ ← USB-C Hub
│                            [Hub]│   (side/rear mounted)
│ 1U (1.2")                       │
│ ╔══════╗   ╔══════╗            │
│ ║ Pi5  ║   ║ Pi5  ║            │
│ ║  #1  ║   ║  #2  ║            │
│ ╚══════╝   ╚══════╝            │
│ [GeeekPi 1U Shelf]              │
└─────────────────────────────────┘
    ▲              ▲
  Devices    Infrastructure
  (front)    (side/rear mounted)

EXTERNAL (Only 2 items):
├─ UPS (under/beside rack) 
└─ 5G Antenna (desk/wall mount)
```

**Total Used: 3U FULL** ✅
- **All compute devices:** Inside
- **USB-C Hub:** Inside (side/rear rail)
- **PoE Injector:** Inside (side/rear rail)
- **External only:** UPS + Antenna

## Network Connections Schematic

```
                    [INTERNET SOURCE]
                           │
                    5G Antenna (FWA-ED309B)
                           │
                    ═══════════════
                    PoE 802.3at (25.5W)
                    ═══════════════
                           │
              T-Mobile PoE Injector
                   [Behind Rack]
                           │
                      [Ethernet]
                           │
        ┌──────────────────┴──────────────────┐
        │      ASUS RT-AC1200G+ Router        │
        │         [Top 1U in Rack]            │
        │  WAN: From PoE Injector             │
        │  LAN: 4x Gigabit Ports              │
        │  WiFi: AC1200 (2.4GHz + 5GHz)       │
        └─────┬────────┬────────┬────────┬────┘
              │        │        │        │
           [Port 1] [Port 2] [Port 3] [Port 4]
              │        │        │        │
              │        │        │        └──> (Spare)
              │        │        │
              ↓        ↓        ↓
          ┌───────┐ ┌───────┐ ┌──────────┐
          │ Pi5#1 │ │ Pi5#2 │ │ CM3588   │
          │  Web  │ │ Home  │ │   NAS    │
          │Server │ │Server │ │ 3x1TB    │
          └───────┘ └───────┘ └──────────┘
            [1U Shelf]       [1U Shelf]
         
         ASUS Router mounted at top (3U)
         [3D Printed 1U Bracket]

Total Devices: 3 active + 1 spare port
Cable Lengths: 6-12" patch cables (inside rack)
               3-6ft cable (PoE injector → ASUS)
```

## Power Connections Schematic

```
                    [WALL OUTLET]
                         │
                      [AC In]
                         │
                         ↓
        ┌────────────────────────────────┐
        │  Allpowers P300 UPS            │
        │  Capacity: 288Wh               │
        │  Output: 300W                  │
        │  [Under/Beside Rack]           │
        └────────────┬───────────────────┘
                     │
                  [AC Out]
                     │
                     ↓
        ┌────────────────────────────────┐
        │  USB-C PD Hub (100W)           │
        │  UGREEN 100W 4-port (compact)  │
        │  [INSIDE RACK - Under NAS 2U]  │
        │  Velcro/zip-tie to rear frame  │
        └─┬────┬────┬────┬────┘
          │    │    │    │
      Port1 Port2 Port3 Port4
      100W  30W  (USB-A spare)
          │    │    │    │
     [USB-C cables 6-12"]
          │    │    │    │
          ↓    ↓    ↓    ↓
       ┌────┐┌────┐┌────┐┌─────┐
       │Pi#1││Pi#2││ NAS││ASUS │
       │27W ││27W ││48W ││24W  │
       └────┘└────┘│12V ││12V  │
        [1U]  [1U] │Trig││Trig │
                   └────┘└─────┘
                    [1U]  [Ext]

Power Budget:
- Pi 5 #1: 27W actual (30W allocated)
- Pi 5 #2: 27W actual (30W allocated)  
- CM3588 NAS: 48W (12V 4A via USB-C PD trigger)
- ASUS Router: 24W (12V 2A via USB-C PD trigger)
- Total Draw: 126W
- UPS Runtime: 288Wh ÷ 126W = ~2.3 hours
```

## Cable Requirements

### Network Cables
- 1x 3-6ft: PoE Injector → ASUS WAN (external → rack)
- 3x 6-12": ASUS LAN → Rack devices (short patch cables)

### Power Cables
- 4x USB-C cables (6-12") - from hub to devices
- 2x USB-C to 12V trigger cables (for NAS + ASUS)
- 1x AC cable (wall → UPS) - external
- 1x AC cable (UPS → Hub) - **routes INTO rack rear**
  - Cable enters through rear opening
  - Hub mounted under NAS shelf (2U)

## Shopping List (Specific Items)

### Already Owned ✅
- [x] GeeekPi 1U Rack Shelf (x2 - already purchased!)
- [x] ASUS RT-AC1200G+ Router
- [x] T-Mobile PoE Injector + 5G Antenna
- [x] Allpowers P300 UPS
- [x] 3D Printer (for custom ASUS mount)

### Must Buy
- [ ] UGREEN 100W USB-C hub (4-port, compact): $60
  - OR UGREEN 200W (if want more power/expansion): $100
- [ ] USB-C to 12V trigger cable (2x): $20-30
  - For CM3588 NAS (12V 4A)
  - For ASUS Router (12V 2A)
- [ ] Monoprice SlimRun Cat6 6" (6-pack): $15
- [ ] USB-C cables 6-12" (4-pack): $15-20
- [ ] Heavy-duty velcro strips for USB-C hub: $8
- [ ] Zip ties for hub cable management: $5
- [ ] Cable management clips: $10

### 3D Print (DIY)
- [ ] ASUS RT-AC1200G+ 1U rack mount bracket
  - Design: Custom bracket to hold 7.5" × 5" × 1.5" router
  - Features: Ventilation holes, 10" width, rear cable access
  - Material: PLA or PETG (~50g filament)

**Total: ~$125-165** (with UGREEN 100W)
**OR: ~$165-205** (with UGREEN 200W for more headroom)

## Assembly Order

1. **3D print** ASUS router bracket (1U mount, 10" wide)
2. Install GeeekPi 1U shelf at bottom (1U position)
3. Place both Pi 5s side-by-side on bottom shelf
4. Install second GeeekPi 1U shelf in middle (2U position)
5. **Mount USB-C hub to UNDERSIDE/REAR of 2U shelf** (velcro + zip ties)
   - Hub dimensions: ~4.5" × 3" × 1.3" (fits under/behind NAS)
   - Position so ports face forward for easy cable access
   - Secure power cable to rack frame
6. Place CM3588 NAS on middle shelf (above hub)
7. Install 3D printed ASUS bracket at top (3U position)
8. Mount ASUS router in 3D bracket (top slot)
9. Position PoE injector behind/beside rack (external)
10. **Power:** Wall → UPS → **AC cable into rack rear** → USB-C hub (under 2U shelf)
11. **Network:** Antenna → PoE injector → ASUS WAN (rear) → LAN ports → Devices below
12. Route USB-C cables from hub UP to NAS, DOWN to Pis, UP to ASUS
13. Cable management: Bundle cables along rear/side rails, secure with clips/zip ties
13. Test all connections (network + power)
14. Final cable tie-down and organization

✅ All devices + USB-C hub fit in 3U rack - fully self-contained build!
✅ Only external components: UPS, 5G antenna, PoE injector

## 3D Print Design Notes

**ASUS RT-AC1200G+ 1U Bracket Specs:**
- Width: 10" (standard rack width)
- Depth: 8" (to fit router 7.5" × 5" footprint)
- Height: 1U (1.75")
- Features needed:
  - Ventilation slots (top/sides for airflow)
  - Rear cutout for ports (WAN, LAN, power, antennas)
  - Router sits horizontally (antennas point up/back)
  - Mounting holes for rack ears
  - Optional: cable guides on sides

**Alternative:** Search Thingiverse/Printables for "10 inch rack router mount" or "1U router bracket"