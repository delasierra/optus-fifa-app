package services {
import controllers.QuizController;

import data.OptusData;

public class OptusService {

    private static var _quizController:QuizController;

    public static function startQuiz():QuizController {
//    TODO call after user click on form button (save user data in AS3)
        if (!_quizController) {
            _quizController = new QuizController(OptusData.QUIZ_DATA)
        }
        _quizController.start();
        return _quizController;
    }

    public static function quitQuiz():void {
//        TODO save user daat on DB
//        TODO got back to form page (intro)
    }

    public static function getQuestion():Object {
//        TODO Simple call made from question page
//        TODO login to load right question handdle by controller
        return _quizController.getQuestion();
    }

    public static function saveUserAnswer(id:uint):void {
        _quizController.saveUserAnswer(id);
    }

    public static function getNextQuizStep():String {
        if (_quizController.isUserWinner) {
            return OptusData.SUCCESS_SCREEN;
        } else if (_quizController.isUserLoser) {
            return OptusData.FAIL_SCREEN;
        }
        return OptusData.QUESTION_SCREEN;
    }

    public static function getLevelResults(levelId:uint):void {

    }

    public static function getQuizResults():void {

    }

    public static function pushDataToServer():void {

    }
}
}
