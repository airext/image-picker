package com.github.airext.imagepicker.functions;

import android.net.Uri;
import com.adobe.fre.*;
import com.github.airext.ImagePicker;

import java.io.*;

/**
 * Created by Max Rozdobudko on 6/23/15.
 */
public class AssetInputOpenFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        ImagePicker.log("AssetInputOpenFunction");

        String path = null;

//        final long token = Binder.clearCallingIdentity();

        try
        {
            path = args[0].getAsString();

            if (!ImagePicker.streams.containsKey(path))
            {
                Uri uri = Uri.parse(path);

                FileInputStream stream = (FileInputStream) context.getActivity().getContentResolver().openInputStream(uri);

                if (stream != null)
                {
                    ImagePicker.streams.put(path, stream);

                    ImagePicker.dispatch("ImagePicker.AssetInput.Open.Success", path);

                    return FREObject.newObject(true);
                }
                else
                {
                    ImagePicker.dispatch("ImagePicker.AssetInput.Open.Failed", path);
                }
            }
            else
            {
                ImagePicker.dispatch("ImagePicker.AssetInput.Open.Success", path);

                return FREObject.newObject(true);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            ImagePicker.dispatch("ImagePicker.AssetInput.Open.Failed", path);
        }
        finally
        {
//            Binder.restoreCallingIdentity(token);
        }

        return null;
    }
}
