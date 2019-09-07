#!/bin/bash

set -e

cp systemd/* /etc/systemd/user/
systemctl daemon-reload
./stop.sh
cd ../../

cd treetracker-mobile-api
git fetch origin master
git reset --hard
git checkout release
git pull
npm install
cd ../

cd treetracker-web-map
git fetch origin master
git reset --hard
git checkout release
git pull
cd server
npm install
cd ../client
\rm -Rf /var/www/html/*
cp -Rp * /var/www/html/
cd ../../

cd treetracker-admin
git fetch origin master
git reset --hard
git checkout release
git pull
cd server
npm install
cd ../client
npm install
npm run-script build
\rm -Rf /var/www/admin/*
cp -Rp build/* /var/www/admin/
cd ../../

cd treetracker-server-scripts/single-droplet
./start.sh

#journalctl -n 40  -u treetracker-map-api.service
#journalctl -n 40  -u treetracker-mobile-api.service
#journalctl -n 40  -u treetracker-admin-api.service

systemctl status treetracker-map-api.service
systemctl status treetracker-mobile-api.service
systemctl status treetracker-admin-api.service
