/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.data
{
import flash.geom.Rectangle;
import flash.media.CameraRollBrowseOptions;

public class ImagePickerBrowseOptions extends CameraRollBrowseOptions
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function ImagePickerBrowseOptions()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    override public function set origin(value:Rectangle):void
    {
        if (value == null)
        {
            value = new Rectangle(0, 0, 0, 0);

            trace("[ImagePicker] Warning: The origin could not be null.");
        }

        super.origin = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  image
    //-------------------------------------

    private var _image:Boolean = true;

    public function get image():Boolean
    {
        return _image;
    }

    public function set image(value:Boolean):void
    {
        _image = value;
    }

    //-------------------------------------
    //  video
    //-------------------------------------

    private var _video:Boolean = true;

    public function get video():Boolean
    {
        return _video;
    }

    public function set video(value:Boolean):void
    {
        _video = value;
    }
}
}
