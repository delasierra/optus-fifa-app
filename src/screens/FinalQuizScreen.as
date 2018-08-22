package screens {
import assets.EmbedImages;
import com.greensock.TweenMax;
import components.screenNavigator.ScreenNavigatorEvent;
import components.screenNavigator.ScreenModel;
import components.ui.Button;
import flash.display.Bitmap;
import flash.events.MouseEvent;

public class FinalQuizScreen extends ScreenModel {

    private var _bgImg:Bitmap;
    private var _background:Bitmap;

    public function FinalQuizScreen() {
        super();
    }

//    Super methods
    override protected function init():void {
        addBakground();
        addUiImage();
        addButton();
        this.enable();
    }

    override public function enable():void {
        this.alpha = 0;
        TweenMax.to (this, .5, {alpha: 1});
        this.visible = true;
    }

    private function addUiImage():void {
        if (!_bgImg) {
            _bgImg = new EmbedImages.FINAL_QUIZ_SCREEN_BG() as Bitmap;
            this.addChild(_bgImg);
        }
    }

    private function addBakground():void {
        if (!_background) {
            _background = new EmbedImages.BACKGROND() as Bitmap;
            addChild(_background);
        }
    }

    private function addButton():void {
        var nextStepBtn:Button;
        nextStepBtn = new Button(776, 96);
        nextStepBtn.addEventListener(MouseEvent.CLICK, onClick);
        nextStepBtn.x = 633;
        nextStepBtn.y = 1010;
        this.addChild(nextStepBtn);
    }

//    Handlers
    private function onClick(e:MouseEvent):void {
        TweenMax.to (this, .5, {alpha: 0, onComplete:showNextStep});
    }

    private function showNextStep():void {
        dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.NEXT_SCREEN));
    }
}
}
