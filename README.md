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
1. Create the user config directories and copy the files in:

       mkdir -p ~/.config/regolith3/i3xrocks/scripts ~/.config/regolith3/i3xrocks/conf.d
       install -m 755 scripts/bt-battery ~/.config/regolith3/i3xrocks/scripts/bt-battery
       install -m 644 conf.d/85_bt-battery ~/.config/regolith3/i3xrocks/conf.d/85_bt-battery

2. Keep the default blocks (see below), then reload the bar:

       i3-msg restart

The `85_` prefix places the block just before the clock (`90_time`). Rename
the file to change its position.

## Keeping the default blocks
Regolith starts the bar with
`i3xrocks -u ~/.config/regolith3/i3xrocks/conf.d -d /usr/share/i3xrocks/conf.d`.
Once the user `conf.d` directory exists, only the files in it are loaded, so
the default blocks (`01_setup`, net traffic, CPU, clock, ...) disappear and
only this block is shown. `01_setup` also holds the shared colors and fonts.

To bring them back, symlink the defaults into the user directory. Symlinks
keep following package updates:

    for f in /usr/share/i3xrocks/conf.d/*; do
        ln -s "$f" ~/.config/regolith3/i3xrocks/conf.d/
    done

To drop one of the defaults, delete its symlink. To customize one, replace the
symlink with a copy of the file and edit that. Other optional blocks from
Regolith (`apt search i3xrocks`) can be added the same way, by symlinking their
file from `/usr/share/i3xrocks/conf.d`.

## Requirements
Regolith 3, `upower`, `xrescat`, and a Nerd Font for the icon.

## Limitations
- Devices must report battery over the standard Bluetooth Battery Service.
  Many headphones do not.
- Split ZMK keyboards (e.g. Corne) only report the central half.
