package services {
import controllers.DataController;
import controllers.QuizController;

import data.OptusData;

public class OptusService {

    private static var _quizController:QuizController;
    private static var _dataController:DataController;

//    QUIZ
    public static function startQuiz(userData:Object):QuizController {
        if (!_quizController) {
            _quizController = new QuizController(OptusData.QUIZ_DATA)
        }

        if (!_dataController) {
            _dataController = new DataController(OptusData.TABLET_ID);
        }
        _dataController.saveUserData(userData);
        _quizController.start();
        return _quizController;
    }

    public static function quitQuiz():void {
        _dataController.addUserQuitted();
    }


    public static function getQuestionData():Object {
        return _quizController.getQuestion();
    }


    public static function saveUserAnswer(value:String):void {
        _quizController.saveUserAnswer(value);
    }


    public static function getNextQuizStep():String {

        if (_quizController.isLevelCompleted()) {

            if (_quizController.isQuizCompleted()) {

                _dataController.addLevelScored();
                _dataController.addQuizCompleted();
                _dataController.pushDataToServer();
                return OptusData.FINAL_QUIZ_SCREEN;

            }

            if (_quizController.isUserWinner()) {
                _dataController.addLevelScored();
                return OptusData.SUCCESS_LEVEL_SCREEN;

            } else {
                _dataController.pushDataToServer();
                return OptusData.FAIL_LEVEL_SCREEN;
            }

        }
        return OptusData.QUESTION_SCREEN;
    }


    public static function getCurrentLevelResults():Object {
        return _quizController.getNumberCorrectAnswers();
    }

    public static function getCurrentProgress():Object {
        return {
            currentQuestion: _quizController.quizQuestionCurrent,
            totalQuestions: _quizController.quizTotalQuestions
        }
    }
}
}
