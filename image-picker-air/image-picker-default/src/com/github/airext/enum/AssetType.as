/**
 * Created by mobitile on 10/1/14.
 */
package com.github.airext.enum
{
public class AssetType
{
    public static const PHOTO:String = "photo";

    public static const VIDEO:String = "video";

    public static const UNKNOWN:String = "unknown";

    private static const VALID_TYPES:Array = [PHOTO, VIDEO];

    public static function valid(type:String):Boolean
    {
        return VALID_TYPES.indexOf(type) != -1;
    }
}
}
