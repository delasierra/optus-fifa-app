package components.ui {
import assets.EmbedImages;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Checkbox extends Sprite{

    private var _btn:Button;
    private var _check:Bitmap;
    private var _checked:Boolean;

    public function Checkbox() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
        super();

    }

    public function get isChecked():Boolean {
        return _checked;
    }

    public function uncheck():void {
        _checked = _check.visible = false;
    }

    public function check():void {
        _checked = _check.visible = true;
    }

    private function init():void {
        _checked = false;
        addBtn();
        addCheckedImg();
    }

    private function addBtn():void {
        _btn = new Button(232, 50);
        this.addChild(_btn);
        _btn.addEventListener(MouseEvent.CLICK, onCheck);
    }

    private function addCheckedImg():void {
        _check = new EmbedImages.CHECK() as Bitmap;
        _check.visible = _checked;
        addChild(_check);
    }

    private function onAddedToStage(e:Event):void {
        init();
    }

    private function onCheck(e:MouseEvent):void {
        _checked = !_checked;
        _check.visible = _checked;
    }
}
}

