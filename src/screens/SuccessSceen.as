package screens {
import components.screenNavigator.EventsNavigation;
import components.screenNavigator.ScreenModel;

import data.OptusData;

public class SuccessSceen extends ScreenModel {
    public function SuccessSceen() {
        super();
    }

    private function fail():void {
        nextScreenId = OptusData.FAIL_SCREEN;
        dispatchEvent(new EventsNavigation(EventsNavigation.NEXT_SCREEN));
    }

    private function success():void {
//        e.currentTarget.stop();
//        e.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeUp);
//        nextScreenId = WinstonData.SUCCESS;
//        dispatchEvent(new EventsNavigation(EventsNavigation.NEXT_SCREEN));
//        disable();
    }
}
}
