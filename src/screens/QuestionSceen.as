package screens {
import assets.EmbedFonts;
import assets.EmbedImages;

import components.screenNavigator.EventsNavigation;
import components.screenNavigator.ScreenModel;
import components.ui.CheckboxTextButton;

import flash.display.Bitmap;
import flash.events.MouseEvent;

import flash.text.TextField;
import flash.text.TextFormat;

import services.OptusService;

public class QuestionSceen extends ScreenModel {

    private var _questionTf:TextField;
    private var _answerBtns:Array;
    private var _questionData:Object;

    public function QuestionSceen() {
        super();
    }

    override protected function init():void {
        addQuestionField();
        this.enable();
//        addAnswerBtns();
    }

    override public function enable():void {
        setScreen();
        this.visible = true;
    }

    override public function disable():void {
        resetScreen();
        this.visible = false;
    }

    private function addQuestionField():void {
        var questionTextFormat:TextFormat = new TextFormat();
        questionTextFormat.size = 60;
        questionTextFormat.font = EmbedFonts.MACPRO_HEAVY;
        questionTextFormat.color = 0xffffff;
        questionTextFormat.align = 'center';

        _questionTf = new TextField();
//        _questionTf.type = TextFieldType.DYNAMIC;
        _questionTf.mouseEnabled = false;
        _questionTf.defaultTextFormat = questionTextFormat;
        _questionTf.embedFonts = true;
        _questionTf.multiline = true;
        _questionTf.wordWrap = true;
        _questionTf.width = 1200;
        _questionTf.height = 400;
        _questionTf.x = (stage.fullScreenWidth / 2) - (_questionTf.width / 2);
        _questionTf.y = 720;
//        tfInput.border = 1;
        this.addChild(_questionTf);
    }

    private function addAnswerBtns():void {
        if (!_answerBtns) {
            _answerBtns = [];
            var answerX:Number = 800;

            for (var i:uint = 0; i < _questionData.answers.length; i++) {
                var uncheckBg:Bitmap = new EmbedImages.QUESTION_UNCHECKED_BG() as Bitmap;
                var checkedBg:Bitmap = new EmbedImages.QUESTION_CHECKED_FULL() as Bitmap;
                var answer:CheckboxTextButton = new CheckboxTextButton(776, 85, uncheckBg, checkedBg);
                answer.addEventListener(MouseEvent.CLICK, onUserAnswer);

                answer.font = EmbedFonts.MACPRO_MEDIUM;
                answer.fontSize = 44;
                answer.value = _questionData.answers[i].value;
                answer.x = answerX;
                answer.y = 927.5 + (100 * i);
                answer.setLabel(_questionData.answers[i].text, 600, 80, 100, 0);

                this.addChild(answer);
                _answerBtns.push(answer);
            }
        }

    }

    private function setScreen():void {
        _questionData = OptusService.getQuestionData();
        _questionTf.text = _questionData.question;
        addAnswerBtns();
//        addQuestionField();
    }

    private function resetScreen():void {
        for (var i:uint = 0; i < _answerBtns.length; i++) {
            this.removeChild(_answerBtns[i]);
        }
        _answerBtns = null;
        _questionTf.text = '';
    }

//    Event handlers
    private function onUserAnswer(e:MouseEvent):void {
        //        TODO animate and delete page
        OptusService.saveUserAnswer(e.currentTarget.value);
        this.nextScreenId = OptusService.getNextQuizStep();

        dispatchEvent(new EventsNavigation(EventsNavigation.NEXT_SCREEN));
    }
}
}
