#!/bin/bash

chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

nginx -g 'daemon off;'