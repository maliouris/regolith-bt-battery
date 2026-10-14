# regolith-bt-battery

An i3xrocks block for Regolith 3 (i3) that shows the battery percentage of
connected Bluetooth devices (keyboard, mouse, ...) in the top bar, e.g.
`Corne 87%  UGREEN BLE Mouse 40%`.

## How it works
BlueZ exposes a device's Battery Service as `org.bluez.Battery1`, and UPower
republishes it. `scripts/bt-battery` lists UPower devices whose native path is
under `/org/bluez/` and prints name and percentage for each one. Values at or
below 20% use the `i3xrocks.critical.color` Xresources color. When no device
reports a battery, the block prints nothing and hides itself. Clicking it opens
the Bluetooth settings.

## Install
    ./install.sh
    i3-msg restart

This copies the script and `conf.d/85_bt-battery` into
`~/.config/regolith3/i3xrocks/`. Because a user `conf.d` directory hides the
default blocks, the installer also symlinks the ones from
`/usr/share/i3xrocks/conf.d`.

## Requirements
Regolith 3, `upower`, `xrescat`, and a Nerd Font for the icon.

## Limitations
- Devices must report battery over the standard Bluetooth Battery Service.
  Many headphones do not.
- Split ZMK keyboards (e.g. Corne) only report the central half.
