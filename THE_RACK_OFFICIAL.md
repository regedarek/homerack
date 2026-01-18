# THE RACK - Official Build Guide

## 1. Rack Specifications

**DeskPi RackMate TT** - 10" Mini Rack
- **Height:** 3U = 5.25" (133mm)
- **Width:** 10" (254mm) internal
- **Depth:** 8" (203mm) usable
- **Per U:** 10" × 8" × 1.75"

## 2. Physical Layout

### Front View (Bottom to Top)

```
┌────────────────────────────────┐
│ EXTERNAL: T-Mobile 5G Antenna  │ ← Wall/desk mounted
└────────────────────────────────┘

┌─────────────── RACK (3U) ──────┐
│ ══════════════════════════ 3U  │
│ ASUS RT-AC1200G+ Router         │
│ 7.5" × 5" × 1.5"                │
│ [3D Printed 1U Mount]           │
│ ══════════════════════════ 2U  │
│ CM3588 NAS + 3x 2.5" SSD        │
│ 5.5" × 4.7" × 2.5"              │
│ [GeeekPi 1U Shelf]              │
│ ══════════════════════════ 1U  │
│ Pi5 #1    |    Pi5 #2           │
│ 3.5" × 3.5" × 1.2" (each)       │
│ [GeeekPi 1U Shelf]              │
└────────────────────────────────┘

┌────────────────────────────────┐
│ EXTERNAL: Allpowers P300 UPS   │ ← Under/beside rack
│           9.1" × 5.3" × 8.1"   │
└────────────────────────────────┘
```

### Back View (Connections)

```
┌─────────────── RACK (3U) ──────┐
│                            3U  │
│ [Router: WAN + 4×LAN + Power]  │
│       Antennas point up ↑      │
│                                │
│ [PoE Injector]            2U  │ ← Side mounted
│ 4" × 2.5" × 1.5"               │
│                                │
│ [NAS: 3×Ethernet + Power]      │
│                                │
│ [USB-C Hub]               1U  │ ← Rear mounted
│ 4.3" × 3" × 1.3"               │
│                                │
│ [Pi#1: Eth + USB-C Power]      │
│ [Pi#2: Eth + USB-C Power]      │
│                                │
│ AC Power Entry ← (from UPS)    │
└────────────────────────────────┘
```

## 3. Component List

### Computing Devices (Inside Rack)

