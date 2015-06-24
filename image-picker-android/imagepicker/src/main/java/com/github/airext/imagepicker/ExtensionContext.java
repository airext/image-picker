package com.github.airext.imagepicker;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.github.airext.imagepicker.functions.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/18/15.
 */
public class ExtensionContext extends FREContext
{
    @Override
    public Map<String, FREFunction> getFunctions()
    {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("isSupported", new IsSupportedFunction());
        functions.put("browse", new BrowseFunction());
        functions.put("getAsset", new GetAssetFunction());

        functions.put("assetInputOpen", new AssetInputOpenFunction());
        functions.put("assetInputClose", new AssetInputCloseFunction());
        functions.put("assetInputGetSize", new AssetInputGetSizeFunction());
        functions.put("assetInputReadBytes", new AssetInputReadBytesFunction());

        return functions;
    }

    @Override
    public void dispose()
    {

    }
}
