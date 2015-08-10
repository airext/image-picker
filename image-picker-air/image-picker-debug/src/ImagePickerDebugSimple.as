/**
 * Created by Max Rozdobudko on 8/10/15.
 */
package
{
import com.github.airext.ImagePicker;
import com.github.airext.data.ImagePickerBrowseOptions;
import com.github.airext.events.ImagePickerEvent;

import flash.display.Sprite;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.geom.Rectangle;

public class ImagePickerDebugSimple extends Sprite
{
    public function ImagePickerDebugSimple()
    {
        super();

        new PlainButton(this, "browse", 0xFF0000, 0xFFFF00, {x: 100, y: 80, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
                var options:ImagePickerBrowseOptions = new ImagePickerBrowseOptions();
                options.video = false;
                options.image = true;
                options.origin = new Rectangle(0, 0, 0, 0);

                ImagePicker.sharedInstance().addEventListener(ImagePickerEvent.SELECT, function(e:Object){});
                ImagePicker.sharedInstance().addEventListener(ErrorEvent.ERROR, function(e:Object){});
                ImagePicker.sharedInstance().addEventListener(ImagePickerEvent.CANCEL, function(e:Object){});

                ImagePicker.sharedInstance().browse(options);
            }
        );
    }
}
}

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class PlainButton extends Sprite
{
    function PlainButton(parent:DisplayObjectContainer=null, label:String="", color:uint=0, textColor:uint=0xFFFFFF, properties:Object=null, clickHandler:Function=null)
    {
        super();

        _label = label;
        _color = color;
        _props = properties;

        textDisplay = new TextField();
        textDisplay.defaultTextFormat = new TextFormat("_sans", 24, textColor, null, null, null, null, null, TextFormatAlign.CENTER);
        textDisplay.selectable = false;
        textDisplay.autoSize = "center";
        addChild(textDisplay);

        x = _props.x || 0;
        y = _props.y || 0;

        if (parent)
            parent.addChild(this);

        if (clickHandler != null)
            addEventListener(MouseEvent.CLICK, clickHandler);

        sizeInvalid = true;
        labelInvalid = true;

        addEventListener(Event.ENTER_FRAME, renderHandler);
    }

    private var sizeInvalid:Boolean;
    private var labelInvalid:Boolean;

    private var _label:String;
    private var _color:uint;
    private var _props:Object;

    private var textDisplay:TextField;

    private function renderHandler(event:Event):void
    {
        if (labelInvalid)
        {
            labelInvalid = false;

            textDisplay.text = _label;
        }

        if (sizeInvalid)
        {
            sizeInvalid = false;

            var w:Number = _props.width || 0;
            var h:Number = _props.height || 0;

            graphics.clear();
            graphics.beginFill(_color);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();

            textDisplay.x = 0;
            textDisplay.width = w;
            textDisplay.y = (h - textDisplay.height) / 2;
        }
    }
}
