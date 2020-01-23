#!/bin/bash
set -x

[ ! -f server.crt ] && 
  openssl req -new > new.cert.csr  && 
  openssl rsa -in privkey.pem -out new.cert.key && 
  openssl x509 -in new.cert.csr -out new.cert.cert -req -signkey new.cert.key -days 999 &&
  mv new.cert.cert server.crt &&
  mv new.cert.key  server.key || 
     rm -f new.ssl.csr privkey.pem new.cert.*

