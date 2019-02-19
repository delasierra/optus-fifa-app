package screens {
import assets.EmbedFonts;
import assets.EmbedImages;
import com.greensock.TweenMax;
import com.greensock.easing.Back;
import components.screenNavigator.ScreenNavigatorEvent;
import components.screenNavigator.ScreenModel;
import components.ui.CheckboxTextButton;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;
import controllers.AppController;
import services.UtilitiesService;

public class QuestionSceen extends ScreenModel {

    private var _questionTf:TextField;
    private var _answerBtns:Array;
    private var _aswerBtnsContainer:Sprite;
    private var _questionData:Object;

    private var _background:Bitmap;

    public function QuestionSceen() {
        super();
    }

    override protected function init():void {
        this.enable();
    }

    override public function enable():void {
        setScreen();
        this.visible = true;
    }

    override public function disable():void {
        this.visible = false;
    }

    //UI
    private function addBk():void {
        if (!_background) {
            _background = new EmbedImages.QUESTION_BG() as Bitmap;
            _background.alpha = 0;
            addChild(_background);
        }
        if (this.id != this.prevScreenId) {
            TweenMax.to(_background, 1, {alpha: 1});
        }
    }

    private function addQuestionField():void {
        if (!_questionTf) {
            var questionTextFormat:TextFormat = new TextFormat();
            questionTextFormat.size = 60;
            questionTextFormat.font = EmbedFonts.MACPRO_HEAVY;
            questionTextFormat.color = 0xffffff;
            questionTextFormat.align = 'center';

            _questionTf = new TextField();
            _questionTf.mouseEnabled = false;
            _questionTf.defaultTextFormat = questionTextFormat;
            _questionTf.embedFonts = true;
            _questionTf.multiline = true;
            _questionTf.wordWrap = true;
            _questionTf.width = 1310;
            _questionTf.height = 400;
            _questionTf.x = (stage.fullScreenWidth / 2) - (_questionTf.width / 2);
            _questionTf.y = 720;
            this.addChild(_questionTf);
        }
    }

    private function addAnswerBtns():void {
        if (!_answerBtns) {
            var answerX:Number = 0; //800;
            var shuffledAnswers:Array = UtilitiesService.randomShuffleArray(_questionData.answers);

            _aswerBtnsContainer = new Sprite();
            _answerBtns = [];

            for (var i:uint = 0; i < shuffledAnswers.length; i++) {
                var uncheckBg:Bitmap = new EmbedImages.QUESTION_UNCHECKED_BG() as Bitmap;
                var checkedBg:Bitmap = new EmbedImages.QUESTION_CHECKED_FULL() as Bitmap;
                var answer:CheckboxTextButton = new CheckboxTextButton(uncheckBg, checkedBg);
                answer.addEventListener(MouseEvent.CLICK, onUserAnswer);
                answer.font = EmbedFonts.MACPRO_MEDIUM;
                answer.fontSize = 44;
                answer.value = shuffledAnswers[i].value;
                answer.x = answerX;
                answer.y = 930 + (105 * i);
                answer.setLabel(shuffledAnswers[i].text, 100, 0);
                answer.enable();

//                Animation
                TweenMax.from(answer, .5 + ((i + 1) / 10), {
                    alpha: 0,
                    x: answer.x + 100,
                    ease: Back.easeOut.config(1.7),
                    delay: .2
                });

                _aswerBtnsContainer.addChild(answer);
                _answerBtns.push(answer);
            }
            this.addChild(_aswerBtnsContainer);
        }
    }

    private function disableAnswerBtns():void {
        for (var i:uint = 0; i < _answerBtns.length; i++) {
            var answer:CheckboxTextButton = _answerBtns[i] as CheckboxTextButton;
            answer.removeEventListener(MouseEvent.CLICK, onUserAnswer);
            answer.disable();
        }
    }

    private function setAnswers():void {
        _aswerBtnsContainer.x = (stage.fullScreenWidth / 2) - (_aswerBtnsContainer.width / 2);
    }

    private function setQuestion():void {
        _questionTf.text = _questionData.question;
        _questionTf.x = (stage.fullScreenWidth / 2) - (_questionTf.width / 2);
        _questionTf.alpha = 1;
        TweenMax.from(_questionTf, .7, {x: _questionTf.x + 200, alpha: 0, ease: Back.easeOut.config(1.7)});
    }

    private function setScreen():void {
        resetScreen();
        _questionData = AppController.getQuestionData();
        addBk();
        addQuestionField();
        setQuestion();
        addAnswerBtns();
        setAnswers();
    }

    private function resetScreen():void {
        if (_aswerBtnsContainer) {
            for (var i:uint = 0; i < _answerBtns.length; i++) {
                _aswerBtnsContainer.removeChild(_answerBtns[i]);
            }
            this.removeChild(_aswerBtnsContainer);
            _aswerBtnsContainer = null;
            _answerBtns = null;
            _questionTf.text = '';
        }
    }

//    Event handlers
    private function onUserAnswer(e:MouseEvent):void {
        var answer:CheckboxTextButton = e.currentTarget as CheckboxTextButton;
        answer.check();
        disableAnswerBtns();
        var checkDelayTimer:Timer = new Timer(500, 1);
        checkDelayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onCheckDelay);
        AppController.saveUserAnswer(e.currentTarget.value);
        checkDelayTimer.start()
    }

    private function onCheckDelay(te:TimerEvent):void {

        this.nextScreenId = AppController.getNextQuizStep();

        var timer:Timer = te.currentTarget as Timer;
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onCheckDelay);
        timer.stop();

//        Animation
        if (this.nextScreenId != this.id) {
            TweenMax.to(_background, .5, {alpha: 0});
        }
        TweenMax.to(_aswerBtnsContainer, .5, {x: _aswerBtnsContainer.x - 200, ease: Back.easeIn.config(1.3)});
        TweenMax.to(_aswerBtnsContainer, .5, {alpha: 0});
        TweenMax.to(_questionTf, .5, {alpha: 0});
        TweenMax.to(_questionTf, .5, {x: _questionTf.x - 300, onComplete: showNextStep, ease: Back.easeIn.config(1.3)});
    }

    private function showNextStep():void {
        dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.NEXT_SCREEN));
    }
}
}
