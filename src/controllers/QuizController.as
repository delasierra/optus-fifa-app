package controllers {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import services.UtilitiesService;

public class QuizController extends EventDispatcher {

    private var _data:Array;
    private var _questionCurrent:uint;
    private var _quesionsTotalPerLevel:uint;
    private var _levelCurrent:uint;
    private var _levelsTotal:uint;
    private var _quizQuestions:Array;
    private var _userAnswers:Array;

    public function QuizController(data:Array, target:IEventDispatcher = null) {
        _data = data;
        super(target);
    }

    public function get quizQuestionCurrent():uint {
        return (_quesionsTotalPerLevel * _levelCurrent) + _questionCurrent + 1;
    }

    public function get quizTotalQuestions():uint {
        return _quesionsTotalPerLevel * _levelsTotal;
    }

    public function start():void {
        _userAnswers = [];
        _levelsTotal = _data.length;
        _quesionsTotalPerLevel = 5;
        _levelCurrent = 0;
        _questionCurrent = 0;
        _quizQuestions = createQuizQuestions(_data);
    }


    public function getQuestion():Object {
        if (isLevelCompleted()) {
            _levelCurrent++;
            _questionCurrent = 0;
            _userAnswers = [];
        }
        return _quizQuestions[_levelCurrent][_questionCurrent];
    }


    public function saveUserAnswer(value:String):void {
        _questionCurrent++;
        _userAnswers.push(value);
    }

    public function isUserWinner():Boolean {
        return areAllAnswersCorrect();
    }

    public function getNumberCorrectAnswers():uint {
        var nAnswers:uint = 0;
        for (var i:uint = 0; i < _userAnswers.length; i++) {
            if (_userAnswers[i] == 'true') {
                nAnswers++
            }
        }
        return nAnswers;
    }


//    Controller methods
    private function createQuizQuestions(data:Array):Array {
        var quizQuestions:Array = [];
        for (var i:uint = 0; i < data.length; i++) {
            quizQuestions.push(getLevelQuestions(data[i]))
        }
        return quizQuestions;
    }


    private function getLevelQuestions(allQuesions:Array):Array {
        var aq:Array = allQuesions.slice();
        var levelQuestions:Array = [];
        var rn:uint;

        for (var i:uint = 0; i < _quesionsTotalPerLevel; i++) {
            rn = UtilitiesService.getRandomNumber(0, aq.length - 1);
            levelQuestions[i] = aq.splice(rn, 1)[0];
        }
        return levelQuestions;
    }

//    Checkers
    public function isLevelCompleted():Boolean {
        return _questionCurrent >= _quesionsTotalPerLevel;
    }

    private function areAllAnswersCorrect():Boolean {
        trace('[areAllAnswersCorrec]', getNumberCorrectAnswers(), _quesionsTotalPerLevel);
        return getNumberCorrectAnswers() == _quesionsTotalPerLevel;
    }

    public function isQuizCompleted():Boolean {
        return _questionCurrent == _quesionsTotalPerLevel && _levelCurrent == _levelsTotal - 1;
    }
}
}
