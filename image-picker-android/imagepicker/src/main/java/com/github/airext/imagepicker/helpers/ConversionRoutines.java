package com.github.airext.imagepicker.helpers;

import android.content.Context;
import android.database.Cursor;
import android.graphics.Rect;
import android.net.Uri;
import android.provider.MediaStore;
import com.adobe.fre.*;
import com.github.airext.imagepicker.data.Asset;
import com.github.airext.imagepicker.data.ImagePickerBrowseOptions;

/**
 * Created by Max Rozdobudko on 6/18/15.
 */
public class ConversionRoutines
{
    public static ImagePickerBrowseOptions convertFREObjectToImagePickerBrowseOptions(FREObject object)
    {
        ImagePickerBrowseOptions options = new ImagePickerBrowseOptions();

        // origin

        options.origin = new Rect();

        try
        {
            FREObject origin = object.getProperty("origin");

            options.origin.left = origin.getProperty("left").getAsInt();
            options.origin.top = origin.getProperty("top").getAsInt();
            options.origin.right = origin.getProperty("right").getAsInt();
            options.origin.bottom = origin.getProperty("bottom").getAsInt();
        }
        catch (Exception e) {}

        // width

        try
        {
            options.width = object.getProperty("width").getAsDouble();
        }
        catch (Exception e) {}

        // height

        try
        {
            options.height = object.getProperty("height").getAsDouble();
        }
        catch (Exception e) {}

        // image

        try
        {
            options.image = object.getProperty("image").getAsBool();
        }
        catch (Exception e) {}

        // video

        try
        {
            options.video = object.getProperty("video").getAsBool();
        }
        catch (Exception e) {}

        return options;
    }

    public static FREObject convertAssetToFREObject(Asset asset) throws FREASErrorException, FREInvalidObjectException, FREWrongThreadException, FRENoSuchNameException, FRETypeMismatchException, FREReadOnlyException
    {
        FREObject result = FREObject.newObject("com.github.airext.data.Asset", null);
        result.setProperty("url", FREObject.newObject(asset.getPath()));
        result.setProperty("name", FREObject.newObject(asset.getName()));
        result.setProperty("type", FREObject.newObject(asset.getType()));

        return result;
    }

    public static String convertUriToPath(Context context, Uri uri)
    {
        Cursor cursor = null;

        try
        {
            String[] projection = { MediaStore.Images.Media.DATA };

            cursor = context.getContentResolver().query(uri,  projection, null, null, null);

            int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);

            cursor.moveToFirst();

            return cursor.getString(column_index);
        }
        finally
        {
            if (cursor != null) {
                cursor.close();
            }
        }
    }
}
