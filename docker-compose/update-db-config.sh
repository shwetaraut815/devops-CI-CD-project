#!/bin/bash
set -e

WAR="/mnt/wars/LoginWebApp.war"
TMP="tmp-dir"

rm -rf "$TMP"
mkdir "$TMP"

unzip -q "$WAR" -d "$TMP"

CONFIG=$(find "$TMP" -type f -name "userRegistration.jsp")

sed -i 's/"username"/"admin"/g' "$CONFIG"
sed -i 's/"password"/"admin1234"/g' "$CONFIG"
sed -i 's/localhost/database-1.cevyoqyq8e62.us-east-1.rds.amazonaws.com/g' "$CONFIG"

cd "$TMP"
zip -qr "../LoginWebApp.war" *
cd ..

mv -f LoginWebApp.war "$WAR"

rm -rf "$TMP"

echo "WAR updated with DB config!"
