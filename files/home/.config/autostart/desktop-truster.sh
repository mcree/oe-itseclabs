#!/bin/bash
#
# Source: https://askubuntu.com/questions/1070057/trust-desktop-icons-without-clicking-them-manually-in-ubuntu-18-04-gnome-3
#
# Wait for nautilus-desktop
while ! pgrep -f 'nautilus-desktop' > /dev/null; do
  sleep 1
done
# Trust all desktop files
for i in ~/Desktop/*.desktop; do
  [ -f "${i}" ] || break
  gio set "${i}" "metadata::trusted" true
done
# Restart nautilus, so that the changes take effect (otherwise we would have to press F5)
killall nautilus-desktop && nautilus-desktop &
# Remove X from this script, so that it won't be executed next time
chmod -x ${0}
