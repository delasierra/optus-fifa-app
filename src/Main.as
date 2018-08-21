package {

import assets.EmbedImages;

import components.ProgressBar;

import components.screenNavigator.ScreenNavigatorEvent;

import components.screenNavigator.ScreenNavigator;
import components.ui.Button;

import data.OptusData;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

import screens.FinalQuizScreen;

import screens.FormScreen;
import screens.FailLevelScreen;
import screens.PopupMsgScroll;
import screens.QuestionSceen;
import screens.SuccessLevelScreen;

import services.OptusService;

[SWF(frameRate="60", backgroundColor="0x000000")]

public class Main extends Sprite {

    private var _homeBtn:Button;
    private var _screenNavigator:ScreenNavigator;
    private var _progressbar:ProgressBar;

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
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

    private function addScreens():void {
        _screenNavigator = new ScreenNavigator(OptusData.FORM_SCREEN, null, null, OptusData.LEGAL_POPUP_SCREEN);
        _screenNavigator.addEventListener(ScreenNavigatorEvent.SCREEN_CHANGED, onScreenChanges)
        _screenNavigator.addScreen(FormScreen, OptusData.FORM_SCREEN, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(QuestionSceen, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(FailLevelScreen, OptusData.FAIL_LEVEL_SCREEN, OptusData.FORM_SCREEN);
        _screenNavigator.addScreen(SuccessLevelScreen, OptusData.SUCCESS_LEVEL_SCREEN, OptusData.QUESTION_SCREEN);
        _screenNavigator.addScreen(FinalQuizScreen, OptusData.FINAL_QUIZ_SCREEN, OptusData.FORM_SCREEN);
        _screenNavigator.addScreen(PopupMsgScroll, OptusData.LEGAL_POPUP_SCREEN);
//        _screenNavigator.setBackground(EmbedImages.BACKGROND);
        this.addChild(_screenNavigator);
    }

    private function addProgressbar():void {
        _progressbar = new ProgressBar();
        _progressbar.x = 0;
        _progressbar.y = 1414;
        this.addChild(_progressbar);
    }


    private function addHomeBtn():void {
        var optusLogo:Bitmap = new EmbedImages.OPTUS_LOGO() as Bitmap;
        _homeBtn = new Button(210, 145, null, optusLogo);
        _homeBtn.addEventListener(MouseEvent.CLICK, onClickHomeBtn);
        _homeBtn.x = 51;
        _homeBtn.y = 115;
        this.addChild(_homeBtn);
    }

//events handlers
    private function onAddedToStage(e:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stageSetUp();
        addScreens();
        addHomeBtn();
        addProgressbar();
        _screenNavigator.showHome();
    }

    private function onClickHomeBtn(e:MouseEvent):void {

//        if (e.currentTarget.getCurrentScreenId() != OptusData.FORM_SCREEN) {
        if (_screenNavigator.getCurrentScreenId() != OptusData.FORM_SCREEN) {
            dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.CLOSE_POPUP));
            OptusService.quitQuiz();
            _screenNavigator.showHome();
        }
    }

    private function onScreenChanges(e:ScreenNavigatorEvent):void {
        if (e.currentTarget.getCurrentScreenId() == OptusData.QUESTION_SCREEN) {
            _progressbar.update(
                    OptusService.getCurrentProgress().currentQuestion,
                    OptusService.getCurrentProgress().totalQuestions
            );
        } else {
            _progressbar.hide();
        }
    }
}
}