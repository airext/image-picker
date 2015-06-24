package com.github.airext.imagepicker.data;

import android.support.annotation.Nullable;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/24/15.
 */
public class Asset
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static final Map<String, Asset> assets = new HashMap<String, Asset>();

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static Asset preserve(String path, String name, String type)
    {
        if (assets.containsKey(path))
        {
            return assets.get(path);
        }
        else
        {
            Asset asset = new Asset(path, name, type);

            assets.put(path, asset);

            return asset;
        }
    }

    @Nullable
    public static Asset retrieve(String path)
    {
        if (assets.containsKey(path))
        {
            return assets.remove(path);
        }
        else
        {
            return null;
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public Asset(String path, String name, String type)
    {
        this.path = path;

        this.name = name;

        this.type = type;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //--------------------------------------
    //  path
    //--------------------------------------

    private String path;

    public String getPath()
    {
        return path;
    }

    //--------------------------------------
    //  name
    //--------------------------------------

    private String name;

    public String getName()
    {
        return name;
    }

    //--------------------------------------
    //  type
    //--------------------------------------

    private String type;

    public String getType()
    {
        return type;
    }
}
