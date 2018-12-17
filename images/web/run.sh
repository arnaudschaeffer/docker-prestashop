#!/usr/bin/env bash

for file in /root/init/*.sh;
do
    $file;
done

apache2-foreground