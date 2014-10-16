/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.data
{
import flash.system.Capabilities;

public class Asset
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Asset()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  url
    //-------------------------------------

    public function get url():String
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return null;
    }

    public function set url(value:String):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    //-------------------------------------
    //  name
    //-------------------------------------

    public function get name():String
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return null;
    }

    public function set name(value:String):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    //-------------------------------------
    //  type
    //-------------------------------------

    public function get type():String
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return null;
    }

    public function set type(value:String):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    //-------------------------------------
    //  isAsync
    //-------------------------------------

    public function get isAsync():Boolean
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return false;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function open():AssetInput
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return null;
    }

    public function close():void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }
}
}
