#!/bin/bash
git clone https://github.com/srgazh/vestacp_nginx_hotlinking.git
cp vestacp_nginx_hotlinking/hotlinking.* /usr/local/vesta/data/templates/web/nginx/
rm -rf vestacp_nginx_hotlinking
rm newtpl.sh
