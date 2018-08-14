package controllers {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class QuizController extends EventDispatcher {

    private var _data:Object;
    private var _currentQuestionId:uint = 0;
    private var _levelQuestionId:uint = 0;
    private var _totalQuesionsPerLevel:uint = 5;

    public function QuizController(data:Object, target:IEventDispatcher = null) {
        _data = data;
        super(target);
    }

    public function start():void {
//      TODO gather random questions for every level and save them in 3 arrays
    }

    public function getQuestion():Object {
//      TODO fetch current question by saved index
        return {};
    }

    public function saveUserAnswer(id:uint):void {
//      TODO save user data and update question ID +1 (next question)
    }

    public function isUserWinner():Boolean {
        if (isLevelCompleted) {
            return areAllAnswersCorrect;
        }
        return false;
    }

    public function isUserLoser():Boolean {
        if (isLevelCompleted) {
            return !areAllAnswersCorrect;
        }
        return false;
    }

    private function isLevelCompleted():Boolean {
        return _currentQuestionId == _totalQuesionsPerLevel;
    }

    private function areAllAnswersCorrect():Boolean {
//        TODO check user answers
        return true;
    }

}
}
