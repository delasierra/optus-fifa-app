package screens {
import assets.EmbedFonts;
import assets.EmbedImages;
import com.greensock.TweenMax;
import components.screenNavigator.ScreenNavigatorEvent;
import components.screenNavigator.ScreenModel;
import components.ui.Button;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import services.OptusService;

public class SuccessLevelScreen extends ScreenModel {

    private var _msgTf:TextField;
    private var _background:Bitmap;
    private var _bgImg:Bitmap;

    public function SuccessLevelScreen() {
        super();
    }

//    Super methods
    override protected function init():void {
        addBakground();
        addUiImage();
        addQuestionField();
        addButton();
        this.enable();
    }

    override public function enable():void {
        this.alpha = 0;
        _msgTf.text = 'You got all ' + OptusService.getCurrentLevelResults() + ' questions correct';
        TweenMax.to (this, .5, {alpha: 1});
        this.visible = true;
    }

    override public function disable():void {
        _msgTf.text = '';
        this.visible = false;
    }

//  UI
    private function addUiImage():void {
        if (!_bgImg) {
            _bgImg = new EmbedImages.SUCCESS_SCREEN_BG() as Bitmap;
            this.addChild(_bgImg);
        }
    }

    private function addBakground():void {
        if (!_background) {
            _background = new EmbedImages.BACKGROND() as Bitmap;
            addChild(_background);
        }
    }

//    Actions

    private function addButton():void {
        var nextStepBtn:Button;
        nextStepBtn = new Button(776, 96);
        nextStepBtn.addEventListener(MouseEvent.CLICK, onClick);
        nextStepBtn.x = 633;
        nextStepBtn.y = 890;
        this.addChild(nextStepBtn);
    }

    private function addQuestionField():void {
        var questionTextFormat:TextFormat = new TextFormat();
        questionTextFormat.size = 60;
        questionTextFormat.font = EmbedFonts.MACPRO_REGULAR;
        questionTextFormat.color = 0xffffff;
        questionTextFormat.align = 'center';

        _msgTf = new TextField();
        _msgTf.defaultTextFormat = questionTextFormat;
        _msgTf.embedFonts = true;
        _msgTf.multiline = true;
        _msgTf.wordWrap = true;
        _msgTf.width = 1600;
        _msgTf.height = 400;
        _msgTf.x = (stage.fullScreenWidth / 2) - (_msgTf.width / 2);
        _msgTf.y = 770;
        this.addChild(_msgTf);
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