| Device | Specs | Link |
|--------|-------|------|
| **Raspberry Pi 5 × 2** | 8GB + NVMe HAT | [Pi5 8GB](https://www.raspberrypi.com/products/raspberry-pi-5/) |
| **CM3588 NAS** | FriendlyElec, 3× SATA | [CM3588](https://www.friendlyelec.com/index.php?route=product/product&product_id=294) |
| **ASUS RT-AC1200G+** | AC1200, 4×GbE LAN | [Specs](https://www.asus.com/networking-iot-servers/wifi-routers/asus-wifi-routers/rt-ac1200g-plus/) |

### Mounting Hardware (Inside Rack)

| Item | Purpose | Link |
|------|---------|------|
| **GeeekPi 1U Shelf × 2** | Pi & NAS mounting | [Amazon B0BPZ37MFS](https://www.amazon.com/dp/B0BPZ37MFS) |
| **3D Printed Bracket** | Router 1U mount | [Thingiverse Search](https://www.thingiverse.com/search?q=10+inch+rack+router+mount) |

### Power Infrastructure

| Item | Specs | Location | Link |
|------|-------|----------|------|
| **Allpowers P300 UPS** | 288Wh, 300W output | External | [Official](https://www.allpowers.com/products/allpowers-s300-portable-power-station) or [Amazon](https://www.amazon.com/dp/B09NNVQZTF) |
| **UGREEN 200W Hub** | 4×USB-C + 2×USB-A | Inside (rear mount) | [Amazon B0C6DX66TN](https://www.amazon.com/dp/B0C6DX66TN) |
| **USB-C PD Trigger × 2** | 12V for NAS + Router | Inside | [Amazon 12V Trigger](https://www.amazon.com/dp/B09WN3J6M7) |

### Network Infrastructure

| Item | Purpose | Location | Link |
|------|---------|----------|------|
| **T-Mobile 5G Antenna** | FWA-ED309B | External | [Specs](https://www.t-mobile.com/support/devices/t-mobile-5g-home-internet-gateway) |
| **PoE Injector** | 802.3at, 25.5W | Inside (side mount) | [Generic PoE](https://www.amazon.com/dp/B003CFATQK) or T-Mobile provided |

### Cables

| Type | Length | Qty | Purpose | Link |
|------|--------|-----|---------|------|
| Cat6 patch | 6-12" | 3 | Router → Devices | [Monoprice 6" 6-pack](https://www.amazon.com/dp/B003L18SHC) |
| Cat6 patch | 3-6ft | 1 | PoE → Router WAN | [Monoprice 6ft](https://www.amazon.com/dp/B003L18SIU) |
| USB-C | 6-12" | 4 | Hub → Devices | [Anker 4-pack](https://www.amazon.com/dp/B09LCJPZ1P) |
| USB-C 12V trigger | 6-12" | 2 | NAS + Router power | [12V Trigger Cable](https://www.amazon.com/dp/B09WN3J6M7) |
| AC power | Included | 2 | Wall → UPS, UPS → Hub | Included with devices |

## 4. Network Diagram

```
[INTERNET]
    │
5G Antenna (FWA-ED309B)
    │
    │ PoE 802.3at (25.5W)
    ↓
PoE Injector ────────→ [Rack Side Mount]
    │
    │ Ethernet (3-6ft)
    ↓
┌───────────────────────────────┐
│ ASUS RT-AC1200G+ Router  [3U] │
│ WAN + 4×LAN + WiFi AC1200     │
└─┬────┬────┬────┬──────────────┘
  │    │    │    │
  │    │    │    └─→ (Spare)
  ↓    ↓    ↓
Pi5#1 Pi5#2 CM3588 NAS
[1U]  [1U]    [2U]
```

**Active Connections:**
- WAN: PoE Injector → Router
- LAN Port 1: Router → Pi5 #1 (Web Server)
- LAN Port 2: Router → Pi5 #2 (Home Server)
- LAN Port 3: Router → CM3588 NAS (3×1TB)
- LAN Port 4: Spare

## 5. Power Diagram

```
[WALL OUTLET]
    │
    ↓
┌──────────────────────────┐
│ Allpowers P300 UPS       │ ← External
│ 288Wh / 300W             │
│ Runtime: ~2.3 hours      │
└────────┬─────────────────┘
         │ AC (into rack rear)
         ↓
┌──────────────────────────┐
│ UGREEN 200W USB-C Hub    │ ← Rear mount
│ 4×USB-C + 2×USB-A        │
└─┬──┬──┬──┬───────────────┘
  │  │  │  │
  │  │  │  └─→ (Spare)
  ↓  ↓  ↓
 27W 27W 48W 24W
  │  │  │  │
Pi#1 Pi#2 NAS Router
     (12V) (12V)
     Trigger Trigger
```

**Power Budget:**
- Pi5 #1: 27W (USB-C direct)
- Pi5 #2: 27W (USB-C direct)
- CM3588 NAS: 48W (12V 4A via trigger)
- ASUS Router: 24W (12V 2A via trigger)
- **Total:** 126W / 200W available
- **UPS Runtime:** 288Wh ÷ 126W = 2.3 hours

## 6. Shopping List

### ✅ Already Owned
- GeeekPi 1U Rack Shelf × 2
- ASUS RT-AC1200G+ Router
- T-Mobile PoE Injector + 5G Antenna
- Allpowers P300 UPS
- 3D Printer

### 🛒 Must Buy (~$125-165)
- [ ] [UGREEN 200W USB-C Hub](https://www.amazon.com/dp/B0C6DX66TN): $100
- [ ] [USB-C to 12V trigger cable × 2](https://www.amazon.com/dp/B09WN3J6M7): $20-30
- [ ] [Monoprice SlimRun Cat6 6" (6-pack)](https://www.amazon.com/dp/B003L18SHC): $15
- [ ] [USB-C cables 6-12" (4-pack)](https://www.amazon.com/dp/B09LCJPZ1P): $15-20
- [ ] [Velcro strips](https://www.amazon.com/dp/B00006RSP1) + [zip ties](https://www.amazon.com/dp/B07VRSQ6YL) + [cable clips](https://www.amazon.com/dp/B07VFZ5K5D): $20

### 🖨️ 3D Print
- [ ] ASUS RT-AC1200G+ 1U bracket (10" × 8" × 1.75")
  - [Search Thingiverse](https://www.thingiverse.com/search?q=10+inch+rack+router+mount) or [Printables](https://www.printables.com/search/models?q=router%20rack%20mount)
  - Ventilation holes, rear port access
  - Material: PLA/PETG (~50g)

## 7. Assembly Order

1. 3D print router bracket
2. Install GeeekPi shelf at 1U (bottom)
3. Place Pi5 × 2 side-by-side on 1U shelf
4. Install GeeekPi shelf at 2U (middle)
5. Mount USB-C hub to rear frame (velcro)
6. Mount PoE injector to side frame (velcro)
7. Place CM3588 NAS on 2U shelf
8. Install 3D bracket at 3U (top)
9. Mount ASUS router in 3U bracket
10. Connect power: Wall → UPS → Hub → Devices
11. Connect network: Antenna → PoE → Router → Devices
12. Cable management: bundle and secure
13. Test all connections
14. Final cleanup

**Total Build Time:** ~2-3 hours