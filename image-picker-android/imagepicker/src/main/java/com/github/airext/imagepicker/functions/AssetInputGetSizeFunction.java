package com.github.airext.imagepicker.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.ImagePicker;

import java.io.FileInputStream;
import java.io.InputStream;

/**
 * Created by Max Rozdobudko on 6/23/15.
 */
public class AssetInputGetSizeFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        try
        {
            String path = args[0].getAsString();

            if (ImagePicker.streams.containsKey(path))
            {
                FileInputStream stream = ImagePicker.streams.get(path);

                return FREObject.newObject(stream.getChannel().size());
            }
            else
            {
                ImagePicker.dispatch("ImagePicker.AssetInput.NotAvailable", path);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            ImagePicker.dispatchError(e.getMessage());
        }

        return null;
    }
}
