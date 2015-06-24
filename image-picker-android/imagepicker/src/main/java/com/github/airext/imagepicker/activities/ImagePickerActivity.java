package com.github.airext.imagepicker.activities;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import com.github.airext.ImagePicker;
import com.github.airext.imagepicker.data.Asset;
import com.github.airext.imagepicker.helpers.ConversionRoutines;

import java.io.File;
import java.net.URLDecoder;
import java.nio.charset.Charset;

/**
 * Created by Max Rozdobudko on 6/18/15.
 */
public class ImagePickerActivity extends Activity
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static final String EXTRA_MIME_TYPE = "com.github.airext.imagepicker.MimeType";

    public static final int PICK_ASSET_REQUEST_CODE = 1001;

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        Intent intent = new Intent(Intent.ACTION_PICK);

        Bundle extras = getIntent().getExtras();

        if (extras != null && extras.containsKey(EXTRA_MIME_TYPE))
        {
            intent.setType(extras.getString(EXTRA_MIME_TYPE));
        }
        else
        {
            intent.setType("image/*");
        }

        if (intent.resolveActivity(getPackageManager()) != null)
        {
            startActivityForResult(intent, PICK_ASSET_REQUEST_CODE);
        }
    }

    @Override
    protected void onStart()
    {
        super.onStart();

        ImagePicker.dispatchStatus("ImagePicker.Open");
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent)
    {
        super.onActivityResult(requestCode, resultCode, intent);

        if (requestCode == PICK_ASSET_REQUEST_CODE)
        {
            switch (resultCode)
            {
                case RESULT_OK :

                    final Uri uri = getStreamExtra((Uri) intent.getData());

                    String path = ConversionRoutines.convertUriToPath(getApplicationContext(), uri);

                    ContentResolver resolver = getContentResolver();

                    String mimeType = resolver.getType(uri);

                    String type = null;

                    if (mimeType.contains("image"))
                    {
                        type = "photo";
                    }
                    else if (mimeType.contains("video"))
                    {
                        type = "video";
                    }
                    else
                    {
                        type = "unknown";
                    }

                    Asset asset = Asset.preserve(uri.toString(), new File(path).getName(), type);

                    ImagePicker.dispatch("ImagePicker.Browse.Select", asset.getPath());

                    break;

                case RESULT_CANCELED :

                    ImagePicker.dispatchStatus("ImagePicker.Browse.Cancel");

                    break;
            }
        }

        finish();
    }

    private Uri getStreamExtra(Uri streamUri)
    {
        try
        {
            if (streamUri.getAuthority().equals("com.google.android.apps.photos.contentprovider") && streamUri.toString().endsWith("/ACTUAL"))
            {
                String[] parts = streamUri.toString().split("/");

                if (parts.length > 3)
                {
                    return Uri.parse(URLDecoder.decode(parts[parts.length - 2], Charset.defaultCharset().name()));
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return streamUri;
    }
}
