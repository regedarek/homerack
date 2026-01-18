# THE RACK - Official Build Guide

## Table of Contents
- [1. Rack Specifications](#1-rack-specifications)
- [2. Physical Layout](#2-physical-layout)
- [3. Component List](#3-component-list)
- [4. Network Diagram](#4-network-diagram)
- [5. Power Diagram](#5-power-diagram)
- [6. Shopping List](#6-shopping-list)

## 1. Rack Specifications

**DeskPi RackMate TT** - 10" Mini Rack
- **Height:** 3U = 5.25" (133mm)
- **Width:** 10" (254mm) internal
- **Depth:** 8" (203mm) usable
- **Per U:** 10" × 8" × 1.75"

## 2. Physical Layout

### Front View (Bottom to Top)

```
┌──────────────────────────────────┐
│ EXTERNAL: T-Mobile 5G Antenna    │ ← Wall/desk mounted
└──────────────────────────────────┘

┌────────────── RACK (3U) ─────────┐
│ ════════════════════════════ 3U  │
│ ASUS RT-AC1200G+ Router           │
│ 7.5" × 5" × 1.5"                  │
│ [1U Router Bracket]               │
│ ════════════════════════════ 2U  │
│ CM3588 NAS + 3x 2.5" SSD          │
│ 5.5" × 4.7" × 2.5"                │
│ [GeeekPi 1U Shelf]                │
│ ════════════════════════════ 1U  │
│ Pi5 #1    |    Pi5 #2             │
│ 3.5" × 3.5" × 1.2" (each)         │
│ [GeeekPi 1U Shelf]                │
└──────────────────────────────────┘

┌──────────────────────────────────┐
│ EXTERNAL: Allpowers P300 UPS     │ ← Under/beside rack
│           9.1" × 5.3" × 8.1"     │
└──────────────────────────────────┘
```

### Back View (Connections)

```
┌────────────── RACK (3U) ─────────┐
│                              3U  │
│ [Router: WAN + 4×LAN + Power]    │
│       Antennas point up ↑        │
│                                  │
│ [PoE Injector]              2U  │ ← Side mounted
│ 4" × 2.5" × 1.5"                 │
│                                  │
│ [NAS: 3×Ethernet + Power]        │
│                                  │
│ [USB-C Hub]                 1U  │ ← Rear mounted
│ 4.3" × 3" × 1.3"                 │
│                                  │
│ [Pi#1: Eth + USB-C Power]        │
│ [Pi#2: Eth + USB-C Power]        │
│                                  │
│ AC Power Entry ← (from UPS)      │
└──────────────────────────────────┘
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
| **Router Bracket** | Router 1U mount | [3D Print Service](https://www.shapeways.com/) or [PCBWay](https://www.pcbway.com/rapid-prototyping/3d-printing/) + [STL Files](https://www.thingiverse.com/search?q=10+inch+rack+router+mount) |

### Power Infrastructure

| Item | Specs | Location | Link |
|------|-------|----------|------|
| **Allpowers P300 UPS** | 288Wh, 300W output | External | [Official](https://www.allpowers.com/products/allpowers-s300-portable-power-station) or [Amazon](https://www.amazon.com/dp/B09NNVQZTF) |
| **UGREEN 200W Hub** | 4×USB-C + 2×USB-A | Inside (rear mount) | [Amazon B0C6DX66TN](https://www.amazon.com/dp/B0C6DX66TN) |
| **USB-C PD Trigger × 2** | 12V for NAS + Router | Inside | [Amazon 12V Trigger Search](https://www.amazon.com/s?k=usb+c+pd+trigger+cable+12v) |

**DC Barrel Connector Specifications:**
- **CM3588 NAS**: 12V 4A → DC 5.5×2.1mm barrel (standard)
- **ASUS RT-AC1200G+**: 12V 1-2A → DC 5.5×2.1mm barrel ✅ **Verified**

### Network Infrastructure

| Item | Purpose | Location | Link |
|------|---------|----------|------|
| **T-Mobile 5G Antenna** | FWA-ED309B | External | [Specs](https://www.t-mobile.com/support/devices/t-mobile-5g-home-internet-gateway) |
| **PoE Injector** | 802.3at, 25.5W | Inside (side mount) | [Generic PoE](https://www.amazon.com/dp/B003CFATQK) or T-Mobile provided |

### Cables

| Type | Length | Qty | Purpose | Link |
|------|--------|-----|---------|------|
| Cat6 Ethernet | 6" | 3 | Router → Pi5s + NAS (short patch cables) | [Amazon Cat6 6" 6-pack](https://www.amazon.com/s?k=cat6+ethernet+cable+6+inch) |
| Cat6 Ethernet | 3-6ft | 1 | PoE Injector → Router WAN | [Amazon Cat6 3ft](https://www.amazon.com/s?k=cat6+ethernet+cable+3+feet) |
| USB-C to USB-C | 6-12" | 2 | USB Hub → Pi5 #1 + Pi5 #2 (power) | [Anker Short USB-C](https://www.amazon.com/s?k=usb+c+cable+6+inch) |
| USB-C PD Trigger 12V | 6-12" | 2 | USB Hub → NAS + Router (12V, DC 5.5×2.1mm) | [PNGKNYOCN 5.5×2.1mm 4-pack](https://www.amazon.pl/dp/B0CKNW7QMJ) or [KUOQIY](https://www.amazon.pl/dp/B0CGF7JDRC) |
| AC Power Cable | 6ft | 2 | Wall → UPS, UPS → USB Hub | Included with UPS and Hub |

## 4. Network Diagram

```
        [INTERNET]
            │
    5G Antenna (FWA-ED309B)
            │
            │ PoE 802.3at (25.5W)
            ↓
PoE Injector ─────────→ [Rack Side Mount]
            │
            │ Ethernet (3-6ft)
            ↓
┌─────────────────────────────────┐
│ ASUS RT-AC1200G+ Router    [3U] │
│ WAN + 4×LAN + WiFi AC1200       │
└─┬─────┬─────┬─────┬─────────────┘
  │     │     │     │
  │     │     │     └──→ (Spare)
  ↓     ↓     ↓
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
┌────────────────────────────┐
│ Allpowers P300 UPS         │ ← External
│ 288Wh / 300W               │
│ Runtime: ~2.3 hours        │
└──────────┬─────────────────┘
           │ AC (into rack rear)
           ↓
┌────────────────────────────┐
│ UGREEN 200W USB-C Hub      │ ← Rear mount
│ 4×USB-C + 2×USB-A          │
└──┬───┬───┬───┬─────────────┘
   │   │   │   │
   │   │   │   └──→ (Spare)
   ↓   ↓   ↓
  27W 27W 48W 24W
   │   │   │   │
 Pi#1 Pi#2 NAS Router
      (12V) (12V)
     Trigger Trigger
```

**Power Budget:**
- Pi5 #1: 27W (USB-C direct)
- Pi5 #2: 27W (USB-C direct)
- CM3588 NAS: 48W (12V 4A via trigger)
- ASUS Router: 12-24W (12V 1-2A via trigger)
- **Total:** ~114-126W / 300W available (UPS capacity)
- **Hub Capacity:** 200W (sufficient for 126W draw)
- **UPS Runtime:** 288Wh ÷ 120W = ~2.4 hours

## 6. Shopping List

### ✅ Already Owned
- GeeekPi 1U Rack Shelf × 2
- ASUS RT-AC1200G+ Router
- T-Mobile PoE Injector + 5G Antenna
- Allpowers P300 UPS

### ✅ Recently Purchased (Jan 18, 2026 - Order #404-0578284-5036360)
- [x] **UGREEN 200W USB-C Charger** (100W + 100W, 6 ports) → **71.98 zł** ✅
  - Model: UGREEN 200W Ładowarka USB C GaN II PPS
  - Ports: 4×USB-C + 2×USB-A
  - ⚠️ **Note**: Price significantly lower than US version - verify specs match 200W total output
- [x] **Cable Matters Cat6 Ethernet 5-pack** (0.3m/12") → **Included in order** ✅
  - 10 Gb/s short cables, black
  - Perfect for internal rack connections (Pi5s, NAS, Router)
- [x] **PNGKNYOCN USB-C PD 12V Trigger 4-pack** (5.5×2.1mm, 90°) → **Included in order** ✅
  - For CM3588 NAS (12V 4A) + ASUS Router (12V 2A)
  - ✅ **Both devices use 5.5×2.1mm barrel** - 2 spares remaining

### 🛒 Still Need to Buy (~$30-60)
- [ ] **Cat6 Ethernet 3ft cable** (PoE Injector → Router WAN) → [Shop](https://www.amazon.com/s?k=cat6+ethernet+cable+3+feet): **$5-8**
- [ ] **USB-C to USB-C short cables × 2** (Hub → Pi5 power) → [Shop](https://www.amazon.com/s?k=usb+c+cable+6+inch): **$10-15**
- [ ] **Cable management kit** → [Velcro](https://www.amazon.com/dp/B00006RSP1) | [Zip ties](https://www.amazon.com/dp/B07VRSQ6YL) | [Cable clips](https://www.amazon.com/s?k=adhesive+cable+clips): **$15-20**
- [ ] **Router 1U bracket 3D print** → [Shapeways](https://www.shapeways.com/) | [PCBWay](https://www.pcbway.com/rapid-prototyping/3d-printing/) | [STL files](https://www.thingiverse.com/search?q=10+inch+rack+router+mount): **$25-45**

