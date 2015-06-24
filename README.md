image-picker ![License MIT](http://img.shields.io/badge/license-MIT-lightgray.svg)
===

![iOS](http://img.shields.io/badge/platform-ios-blue.svg) ![Android](http://img.shields.io/badge/platform-android-green.svg)

This is [AIR Native Extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) that extends standard CameraRoll available in AIR and adds next featuers:
 * support for video assets;
 * file-name for selected asset;
 * loading video asset into ByteArray;

## Usage

```as3
var options:ImagePickerBrowseOptions = new ImagePickerBrowseOptions();
options.video = true;
options.image = true;

ImagePicker.sharedInstance().addEventListener(ImagePickerEvent.SELECT, selectHandler);
ImagePicker.sharedInstance().addEventListener(ImagePickerEvent.CANCEL, cancelHandler);

ImagePicker.sharedInstance().browse(options);

...

private function selectHandler(event:ImagePickerEvent):void
{
  var asset:Asset = event.asset;
  
  // open associated input stream
  
  var input:AssetInput = asset.open();
  input.addEventListener(Event.OPEN, function openHandler (event:Event):void
  {
    input.removeEventListener(Event.OPEN, openHandler);
    
    // read available bytes
    
    var bytes:ByteArray = new ByteArray();
    input.readBytes(bytes);
  });
}

private function cancelHandler(event:ImagePickerEvent):void
{
  trace("cancel");
}
```

## Screenshots
