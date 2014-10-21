image-picker ![License MIT](http://img.shields.io/badge/license-MIT-lightgray.svg)
===

![iOS](http://img.shields.io/badge/platform-ios-blue.svg)

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
  
  var input:AssetInput = asset.open();
  input.addEventListener(Event.OPEN, function openHandler (event:Event):void
  {
    input.removeEventListener(Event.OPEN, openHandler);
    
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
