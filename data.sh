#!/bin/sh

set -e

export RAILS_ENV=production

rake db:reset

rake create:user EMAIL=tom@dxw.com PASSWORD=foobar
rake create:user EMAIL=harry@dxw.com PASSWORD=foobar
rake create:user EMAIL=lee@dxw.com PASSWORD=foobar
rake create:user EMAIL=peter.herlihy@digital.cabinet-office.gov.uk PASSWORD=gdsferretarmy

rake create:department NAME=BIS  USERS=all
rake create:department NAME=FCO  USERS=all
rake create:department NAME=MOD  USERS=all
rake create:department NAME=DCLG USERS=all

rake import:csv DEPARTMENT=BIS  CSV='../data/prod-data/BIS.gov.uk URLs - To harvest.csv' --trace
rake import:csv DEPARTMENT=DCLG CSV='../data/prod-data/DCLG Planning and Regen URLs for Harvester - 02 June 2012 - HARVEST.csv'
rake import:csv DEPARTMENT=DCLG CSV='../data/prod-data/DCLG URLs for Harvester - 8 June 2012 -  DCLG to harvest.csv'
rake import:csv DEPARTMENT=FCO  CSV='../data/prod-data/urls fco final - HARVEST.csv'
rake import:csv DEPARTMENT=MOD  CSV='../data/prod-data/urls mod final - HARVEST.csv'

DATETIME=`date --rfc-3339=s | tr ' ' T`
SQL=../data/${DATETIME}_harvester.sql

mysqldump harvester > ${SQL}
xz ${SQL}
