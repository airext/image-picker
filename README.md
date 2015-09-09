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

/** Handles case when user select asset */
private function selectHandler(event:ImagePickerEvent):void
{
  this.asset = event.asset;
  
  // open associated input stream
  this.input = asset.open();
  
  // check if input stream is successfully opened
  if (input != null)
  {
    this.input.addEventListener(Event.OPEN, input_openHandler);
  }
  else
  {
    // failed open input stream
  }
}

/** Handler case when user cancels selection */
private function cancelHandler(event:ImagePickerEvent):void
{
  // cancelled by user
}

/** Handles input stream opening */
private function input_openHandler (event:Event):void
{
  input.removeEventListener(Event.OPEN, openHandler);
  
  // read available bytes
  var bytes:ByteArray = new ByteArray();
  input.readBytes(bytes);
  
  // close Asset's input stream when you done
  this.asset.close();
}

```

## Screenshots
TBD
