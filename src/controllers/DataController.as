package controllers {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import services.ApiCallsService;

public class DataController extends EventDispatcher {

    private var _userData:Object;
    private var _quizData:Object;
    private var _iPadId:String;

    private var _apiCallsService:ApiCallsService;

    public function DataController(tabletId:String, target:IEventDispatcher = null):void {
        _iPadId = tabletId;
        resetData();
        super(target);
    }

    public function saveUserData(userData:Object):void {
        _userData = userData;
    }

    public function pushDataToServer():void {
        if (_iPadId && _userData && _quizData) {
            _apiCallsService.send(_iPadId, _userData, _quizData);
        }
        resetData();
    }

    public function addLevelScored():void {
        _quizData.levelsScored++;
        trace('[CURRENT LEVEL]', _quizData.levelsScored + 1);
    }

    public function addQuizCompleted():void {
        _quizData.quizCompleted = 1;
    }

    public function addUserQuitted():void {
        _quizData.userQuitted = 1;
        pushDataToServer();
    }

    private function resetData():void {
        if (!_apiCallsService) {
            _apiCallsService = new ApiCallsService();
        }
        _userData = null;
        _quizData = {
            levelsScored: 0,
            quizCompleted: 0,
            userQuitted: 0
        };
    }
}
}
