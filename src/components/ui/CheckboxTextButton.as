package components.ui {
import com.greensock.TweenMax;
import com.greensock.easing.Elastic;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class CheckboxTextButton extends Sprite {

    private var _labelTf:TextField;
    private var _isChecked:Boolean;

    private var _label:String;
    private var _value:String;
    private var _uncheckdBgImg:Bitmap;
    private var _checkImg:Bitmap;
    private var _fontName:String;
    private var _fontSize:Number;

    public function CheckboxTextButton(bkImg:Bitmap, checkImg:Bitmap) {
        _uncheckdBgImg = bkImg;
        _checkImg = checkImg;

        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
        super();
    }

    public function check():void {
        _isChecked = true;
        TweenMax.from(_checkImg, .4, {alpha: 0});
        TweenMax.from(this, .4, {scaleX: 1.5, ease: Elastic.easeOut.config(2, .5)});
        showHideCheck();
    }

    public function uncheck():void {
        disable();
        _isChecked = false;
        TweenMax.to(_checkImg, .4, {alpha: 0});
        showHideCheck();
    }

    public function set value(value:String):void {
        _value = value;
    }

    public function setLabel(label:String, x:uint = undefined, y:uint = undefined, color:Number = 0xffffff):void {
        if (!_label){
            _labelTf = addLabel(x, y, color);
            this.addChild(_labelTf);
        }
        _labelTf.text = label;
    }

    public function set font(fontName:String):void {
        _fontName = fontName;
    }

    public function set fontSize(size:uint):void {
        _fontSize = size;
    }

    public function get value():String {
        return _value;
    }

    public function get label():String {
        return _value;
    }

    public function disable():void {
//        this.removeEventListener(MouseEvent.MOUSE_DOWN, onCheck);
    }

    public function enable():void {
//        this.addEventListener(MouseEvent.MOUSE_DOWN, onCheck);
    }

    private function init():void {
        _isChecked = false;
        addCheckbox();
        enable();
    }

    private function addCheckbox():void {
        addChild(_uncheckdBgImg);
        addChild(_checkImg);
        showHideCheck();
    }

    private function addLabel(x:uint, y:uint, color:Number):TextField {
        var inputTextFormat:TextFormat = new TextFormat();
        inputTextFormat.size = _fontSize ? _fontSize : 32;
        inputTextFormat.font = _fontName ? _fontName : '';
        inputTextFormat.color = color;
        var tfLabel:TextField = new TextField();
        tfLabel.embedFonts = true;
        tfLabel.defaultTextFormat = inputTextFormat;
        tfLabel.autoSize = TextFieldAutoSize.LEFT;
        tfLabel.x = x;
        tfLabel.y = y;
        return tfLabel;
    }

    private function showHideCheck():void {
        _checkImg.visible = _isChecked;
    }

//    Event handler
    private function onAddedToStage(e:Event):void {
        init();
    }
}
}
