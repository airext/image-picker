#!/bin/bash

cp -R ../image-picker-air/image-picker-debug/bin-debug/ImagePickerDebug-app.xml launch/ImagePickerDebug-app.xml
cp -R ../image-picker-air/image-picker-debug/bin-debug/ImagePickerDebug.swf launch/ImagePickerDebug.swf

adt -package -target ipa-debug-interpreter -provisioning-profile $IOS_PROVISION -storetype pkcs12 -keystore $IOS_CERTIFICATE -storepass $IOS_CERTIFICATE_STOREPASS launch/ImagePickerDebug.ipa launch/ImagePickerDebug-app.xml -C launch ImagePickerDebug.swf -extdir launch/ext -platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/