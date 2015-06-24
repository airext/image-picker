package com.github.airext;

import android.content.ContentResolver;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.github.airext.imagepicker.ExtensionContext;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/18/15.
 */
public class ImagePicker implements FREExtension
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    private static FREContext context;

    public static final Map<String, FileInputStream> streams = new HashMap<String, FileInputStream>();

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static void dispatch(String code, String level)
    {
        context.dispatchStatusEventAsync(code, level);
    }

    public static void dispatchStatus(String code)
    {
        dispatch(code, "status");
    }

    public static void dispatchError(String code)
    {
        dispatch(code, "error");
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Methods: FREExtension
    //-------------------------------------

    @Override
    public void initialize()
    {
        Log.i("ImagePicker", "initialize()");
    }

    @Override
    public FREContext createContext(String s)
    {
        Log.i("ImagePicker", "createContext()");

        context = new ExtensionContext();

        return context;
    }

    @Override
    public void dispose()
    {
        Log.i("ImagePicker", "dispose()");
    }

}
