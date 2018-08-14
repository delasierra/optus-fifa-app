package components.screenNavigator {
import flash.display.Sprite;
import flash.events.Event;

public class ScreenModel extends Sprite {

    private var _data:Object;
    private var _nextScreenId:String;
    private var _prevScreenId:String;

    private var _id:String;
    private var _index:uint;
    private var _loaded:Boolean;

    public function ScreenModel() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
    }

    //getters and setters
    public function get nextScreenId():String {
        return _nextScreenId;
    }

    public function set nextScreenId(value:String):void {
        _nextScreenId = value;
    }

    public function get prevScreenId():String {
        return _prevScreenId;
    }

    public function set prevScreenId(value:String):void {
        _prevScreenId = value;
    }

    public function get loaded():Boolean {
        return _loaded;
    }

    public function set loaded(value:Boolean):void {
        _loaded = value;
    }

    public function get id():String {
        return _id;
    }

    public function set id(value:String):void {
        _id = value;
    }

    public function get index():uint {
        return _index;
    }

    public function set index(value:uint):void {
        _index = value;
    }

    public function get data():Object {
        return _data;
    }

    public function set data(value:Object):void {
        _data = value;
    }

    //methods
    protected function init():void {
    }

    //public functions
    public function enable():void {

    }

    public function disable():void {

    }

    public function popUpClosed(popupId:String):void {

    }

    public function dispose():void {
//        this.dispose();
        while (this.numChildren > 0) {
            this.removeChildAt(0);
        }
    }

    //Event handlers
    protected function onAddedToStage(e:Event = null):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        init();
    }
}
}