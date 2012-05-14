#!/bin/sh

set -e

export RAILS_ENV=production

rake db:reset

rake create:user EMAIL=tom@dxw.com PASSWORD=foobar
rake create:user EMAIL=harry@dxw.com PASSWORD=foobar
rake create:user EMAIL=lee@dxw.com PASSWORD=foobar
rake create:user EMAIL=peter.herlihy@digital.cabinet-office.gov.uk PASSWORD=gdsferretarmy

rake create:department NAME=BIS USERS=all
rake create:department NAME=FCO USERS=all

rake import:csv DEPARTMENT=1 CSV=../data/bis.csv
rake import:csv DEPARTMENT=2 CSV=../data/fco.csv

DATETIME=`date --rfc-3339=s | tr ' ' T`
SQL=../data/${DATETIME}_harvester.sql

mysqldump harvester > ${SQL}
xz ${SQL}
scp ${SQL}.xz harvester.staging.dxw.uk0.bigv.io:
