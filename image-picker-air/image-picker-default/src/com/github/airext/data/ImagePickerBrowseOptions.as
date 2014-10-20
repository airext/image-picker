/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.data
{
import flash.media.CameraRollBrowseOptions;
import flash.system.Capabilities;

public class ImagePickerBrowseOptions extends CameraRollBrowseOptions
{
    public function ImagePickerBrowseOptions()
    {
        super();
    }

    public function get image():Boolean
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return false;
    }

    public function set image(value:Boolean):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }

    public function get video():Boolean
    {
        trace("ImagePicker is not supported for " + Capabilities.os);

        return false;
    }

    public function set video(value:Boolean):void
    {
        trace("ImagePicker is not supported for " + Capabilities.os);
    }
}
}
