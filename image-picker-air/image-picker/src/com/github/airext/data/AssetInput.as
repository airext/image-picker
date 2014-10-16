/**
 * Created by mobitile on 10/7/14.
 */
package com.github.airext.data
{
import com.github.airext.ImagePicker;
import com.github.airext.core.image_picker;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.utils.ByteArray;

use namespace image_picker;

[Event(name="open", type="flash.events.Event")]

[Event(name="status", type="flash.events.StatusEvent")]

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
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var url:String;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  bytesAvailable
    //-------------------------------------

    private var bytesAvailableRead:Boolean = false;

    private var _bytesAvailable:uint;

    public function get bytesAvailable():uint
    {
        if (!bytesAvailableRead)
        {
            _bytesAvailable = ImagePicker.context.call("assetInputGetSize", url) as uint;

            bytesAvailableRead = true;
        }

        return _bytesAvailable;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void
    {
        ImagePicker.context.call("assetInputReadBytes", this.url, bytes, offset, length);
    }

    image_picker function open(url:String):void
    {
        this.url = url;

        ImagePicker.context.addEventListener(StatusEvent.STATUS, statusHandler);

        ImagePicker.context.call("assetInputOpen", this.url);
    }

    image_picker function close():void
    {
        ImagePicker.context.removeEventListener(StatusEvent.STATUS, statusHandler);

        ImagePicker.context.call("assetInputClose", this.url);
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void
    {
        if (event.level == this.url)
        {
            switch (event.code)
            {
                case "ImagePicker.AssetInput.Open.Success" :

                    dispatchEvent(new Event(Event.OPEN));

                    break;

                case "ImagePicker.AssetInput.Open.Failed" :

                    dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "ImagePicker.AssetInput.Open.Failed", "error"));

                    break;

                case "ImagePicker.AssetInput.NotAvailable" :

                    dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "ImagePicker.AssetInput.NotAvailable", "error"));

                    break;
            }
        }
    }
}
}
