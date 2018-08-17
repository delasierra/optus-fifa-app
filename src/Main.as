package {

import assets.EmbedImages;

import components.screenNavigator.EventsNavigation;

import components.screenNavigator.ScreenNavigator;
import components.ui.Button;

import data.OptusData;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import screens.FinalQuizScreen;

import screens.FormScreen;
import screens.FailLevelScreen;
import screens.PopupMsgScroll;
import screens.QuestionSceen;
import screens.SuccessLevelScreen;

[SWF(frameRate="60", backgroundColor="0x000000")]

public class Main extends Sprite {

    private var _homeBtn:Button;
    private var _screenNavigator:ScreenNavigator;

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function addScreens():void {
        _screenNavigator = new ScreenNavigator(OptusData.FORM_SCREEN, null, null, OptusData.LEGAL_POPUP_SCREEN);
        _screenNavigator.addScreen(FormScreen, OptusData.FORM_SCREEN, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(QuestionSceen, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(FailLevelScreen, OptusData.FAIL_LEVEL_SCREEN, OptusData.FORM_SCREEN);
        _screenNavigator.addScreen(SuccessLevelScreen, OptusData.SUCCESS_LEVEL_SCREEN, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(FinalQuizScreen, OptusData.FINAL_QUIZ_SCREEN, OptusData.FORM_SCREEN);
        _screenNavigator.addScreen(PopupMsgScroll, OptusData.LEGAL_POPUP_SCREEN);

        _screenNavigator.setBackground(EmbedImages.BACKGROND);
        this.addChild(_screenNavigator);

//        if (isTabletConfig) {
        _screenNavigator.showHome();
//        _screenNavigator.showScreen(OptusData.QUESTION_SCREEN);
//        } else {
//            _screenNavigator.showConfig();
//        }
    }

    private function stageSetUp():void {
        stage.allowsFullScreenInteractive;
        stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

//        var screenWidth:int = stage.fullScreenWidth;
//        var screenHeight:int = stage.fullScreenHeight;
//        trace('screenWidth', screenWidth, 'screenHeight', screenHeight);
//        init();
    }

    private function addHomeBtn():void {
        _homeBtn = new Button(220, 153);
        _homeBtn.addEventListener(MouseEvent.CLICK, onClickHomeBtn);
        _homeBtn.x = 51;
        _homeBtn.y = 115;
        _homeBtn.setLabel("HOME");
        this.addChild(_homeBtn);
    }

//events handlers
    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stageSetUp();
        addScreens();
        addHomeBtn();
    }

    private function onClickHomeBtn(e:MouseEvent):void {
        dispatchEvent(new EventsNavigation(EventsNavigation.CLOSE_POPUP));
        _screenNavigator.showHome();
    }

//    private function scrollTEst():void {
//        var tf:TextFormat = new TextFormat();
//        tf.font = "Arial";
//        tf.align = TextFormatAlign.LEFT;
//        tf.size = 16;
//        tf.bold = false;
//        tf.color = 0x000000;
//
//        var ta:TextArea = new TextArea();
//        ta.setStyle("textFormat", tf);
//        ta.wordWrap = true;
//        ta.horizontalScrollPolicy = ScrollPolicy.OFF;
//        ta.verticalScrollPolicy = (BookPlayerConfig.platform != Platform.iOS) ? ScrollPolicy.ON : ScrollPolicy.OFF;
//        ta.maxChars = 1024;
//        ta.addEventListener(Event.CHANGE, validateSaveButton, false, 0, true);
//        ta.addEventListener(FocusEvent.FOCUS_IN, onFocus, false, 0, true);
//    }
}
}