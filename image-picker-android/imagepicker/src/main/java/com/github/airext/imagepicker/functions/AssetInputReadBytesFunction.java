package com.github.airext.imagepicker.functions;

import android.util.Log;
import com.adobe.fre.FREByteArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.ImagePicker;

import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

/**
 * Created by Max Rozdobudko on 6/23/15.
 */
public class AssetInputReadBytesFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        String path = null;

        try
        {
            path = args[0].getAsString();

            if (ImagePicker.streams.containsKey(path))
            {
                FREByteArray array = (FREByteArray) args[1];
                int offset = args[2].getAsInt();
                int desiredLength = args[3].getAsInt();

                FileInputStream stream = ImagePicker.streams.get(path);

                int actualLength = Math.min(desiredLength, (int) (stream.getChannel().size() - stream.getChannel().position()));

                byte[] bytes = new byte[actualLength];

                stream.read(bytes, offset, actualLength);

                array.setProperty("length", FREObject.newObject(actualLength));

                array.acquire();

                ByteBuffer buffer = array.getBytes();
                buffer.put(bytes);

                array.release();
            }
            else
            {
                ImagePicker.dispatch("ImagePicker.AssetInput.NotAvailable", path);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            ImagePicker.dispatch("ImagePicker.AssetInput.ReadBytes.Failed", path);
        }

        return null;
    }
}
