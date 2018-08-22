package services {
import com.jonas.net.Multipart;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;

public class ApiCallsService extends EventDispatcher{

    private var _serverUrl:String = 'https://www.optussportfifachallenge.com/backend/action.php';

    public function ApiCallsService() {

    }

    public function send(tabletId:String, udata:Object, quizData:Object):void {
        var form:Multipart = new Multipart(_serverUrl);
        //add fields
        form.addField('tabletId', tabletId);
        form.addField('name', udata.name);
        form.addField('dob', udata.dob);
        form.addField('mobile', udata.mobile);
        form.addField('email', udata.email);
        form.addField('terms', udata.terms);
        form.addField('promo', udata.promo);

        form.addField('levels_scored', quizData.levelsScored);
        form.addField('quiz_completed', quizData.quizCompleted);
        form.addField('user_quitted', quizData.userQuitted);

        form.addField('date', udata.date);

        var loader:URLLoader = new URLLoader();
        loader.load(form.request);

        try {
            configureListeners(loader);
            loader.load(form.request);
        } catch (error:Error) {
            trace("[ApiCallsService] Error requesting data");
        }
    }

    private function response(e:Event):void {
        var json:Object = JSON.parse(e.currentTarget.data);

        if (json.status.toUpperCase() == "OK") {
            dispatchEvent(new Event(Event.COMPLETE));
        } else {
            trace("[ApiCallsService] Error: data could not been sent from PHP:" + json.msg);
            dispatchEvent(new Event(Event.CANCEL));
        }
    }

    //listeners
    private function configureListeners(dispatcher:IEventDispatcher):void {
        dispatcher.addEventListener(Event.COMPLETE, response);
        dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    }

    //handlers
    private function ioErrorHandler(e:Event):void {
        trace("[ApiCallsService] Error: No server connection");
        dispatchEvent(new Event(Event.CANCEL));
    }

    private function securityErrorHandler(e:Event):void {
        trace("[ApiCallsService] Security error");
        dispatchEvent(new Event(Event.CANCEL));
    }
}
}
