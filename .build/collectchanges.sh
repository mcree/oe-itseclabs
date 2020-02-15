#!/bin/bash
rsync -arx --delete /var/tmp/hallgato/ /var/tmp/hallgato.prev/
rsync -arx --delete --delete-excluded \
    --exclude .cache \
    --exclude oe-itseclabs* \
    --exclude .local/share \
    --exclude .mozilla \
    --exclude .dotnet \
    --exclude .nuget \
    --exclude .local/share/NuGet \
    --exclude '.xsession-errors*' \
    --exclude .vboxclient-seamless.pid \
    /home/hallgato/ /var/tmp/hallgato/
diff -ruN /var/tmp/hallgato.prev/ /var/tmp/hallgato/
