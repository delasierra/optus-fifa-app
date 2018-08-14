/**
 * Created by Carlos de la Sierra on 8/2/17.
 */
package components.screenNavigator {
import flash.display.Bitmap;
import flash.display.Sprite;

public class ScreenNavigator extends Sprite {

    private var _screens:Array = [];
    private var _homeScreenId:String;
    private var _adminScreenId:String;
    private var _configScreenId:String;
    private var _activeScreenId:String;
    private var _popupId:String;
    private var _activePopupId:String;

    public function ScreenNavigator(homeId:String = null, adminId:String = null, configId:String = null, popupId:String = null) {
        _homeScreenId = homeId;
        _adminScreenId = adminId;
        _configScreenId = configId;
        _popupId = popupId;
    }

//    Config
    public function getScreen(id:String):ScreenModel {
        for (var i:uint = 0; i < _screens.length; i++) {
            if (_screens[i].id == id) {
                return _screens[i];
            }
        }
        trace("[ScreenNavigator] ERROR: ScreenModel id does not exist");
        return null;
    }

    public function setBackground(embedImageClass: Class):void {
        var bk:Bitmap = new embedImageClass as Bitmap;
        addChild(bk);
    }

    public function addScreen(screenType:Class, id:String, nextScreenId:String = null):void {
//    public function addScreen(screenType:Class, id:String, nextScreenId:String = null, controller: * = null):void {
        var screen:ScreenModel = new screenType();
        screen.addEventListener(EventsNavigation.HOME, showHome);
        screen.addEventListener(EventsNavigation.ADMIN, showAdmin);
        screen.addEventListener(EventsNavigation.NEXT_SCREEN, showNextScreen);
        screen.addEventListener(EventsNavigation.PREV_SCREEN, showPrevScreen);
        screen.addEventListener(EventsNavigation.POPUP, showPopup);
        screen.addEventListener(EventsNavigation.CLOSE_POPUP, onClosePopup);
        screen.nextScreenId = nextScreenId;
        screen.id = id;
        screen.index = _screens.length;
        screen.loaded = false;
//        screen.controller = controller;
        _screens[screen.index] = screen;
    }


    public function removeScreen(id:String):void {
        if (id) {
            getScreen(id).disable();
//            this.removeChild(getScreen(id));
        }
    }

//    Action
    public function showScreen(id:String, prevId:String = null, data:Object = null):void {
        //remove current screen
        removeScreen(_activeScreenId);
        //show new screen
        var newScreen:ScreenModel = getScreen(id);
        if (newScreen && !newScreen.loaded) {
            this.addChild(newScreen);
            newScreen.loaded = true;
        } else if (newScreen.loaded) {
            newScreen.enable();
        }
        if (prevId) {
            newScreen.prevScreenId = prevId;
        }
        if (data) {
            newScreen.data = data;
        }
        _activeScreenId = id;
        this.setChildIndex(newScreen, this.numChildren - 1);
    }

    public function showHome(e:EventsNavigation = null):void {
        if (_homeScreenId) {
            showScreen(_homeScreenId);
//            onClosePopup();
        } else {
            trace("[ScreenNavigator] ERROR: there is no HOME screen configured");
        }
    }

    public function showAdmin(e:EventsNavigation = null):void {
        if (_adminScreenId) {
            showScreen(_adminScreenId);
        } else {
            trace("[ScreenNavigator] ERROR: there is no ADMIN screen configured");
        }
    }

    public function showConfig(e:EventsNavigation = null):void {
        if (_configScreenId) {
            showScreen(_configScreenId);
        } else {
            trace("[ScreenNavigator] ERROR: there is no CONFIG screen configured");
        }
    }

    public function showPopup(e:EventsNavigation):void {
        var popup:ScreenModel;
        popup = e.data.popupId ? getScreen(e.data.popupId) : getScreen(_popupId);
        popup.addEventListener(EventsNavigation.CLOSE_POPUP, onClosePopup);

        if (popup && !popup.loaded) {
            popup.data = e.data;
            this.addChild(popup);
            popup.loaded = true;

        } else if (popup.loaded) {
            popup.data = e.data;
            popup.enable();
        }
        _activePopupId = popup.id;
        this.setChildIndex(popup, this.numChildren - 1);
    }

    //Event handlers
    private function showNextScreen(e:EventsNavigation):void {
        var prevId:String = e.target.id;
        showScreen(e.target.nextScreenId, prevId, e.target.data);
    }

    private function showPrevScreen(e:EventsNavigation):void {
        showScreen(e.target.prevScreenId, e.target.data);
    }

    private function onClosePopup(e:EventsNavigation = null):void {
        if (_activePopupId) {
            getScreen(_activePopupId).removeEventListener(EventsNavigation.CLOSE_POPUP, onClosePopup);
            getScreen(_activeScreenId).popUpClosed(_activePopupId);
            removeScreen(_activePopupId);
        }
    }
}
}
