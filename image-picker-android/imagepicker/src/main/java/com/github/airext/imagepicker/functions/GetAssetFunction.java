package com.github.airext.imagepicker.functions;

import com.adobe.fre.*;
import com.github.airext.imagepicker.data.Asset;
import com.github.airext.imagepicker.helpers.ConversionRoutines;

/**
 * Created by Max Rozdobudko on 6/19/15.
 */
public class GetAssetFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] args)
    {
        if (args != null && args.length > 0)
        {
            try
            {
//                return Asset.retrieve(args[0].getAsString()).toFREObject();

                String path = args[0].getAsString();

                Asset asset = Asset.retrieve(path);

                return ConversionRoutines.convertAssetToFREObject(asset);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }

        return null;
    }
}
