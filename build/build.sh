#!/bin/bash

unzip -o image-picker.swc

unzip -o default/image-picker-default.swc -d default

adt -package -storetype pkcs12 -keystore ~/certs/rozd.p12 -storepass vopli -target ane image-picker.ane extension.xml -swc image-picker.swc -platform iPhone-ARM library.swf libImagePicker.a -platformoptions platform.xml -platform default -C default library.swf

cp -R image-picker.ane ../image-picker-air/image-picker-debug/ane/image-picker.ane

cp -R image-picker.ane ../bin/image-picker.ane

mkdir -p launch/ext
cp -R image-picker.ane launch/ext/image-picker.ane
unzip -o launch/ext/image-picker.ane -d launch/ext

rm library.swf
rm catalog.xml

rm default/library.swf
rm default/catalog.xml