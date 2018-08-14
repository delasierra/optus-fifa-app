package screens {
import components.screenNavigator.EventsNavigation;
import components.screenNavigator.ScreenModel;

import services.OptusService;

public class QuestionSceen extends ScreenModel {
    public function QuestionSceen() {
        super();
    }

    override protected function init():void {
        trace('QuestionSceen');
    }

    private function onUserAnswer():void {
//        TODO get eventNavigation type from OptusService
        dispatchEvent(new EventsNavigation(OptusService.getNextQuizStep()));
    }

}
}
