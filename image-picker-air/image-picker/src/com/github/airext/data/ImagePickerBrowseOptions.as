/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.data
{
import flash.media.CameraRollBrowseOptions;

public class ImagePickerBrowseOptions extends CameraRollBrowseOptions
{
    public function ImagePickerBrowseOptions()
    {
        super();
    }

    public var image:Boolean = true;

    public var video:Boolean = true;
}
}
