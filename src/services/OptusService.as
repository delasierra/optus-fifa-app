package services {
import controllers.DataController;
import controllers.QuizController;

import data.OptusData;

import services.ApiCallsService;

public class OptusService {

    private static var _quizController:QuizController;
    private static var _dataController:DataController;


//    USER DATA
//    private static function saveUserData(userData:Object):void {
//        trace('[OptusService] User data:', userData.name, userData.email, userData.dob, userData.mobile);
//        _userdata = userData;
//    }


//    QUIZ
    public static function startQuiz(userData:Object):QuizController {
        if (!_quizController) {
            _quizController = new QuizController(OptusData.QUIZ_DATA)
        }

        if(!_dataController){
            _dataController = new DataController();
        }
        _dataController.saveUserData(userData);
        _dataController.pushDataToServer(); //TODO this line only for debug
        _quizController.start();
        return _quizController;
    }

    public static function quitQuiz():void {
//        TODO send user data on DB
//        TODO got back to form page (intro)
    }


    public static function getQuestionData():Object {
        return _quizController.getQuestion();
    }


    public static function saveUserAnswer(value:String):void {
        _quizController.saveUserAnswer(value);
    }


    public static function getNextQuizStep():String {
        if (_quizController.isQuizCompleted()) {
            //        TODO save user data on DB
            return OptusData.FINAL_QUIZ_SCREEN;
        }

        if (_quizController.isLevelCompleted()) {
            if (_quizController.isUserWinner()) {
                return OptusData.SUCCESS_LEVEL_SCREEN;
            } else {
                //        TODO save user data on DB
                return OptusData.FAIL_LEVEL_SCREEN;
            }
        }
        return OptusData.QUESTION_SCREEN;
    }


    public static function getCurrentLevelResults():Object {
        return _quizController.getNumberCorrectAnswers();
    }


    public static function getLevelResults(levelId:uint):void {

    }


    public static function getQuizResults():void {

    }
}
}
