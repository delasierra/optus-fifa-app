package {

import components.screenNavigator.ScreenNavigator;

import data.OptusData;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;

import screens.FormScreen;

//[SWF(frameRate="60", backgroundColor="0x000000")]

public class Main extends Sprite {

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function checkTabletId():void {
//        Service.localDB().addEventListener(EventsWinston.RESPONSE, onResponse);
//        Service.localDB().addEventListener(EventsWinston.ERROR, onNotFound);
//        Service.localDB().read(OptusData.CONFIG_TABLE);
    }

    private function addScreens(isTabletConfig:Boolean):void {
        var screenNavigator:ScreenNavigator;
        screenNavigator = new ScreenNavigator(OptusData.FORM_SCREEN, null, null, OptusData.LEGAL_POPUP_SCREEN);
        screenNavigator.addScreen(FormScreen, OptusData.FORM_SCREEN, OptusData.SUCCESS_SCREEN);
//        screenNavigator.addScreen(Intro, OptusData.INTRO, OptusData.GAME);
//        screenNavigator.addScreen(Game, OptusData.GAME, OptusData.SUCCESS);
//        screenNavigator.addScreen(Fail, OptusData.FAIL, OptusData.HOME);
//        screenNavigator.addScreen(Success, OptusData.SUCCESS, OptusData.FORM);
//        screenNavigator.addScreen(FormScreen, OptusData.FORM);
//        screenNavigator.addScreen(Admin, OptusData.ADMIN);
//        screenNavigator.addScreen(Config, OptusData.CONFIG, OptusData.HOME);
//        screenNavigator.addScreen(Legal, OptusData.POPUP_LEGAL);
//        screenNavigator.addScreen(Popup, OptusData.POPUP_GENERIC);
        this.addChild(screenNavigator);

//        if (isTabletConfig) {
        screenNavigator.showHome();
//        } else {
//            screenNavigator.showConfig();
//        }
    }

    private function stageSetUp():void {
        stage.allowsFullScreenInteractive;
        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;


        var screenWidth:int = stage.fullScreenWidth;
        var screenHeight:int = stage.fullScreenHeight;
        trace(screenWidth, screenHeight);
//        init();
    }

//events handlers
    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stageSetUp();
        checkTabletId();
    }

//    private function onResponse(e:EventsWinston):void {
//        Service.localDB().removeEventListener(EventsWinston.RESPONSE, onResponse);
//        Service.localDB().removeEventListener(EventsWinston.ERROR, onNotFound);
//        var result:SQLResult = e.data as SQLResult;
//        if (result.data && result.data[0].tabletId) {
//            OptusData.TABLE_ID = result.data[0].tabletId;
//            addScreens(true);
//        } else {
//            addScreens(false);
//        }
//    }

//    private function onNotFound(e:EventsWinston):void {
//        Service.localDB().removeEventListener(EventsWinston.RESPONSE, onResponse);
//        Service.localDB().removeEventListener(EventsWinston.ERROR, onNotFound);
//        addScreens(false);
//    }
}
}