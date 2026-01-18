# THE RACK - Physical Layout & Connections

## Rack Specs
- **DeskPi RackMate TT** - 10" mini rack
- **Available:** 3U total (5.25" height)
- **Width:** 10" (254mm) internal
- **Depth:** ~8" (203mm) usable

## Component Dimensions Check

### In-Rack Components
1. **2x Raspberry Pi 5 + NVMe HAT**
   - Dimensions: 3.4" × 3.5" × 1" each (with HAT)
   - Mounting: GeeekPi 1U shelf (side-by-side layout)

2. **CM3588 NAS Kit**
   - Dimensions: ~7" × 5" × 2" (verify actual kit size)
   - Mounting: GeeekPi 1U shelf (top unit)

3. **ASUS RT-AC1200G+**
   - Dimensions: 7.5" × 5" × 1.5"
   - Mounting: 3D printed 1U bracket (top slot, 3U position)
   - Use as: Router + Switch (4 LAN ports)

### External Components (NOT in rack)

4. **T-Mobile 5G Antenna + PoE Injector**
   - Location: Desk/wall mount + injector behind rack

5. **Allpowers P300 UPS**
   - Location: Under/beside rack

## Physical Layout (Bottom to Top)

```
┌─────────────────────────────────┐
│  EXTERNAL: ASUS Router          │ ← Behind/beside rack
│  (WiFi coverage area)           │
└─────────────────────────────────┘

┌─────────────── RACK (3U) ───────┐
│ ══════════════════════════ 3U  │
│ ASUS RT-AC1200G+ Router         │
│ [3D Printed 1U Mount]           │
│ ══════════════════════════ 2U  │
│ CM3588 NAS                      │
│ [Shelf: GeeekPi 1U]             │
│ ══════════════════════════ 1U  │
│ Pi5 #1    |    Pi5 #2           │
│ [Shelf: GeeekPi 1U]             │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│  EXTERNAL: UPS + USB-C Hub      │ ← Under/beside rack
│  5G Antenna + PoE Injector      │
└─────────────────────────────────┘
```

**Total Used: 3U** (FULL - all devices in rack!)

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
        │  USB-C PD Hub (150W+)          │
        │  UGREEN 200W 6-port            │
        │  [Behind Rack - Velcro Mount]  │
        └─┬────┬────┬────┬────┬────┬────┘
          │    │    │    │    │    │
      Port1 Port2 Port3 Port4 Port5 Port6
       30W  30W   60W   60W  (spare)(spare)
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
- 1x 3-6ft: PoE Injector → ASUS WAN
- 3x 6-12": ASUS LAN → Rack devices (short patch cables)

### Power Cables
- 4x USB-C cables (6-12")
- 2x USB-C to 12V trigger cables (for NAS + ASUS)
- 1x AC cable (wall → UPS)
- 1x AC cable (UPS → USB-C hub)

## Shopping List (Specific Items)

### Already Owned ✅
- [x] GeeekPi 1U Rack Shelf (x2 - already purchased!)
- [x] ASUS RT-AC1200G+ Router
- [x] T-Mobile PoE Injector + 5G Antenna
- [x] Allpowers P300 UPS
- [x] 3D Printer (for custom ASUS mount)

### Must Buy
- [ ] UGREEN 200W USB-C hub: $100
- [ ] USB-C to 12V trigger cable (2x): $20-30
  - For CM3588 NAS (12V 4A)
  - For ASUS Router (12V 2A)
- [ ] Monoprice SlimRun Cat6 6" (6-pack): $15
- [ ] USB-C cables 6-12" (4-pack): $15-20
- [ ] Velcro strips for USB-C hub mounting: $5
- [ ] Cable management clips: $10

### 3D Print (DIY)
- [ ] ASUS RT-AC1200G+ 1U rack mount bracket
  - Design: Custom bracket to hold 7.5" × 5" × 1.5" router
  - Features: Ventilation holes, 10" width, rear cable access
  - Material: PLA or PETG (~50g filament)

**Total: ~$165-180** (+ free 3D print)

## Assembly Order

1. **3D print** ASUS router bracket (1U mount, 10" wide)
2. Install GeeekPi 1U shelf at bottom (1U position)
3. Place both Pi 5s side-by-side on bottom shelf
4. Install second GeeekPi 1U shelf in middle (2U position)
5. Place CM3588 NAS on middle shelf
6. Install 3D printed ASUS bracket at top (3U position)
7. Mount ASUS router in 3D bracket (top slot)
8. Mount USB-C hub behind rack with velcro
9. Position PoE injector behind rack
10. **Network:** Antenna → PoE injector → ASUS WAN (rear) → LAN ports → Devices below
11. **Power:** Wall → UPS → USB-C hub → All 4 devices
12. Cable management: Route short 6" cables vertically, secure with clips
13. Test all connections (network + power)
14. Final cable tie-down and organization

✅ All devices fit perfectly in 3U rack - fully integrated build!

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