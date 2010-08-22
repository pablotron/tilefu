#!/bin/sh

d="/home/pabs/sites/tilefu.com"

ssh k2 hg up -v -R $d/hg '&&' touch $d/tmp/restart.txt
