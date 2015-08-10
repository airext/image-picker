/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/2/14
 * Time: 9:41 AM
 * To change this template use File | Settings | File Templates.
 */
package com.github.airext
{
import com.github.airext.core.image_picker;
import com.github.airext.data.Asset;
import com.github.airext.data.ImagePickerBrowseOptions;

import flash.events.EventDispatcher;

import flash.system.Capabilities;

use namespace image_picker;

[Event(name="select", type="com.github.airext.events.ImagePickerEvent")]

[Event(name="cancel", type="com.github.airext.events.ImagePickerEvent")]

[Event(name="status", type="flash.events.StatusEvent")]

[Event(name="error", type="flash.events.ErrorEvent")]

public class ImagePicker extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return false;
    }

    private static var instance:ImagePicker;

    public static function sharedInstance():ImagePicker
    {
        if (instance == null)
        {
            instance = new ImagePicker();
        }

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ImagePicker()
    {
        super()
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    public function get assets():Array
    {
        return null;
    }

    public function get asset():Asset
    {
        return null;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function browse(options:ImagePickerBrowseOptions=null):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    image_picker function getAsset(url:String):Asset
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return null;
    }
}
}
