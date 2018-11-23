#!/bin/bash
echo mobilefloatingcart :

echo removing dist...
rm -rf dist

echo removing mobilefloatingcart.zip...
rm mobilefloatingcart.zip

echo creating dist...
mkdir dist

echo creating dist/mobilefloatingcart...
mkdir dist/mobilefloatingcart

echo copying controllers...
cp -r controllers dist/mobilefloatingcart/controllers

echo copying img...
cp -r img dist/mobilefloatingcart/img

echo copying views...
cp -r views dist/mobilefloatingcart/views

echo copying config.xml...
cp config.xml dist/mobilefloatingcart/config.xml

echo copying index.php...
cp index.php dist/mobilefloatingcart/index.php

echo copying logo.png...
cp logo.png dist/mobilefloatingcart/logo.png

echo copying mobilefloatingcart.php...
cp mobilefloatingcart.php dist/mobilefloatingcart/mobilefloatingcart.php

echo copying mobilefloatingcart.tpl...
cp mobilefloatingcart.tpl dist/mobilefloatingcart/mobilefloatingcart.tpl

echo copying mobilefloatingcart-content.tpl...
cp mobilefloatingcart-content.tpl dist/mobilefloatingcart/mobilefloatingcart-content.tpl

echo copying README.md...
cp README.md dist/mobilefloatingcart/README.md

echo copying services.yml...
cp services.yml dist/mobilefloatingcart/services.yml


echo cleaning template.html...
rm dist/mobilefloatingcart/views/templates/template.html

echo zipping...
cd dist/
zip -r ../mobilefloatingcart.zip *


echo cleaning dist...
rm -rf dist

echo FINISHH