package data {
public class OptusData {

//  Tablet Id
    public static const TABLET_ID:String = 'black';

//  Screens Id
    public static const FORM_SCREEN:String = 'form_screen';
    public static const LEGAL_POPUP_SCREEN:String = 'legal_screen';
    public static const QUESTION_SCREEN:String = 'question_screen';
    public static const SUCCESS_LEVEL_SCREEN:String = 'success_screen';
    public static const FAIL_LEVEL_SCREEN:String = 'fail_screen';
    public static const FINAL_QUIZ_SCREEN:String = 'final_screen';

//    Quiz data
    public static const QUIZ_DATA:Array = [
        QuizLevel1Data.DATA,
        QuizLevel2Data.DATA,
        QuizLevel3Data.DATA,
        QuizLevel4Data.DATA
    ]
}
}
