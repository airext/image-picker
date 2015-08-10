/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.events
{
import com.github.airext.core.image_picker;
import com.github.airext.data.Asset;

import flash.events.Event;

use namespace image_picker;

public class ImagePickerEvent extends Event
{
    public static const SELECT:String = "select";

    public static const CANCEL:String = "cancel";

    image_picker static function createSelectEvent(asset:Asset):ImagePickerEvent
    {
        return new ImagePickerEvent(SELECT, false, false, asset);
    }

    image_picker static function createCancelEvent():ImagePickerEvent
    {
        return new ImagePickerEvent(CANCEL);
    }

    public function ImagePickerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, asset:Asset = null)
    {
        super(type, bubbles, cancelable);

        _asset = asset;
    }

    private var _asset:Asset;

    public function get asset():Asset
    {
        return _asset;
    }
}
}
