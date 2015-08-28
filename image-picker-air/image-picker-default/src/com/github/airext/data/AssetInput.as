/**
 * Created by mobitile on 10/7/14.
 */
package com.github.airext.data
{
import com.github.airext.core.image_picker;

import flash.events.EventDispatcher;
import flash.system.Capabilities;
import flash.utils.ByteArray;

use namespace image_picker;

public class AssetInput extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function AssetInput()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    public function get bytesAvailable():uint
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return 0;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    image_picker function open(url:String):Boolean
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return false;
    }

    image_picker function close():void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }
}
}
