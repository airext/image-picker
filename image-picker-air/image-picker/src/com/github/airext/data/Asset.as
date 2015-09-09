/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.data
{
import com.github.airext.core.image_picker;
import com.github.airext.enum.AssetType;

use namespace image_picker;

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
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var input:AssetInput;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  url
    //-------------------------------------

    private var _url:String;

    public function get url():String
    {
        return _url;
    }

    public function set url(value:String):void
    {
        _url = value;
    }

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name:String;

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
    }

    //-------------------------------------
    //  type
    //-------------------------------------

    private var _type:String;

    public function get type():String
    {
        return AssetType.valid(_type) ? _type : AssetType.UNKNOWN;
    }

    public function set type(value:String):void
    {
        _type = value;
    }

    //-------------------------------------
    //  isAsync
    //-------------------------------------

    public function get isAsync():Boolean
    {
        return true;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function open():AssetInput
    {
        if (input == null)
        {
            input = new AssetInput();

            if (!input.open(_url))
            {
                input.close();
                input = null;
            }
        }

        return input;
    }

    public function close():void
    {
        if (input != null)
        {
            input.close();
            input = null;
        }
    }
}
}
