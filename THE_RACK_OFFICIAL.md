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
| **Raspberry Pi 5 × 2** | 8GB + NVMe HAT | https://www.raspberrypi.com/products/raspberry-pi-5/ |
| **CM3588 NAS** | FriendlyElec, 3× SATA | https://www.friendlyelec.com/index.php?route=product/product&product_id=294 |
| **ASUS RT-AC1200G+** | AC1200, 4×GbE LAN | Standard router |

### Mounting Hardware (Inside Rack)

| Item | Purpose | Link |
|------|---------|------|
| **GeeekPi 1U Shelf × 2** | Pi & NAS mounting | https://www.amazon.com/dp/B0BPZ37MFS |
| **3D Printed Bracket** | Router 1U mount | DIY - see design notes |

### Power Infrastructure

| Item | Specs | Location | Link |
|------|-------|----------|------|
| **Allpowers P300 UPS** | 288Wh, 300W output | External | https://www.allpowers.com/ |
| **UGREEN 200W Hub** | 4×USB-C + 2×USB-A | Inside (rear mount) | https://www.amazon.com/dp/B0C6DX66TN |
| **USB-C PD Trigger × 2** | 12V for NAS + Router | Inside | https://www.amazon.com/s?k=usb-c+12v+trigger |

### Network Infrastructure

| Item | Purpose | Location | Link |
|------|---------|----------|------|
| **T-Mobile 5G Antenna** | FWA-ED309B | External | T-Mobile provided |
| **PoE Injector** | 802.3at, 25.5W | Inside (side mount) | T-Mobile provided |

### Cables

| Type | Length | Qty | Purpose |
|------|--------|-----|---------|
| Cat6 patch | 6-12" | 3 | Router → Devices |
| Cat6 patch | 3-6ft | 1 | PoE → Router WAN |
| USB-C | 6-12" | 4 | Hub → Devices |
| USB-C 12V trigger | 6-12" | 2 | NAS + Router power |
| AC power | Included | 2 | Wall → UPS, UPS → Hub |

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
- [ ] UGREEN 200W USB-C Hub: $100
- [ ] USB-C to 12V trigger cable × 2: $20-30
- [ ] Monoprice SlimRun Cat6 6" (6-pack): $15
- [ ] USB-C cables 6-12" (4-pack): $15-20
- [ ] Velcro strips + zip ties + cable clips: $20

### 🖨️ 3D Print
- [ ] ASUS RT-AC1200G+ 1U bracket (10" × 8" × 1.75")
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