package com.github.airext.imagepicker.functions;

import android.net.Uri;
import android.os.Binder;
import android.util.Log;
import com.adobe.fre.*;
import com.github.airext.ImagePicker;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * Created by Max Rozdobudko on 6/23/15.
 */
public class AssetInputOpenFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        String path = null;

        final long token = Binder.clearCallingIdentity();

        try
        {
            path = args[0].getAsString();

            if (!ImagePicker.streams.containsKey(path))
            {
                Uri uri = Uri.parse(path);

                FileInputStream stream = (FileInputStream) context.getActivity().getContentResolver().openInputStream(uri);

                Log.d("ImagePicker", "Input is " + stream);

                ImagePicker.streams.put(path, stream);
            }

            ImagePicker.dispatch("ImagePicker.AssetInput.Open.Success", path);
        }
        catch (Exception e)
        {
            e.printStackTrace();

            ImagePicker.dispatch("ImagePicker.AssetInput.Open.Failed", path);
        }
        finally
        {
            Binder.restoreCallingIdentity(token);
        }

        return null;
    }
}
