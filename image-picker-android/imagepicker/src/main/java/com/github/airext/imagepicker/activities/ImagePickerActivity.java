package com.github.airext.imagepicker.activities;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.os.ParcelFileDescriptor;
import android.provider.OpenableColumns;
import com.adobe.fre.FREContext;
import com.github.airext.ImagePicker;
import com.github.airext.imagepicker.data.Asset;
import com.github.airext.imagepicker.helpers.ConversionRoutines;

import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

                    final Uri uri = intent.getData();

                    String path = uri.toString();

                    String type = retrieveType(uri);

                    String name = retrieveName(uri);

                    Asset asset = Asset.preserve(path, name, type);

                    try
                    {
                        FileInputStream stream = (FileInputStream) getContentResolver().openInputStream(uri);

                        ImagePicker.streams.put(path, stream);
                    }
                    catch (FileNotFoundException e)
                    {
                        e.printStackTrace();

                        ImagePicker.log("Stream could not be opened");
                    }

                    ImagePicker.dispatch("ImagePicker.Browse.Select", asset.getPath());

                    break;

                case RESULT_CANCELED :

                    ImagePicker.dispatchStatus("ImagePicker.Browse.Cancel");

                    break;
            }
        }

        finish();
    }

    private String retrieveType(Uri uri)
    {
        String mimeType = getContentResolver().getType(uri);

        String type = "unknown";

        if (mimeType.contains("image"))
        {
            type = "photo";
        }
        else if (mimeType.contains("video"))
        {
            type = "video";
        }

        return  type;
    }

    private String retrieveName(Uri uri)
    {
        try
        {
            Cursor cursor = getContentResolver().query(uri, null, null, null, null);

            cursor.moveToFirst();

            int nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);

            return cursor.getString(nameIndex);
        }
        catch (Exception e)
        {
            e.printStackTrace();

            ImagePicker.log(e.toString());

            return null;
        }
    }
}
