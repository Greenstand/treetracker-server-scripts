#!/bin/bash
systemctl stop treetracker-admin-api
cd treetracker-admin-api
cd server
npm i
npm run-script clean
npm run-script build
cd ../
cd client
npm i
npm run-script build
\rm -Rf /var/www/admin/*
cp -Rp build/* /var/www/admin/
cd ../../
systemctl start treetracker-admin-api
