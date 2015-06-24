package com.github.airext.imagepicker.functions;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.imagepicker.activities.ImagePickerActivity;
import com.github.airext.imagepicker.data.ImagePickerBrowseOptions;
import com.github.airext.imagepicker.helpers.ConversionRoutines;

import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/18/15.
 */
public class BrowseFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] args)
    {
        Log.i("ImagePicker", "BrowseFunction");

        ImagePickerBrowseOptions options = ConversionRoutines.convertFREObjectToImagePickerBrowseOptions(args.length > 0 ? args[0] : null);

        try
        {
            Activity activity = freContext.getActivity();

            Intent intent = new Intent(activity.getApplicationContext(), ImagePickerActivity.class);

            if (options.image)
            {
                intent.putExtra(ImagePickerActivity.EXTRA_MIME_TYPE, "image/*");
            }

            if (options.video)
            {
                intent.putExtra(ImagePickerActivity.EXTRA_MIME_TYPE, "video/*");
            }

            activity.startActivity(intent);
        }
        catch (Exception error)
        {
            error.printStackTrace();
        }

        return null;
    }
}
