#!/bin/bash
clear
mkdir -p ./tmp
cd ./tmp
rsync -av $1 .
rsync -av . $2
cd ..
rm -rf ./tmp