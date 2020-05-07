#!/bin/bash

tmpfile=$(mktemp)
trap "rm -f $tmpfile" exit

for eml in *.eml; do
    cat "$eml" \
	| sed -r 's/(sztakimail.sztaki.hu|sztaki.hu|tricon.hu|kiskapu.hu|pult.hu|itc.hu|rigo.info|tricon.loc|mabisz.hu|mabisz.local)/itseclabs.local/g' \
	| sed -r 's/(rigo|mcree|rigo.erno|erno.rigo|net-admin)@/hallgato@/g' \
	> $tmpfile
    cp -fv "$tmpfile" "$eml"
done
