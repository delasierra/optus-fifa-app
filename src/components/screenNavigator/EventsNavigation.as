package components.screenNavigator {
import flash.events.Event;

public class EventsNavigation extends Event {

    public static const READY:String = "ready";
    //screen navigator
    public static const NEXT_SCREEN:String = "next_screen";
    public static const PREV_SCREEN:String = "prev_screen";
    public static const POPUP:String = "popup";
    public static const CLOSE_POPUP:String = "closePopup";
    public static const HOME:String = "home";
    public static const ADMIN:String = "admin";

    public var data:Object;

    public function EventsNavigation(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
        this.data = data;
    }

    // always create a clone() method for events in case you want to redispatch them.
    public override function clone():Event {
        return new EventsNavigation(type, data, bubbles, cancelable);
    }
}
}
