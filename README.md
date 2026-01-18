# THE RACK - Build Specs

## Table of Contents
- [Rack Hardware](#rack-hardware)
- [Physical Layout](#physical-layout)
- [Components](#components)
- [Network Topology](#network-topology)
- [Power Distribution](#power-distribution)
- [Cable Specifications](#cable-specifications)
- [Power Requirements](#power-requirements)
- [Shopping Status](#shopping-status)
- [Reference Links](#reference-links)

## Rack Hardware
**DeskPi RackMate TT** - 10" Mini Rack
- 3U = 5.25" (133mm) H × 10" (254mm) W × 8" (203mm) D
- Per U: 10" × 8" × 1.75"

## Physical Layout

```
┌─────────────── 3U ───────────────┐
│ ASUS RT-AC1200G+ Router      [3U]│
│ 7.5" × 5" × 1.5"                 │
├──────────────────────────────────┤
│ CM3588 NAS + 3× 2.5" SSD     [2U]│
│ 5.5" × 4.7" × 2.5"               │
├──────────────────────────────────┤
│ Pi5 #1  |  Pi5 #2          [1U]│
│ 3.5" × 3.5" × 1.2" (each)        │
└──────────────────────────────────┘

External:
- T-Mobile 5G Antenna (FWA-ED309B) - wall mounted
- Allpowers P300 UPS (288Wh/300W) - beside rack
- PoE Injector (802.3at, 25.5W) - side mount inside rack
- UGREEN 200W Charger - rear mount inside rack
```

## Components

### Computing
| Device | Specs | Link |
|--------|-------|------|
| Raspberry Pi 5 × 2 | 8GB + NVMe HAT | [Official](https://www.raspberrypi.com/products/raspberry-pi-5/) |
| CM3588 NAS | 3× SATA, 3× Ethernet | [FriendlyElec](https://www.friendlyelec.com/index.php?route=product/product&product_id=294) |
| ASUS RT-AC1200G+ | AC1200, 4× GbE LAN | [ASUS](https://www.asus.com/networking-iot-servers/wifi-routers/asus-wifi-routers/rt-ac1200g-plus/) |

### Mounting
| Item | Purpose | Link |
|------|---------|------|
| GeeekPi 1U Shelf × 2 | Pi & NAS mount | [Amazon B0BPZ37MFS](https://www.amazon.com/dp/B0BPZ37MFS) |
| Router Bracket (3D print) | Router 1U mount | [STL Files](https://www.thingiverse.com/search?q=10+inch+rack+router+mount) |

### Power
| Device | Input | Output | Location | Link |
|--------|-------|--------|----------|------|
| Allpowers P300 | AC 110-240V | 288Wh, 300W | External | [Amazon](https://www.amazon.com/dp/B09NNVQZTF) |
| UGREEN 200W (Model 40914) | AC | 4× USB-C + 2× USB-A | Rear mount | [Amazon.pl B09PFNP7WY](https://www.amazon.pl/dp/B09PFNP7WY) |
| USB-C PD Trigger × 2 | USB-C PD | 12V DC 5.5×2.1mm | Inline | [Amazon.pl](https://www.amazon.pl/dp/B0CKNW7QMJ) |

## Network Topology

```
Internet → 5G Antenna → PoE Injector → Router (WAN)
                                          │
                    ┌─────────────────────┼─────────────────────┐
                    │                     │                     │
                  Pi5 #1              Pi5 #2              CM3588 NAS
                 (LAN1)              (LAN2)               (LAN3)
```

## Power Distribution

```
Wall → UPS (300W) → UGREEN 200W Hub
                        │
        ┌───────────────┼───────────────┬─────────────┐
        │               │               │             │
      Pi5#1           Pi5#2           NAS         Router
       27W             27W      48W (12V trigger)  24W (12V trigger)
```

**Total Draw:** 126W / 200W hub / 300W UPS
**UPS Runtime:** ~2.4 hours at full load

## Cable Specifications

| Type | Length | Qty | From → To |
|------|--------|-----|-----------|
| Cat6 | 0.3m | 3 | Router → Pi5#1, Pi5#2, NAS |
| Cat6 | 1m | 1 | PoE Injector → Router WAN |
| USB-C to C | 0.3m | 2 | Hub → Pi5#1, Pi5#2 |
| USB-C PD Trigger 12V (5.5×2.1mm) | 0.3m | 2 | Hub → NAS, Router |
| AC Power | 2m | 2 | Wall→UPS, UPS→Hub |

## Power Requirements

| Device | Voltage | Current | Power | Connector |
|--------|---------|---------|-------|-----------|
| Pi5 #1 | 5V PD | 5A | 27W | USB-C |
| Pi5 #2 | 5V PD | 5A | 27W | USB-C |
| CM3588 | 12V | 4A | 48W | DC 5.5×2.1mm |
| Router | 12V | 2A | 24W | DC 5.5×2.1mm |

## Shopping Status

### ✅ Owned
- GeeekPi 1U Shelf × 2
- ASUS RT-AC1200G+ Router
- T-Mobile PoE Injector + 5G Antenna
- Allpowers P300 UPS
- Cat6 cable 1m (PoE → Router)
- USB-C to USB-C cables 0.3m × 2 (Hub → Pi5s)

### ✅ Purchased (Order #404-0578284-5036360)
- UGREEN 200W Charger (B09PFNP7WY) - 71.98 zł
- Cable Matters Cat6 5-pack (0.3m)
- PNGKNYOCN USB-C PD 12V Trigger 4-pack (5.5×2.1mm)

### 🛒 Need
- [ ] Router bracket (3D print)

**Estimated:** $15-25

---

## Reference Links

### Components
- [Raspberry Pi 5 8GB](https://www.raspberrypi.com/products/raspberry-pi-5/)
- [CM3588 NAS](https://www.friendlyelec.com/index.php?route=product/product&product_id=294)
- [ASUS RT-AC1200G+ Specs](https://www.asus.com/networking-iot-servers/wifi-routers/asus-wifi-routers/rt-ac1200g-plus/)

### Hardware
- [GeeekPi 1U Shelf](https://www.amazon.com/dp/B0BPZ37MFS)
- [Allpowers P300 UPS](https://www.amazon.com/dp/B09NNVQZTF)
- [UGREEN 200W Charger](https://www.amazon.pl/dp/B09PFNP7WY)

### Cables
- [PNGKNYOCN USB-C PD Trigger (5.5×2.1mm)](https://www.amazon.pl/dp/B0CKNW7QMJ)
- [Cable Matters Cat6 Short Cables](https://www.amazon.com/s?k=cat6+ethernet+cable+6+inch)
- [USB-C to USB-C Cables](https://www.amazon.com/s?k=usb+c+cable+6+inch)

### 3D Printing
- [Router Mount STL Files](https://www.thingiverse.com/search?q=10+inch+rack+router+mount)
- [Shapeways](https://www.shapeways.com/)
- [PCBWay](https://www.pcbway.com/rapid-prototyping/3d-printing/)