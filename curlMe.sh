#!/bin/sh
curl -o -I -L -s -w "%{http_code}" http://www.google.com