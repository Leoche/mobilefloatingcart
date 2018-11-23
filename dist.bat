@echo off
echo mobilefloatingcart :

echo removing dist...
rmdir /s /q dist

echo removing mobilefloatingcart.zip...
del mobilefloatingcart.zip

echo creating dist...
mkdir dist

echo creating dist\mobilefloatingcart...
mkdir dist\mobilefloatingcart

echo copying controllers...
robocopy controllers dist\mobilefloatingcart\controllers /e

echo copying img...
robocopy img dist\mobilefloatingcart\img /e

echo copying views...
robocopy views dist\mobilefloatingcart\views /e

echo copying config.xml...
copy config.xml dist\mobilefloatingcart\config.xml

echo copying index.php...
copy index.php dist\mobilefloatingcart\index.php

echo copying logo.png...
copy logo.png dist\mobilefloatingcart\logo.png

echo copying mobilefloatingcart.php...
copy mobilefloatingcart.php dist\mobilefloatingcart\mobilefloatingcart.php

echo copying mobilefloatingcart.tpl...
copy mobilefloatingcart.tpl dist\mobilefloatingcart\mobilefloatingcart.tpl

echo copying mobilefloatingcart-content.tpl...
copy mobilefloatingcart-content.tpl dist\mobilefloatingcart\mobilefloatingcart-content.tpl

echo copying README.md...
copy README.md dist\mobilefloatingcart\README.md

echo copying services.yml...
copy services.yml dist\mobilefloatingcart\services.yml


echo cleaning template.html...
del dist\mobilefloatingcart\views\templates\template.html


echo zipping...
cd dist/
7z a -r ../mobilefloatingcart.zip *

echo cleaning dist...
cd ..
rmdir /s /q dist

echo FINISHH
pause