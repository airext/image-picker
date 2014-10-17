/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext
{
import com.github.airext.core.image_picker;
import com.github.airext.data.Asset;
import com.github.airext.data.ImagePickerBrowseOptions;
import com.github.airext.events.ImagePickerEvent;

import flash.events.ErrorEvent;

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.geom.Rectangle;
import flash.net.registerClassAlias;

use namespace image_picker;

[Event(name="select", type="com.github.airext.events.ImagePickerEvent")]

[Event(name="cancel", type="com.github.airext.events.ImagePickerEvent")]

[Event(name="status", type="flash.events.StatusEvent")]

[Event(name="error", type="flash.events.ErrorEvent")]

public class ImagePicker extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    image_picker static const EXTENSION_ID:String = "com.github.airext.ImagePicker";

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    private static var _context:ExtensionContext;

    image_picker static function get context():ExtensionContext
    {
        if (_context == null)
        {
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
        }

        return _context;
    }

    //--------------------------------------------------------------------------
    //
    //  Static initialization
    //
    //--------------------------------------------------------------------------

    {
        registerClassAlias("com.github.airext.data.Asset", Asset);
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return context != null && context.call("isSupported");
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

    private var _assets:Array;

    public function get assets():Array
    {
        return _assets;
    }

    private var _asset:Object;

    public function get asset():Object
    {
        return _asset;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  Methods: Public API
    //--------------------------------------

    public function browse(options:ImagePickerBrowseOptions=null):void
    {
        context.addEventListener(StatusEvent.STATUS, statusHandler);

        options = options || new ImagePickerBrowseOptions();
        options.origin = options.origin || new Rectangle(0, 0, 0, 0);

        context.call("browse", options);
    }

    //--------------------------------------
    //  Methods: Internal API
    //--------------------------------------

    image_picker function getAsset(url:String):Asset
    {
        return context.call("getAsset", url) as Asset;
    }

    //--------------------------------------
    //  Methods: Helpers
    //--------------------------------------

    private function dispatchErrorEvent(message:String):void
    {
        if (this.hasEventListener(ErrorEvent.ERROR))
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
        }
    }

    private function forwardStatusEvent(event:StatusEvent):void
    {
        if (this.hasEventListener(StatusEvent.STATUS))
        {
            dispatchEvent(event.clone());
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void
    {
        switch (event.code)
        {
            case "ImagePicker.Browse.Select" :

                context.removeEventListener(StatusEvent.STATUS, statusHandler);

                dispatchEvent(ImagePickerEvent.createSelectEvent(getAsset(event.level)));

                break;

            case "ImagePicker.Browse.Cancel" :

                context.removeEventListener(StatusEvent.STATUS, statusHandler);

                dispatchEvent(ImagePickerEvent.createCancelEvent());

                break;

            case "ImagePicker.Browse.Failed" :

                context.removeEventListener(StatusEvent.STATUS, statusHandler);

                dispatchErrorEvent(event.level);

                break;

            default :

                forwardStatusEvent(event);

                break;
        }
    }
}
}
