#!/bin/bash
set -e

WAR="/mnt/wars/LoginWebApp.war"   #actual path on war
TMP="tmp-dir"

rm -rf "$TMP"
mkdir "$TMP"

unzip -q "$WAR" -d "$TMP"

CONFIG=$(find "$TMP" -type f -name "userRegistration.jsp")

sed -i 's/"username"/"admin"/g' "$CONFIG"
sed -i 's/"password"/"admin1234"/g' "$CONFIG"
sed -i 's/localhost/mysql-db/g' "$CONFIG"    #localhost must be mysql-db in container

cd "$TMP"
zip -qr "../LoginWebApp.war" *
cd ..

mv -f LoginWebApp.war "$WAR"

rm -rf "$TMP"

echo "WAR updated with DB config!"
