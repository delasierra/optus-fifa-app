package screens {
import assets.EmbedFonts;
import assets.EmbedImages;
import components.screenNavigator.ScreenNavigatorEvent;
import components.screenNavigator.ScreenModel;
import components.ui.Button;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

public class PopupMsgScroll extends ScreenModel {

    private var _btn:Button;
    private var _msgTf:TextField;

    public function PopupMsgScroll() {
        super();
    }

    override protected function init():void {
        addBk();
        addMsg();
        addBtn();
        enable();
    }

    override public function enable():void {
            _btn.addEventListener(MouseEvent.CLICK, onClick);
            _btn.alpha = 1;
//        }
        _msgTf.text = data.msg;
        this.visible = true;
    }

    override public function disable():void {
        _btn.removeEventListener(MouseEvent.CLICK, onClick);
        _btn.alpha = 0;
        this.visible = false;
    }

    private function addMsg():void {
        var tf:TextFormat = new TextFormat();
        tf.size = 30;
        tf.font = EmbedFonts.MACPRO_REGULAR;
        tf.color = 0xFFFFFF;

        _msgTf = new TextField();
        _msgTf.defaultTextFormat = tf;
        _msgTf.selectable = false;
        _msgTf.multiline = true;
        _msgTf.wordWrap = true;
        _msgTf.width = 1210;
        _msgTf.height = 1210;
        _msgTf.x = 413;
        _msgTf.y = 170;
        this.addChild(_msgTf);
    }


    //UI
    private function addBk():void {
        var bk:Bitmap = new EmbedImages.POPUP_BG() as Bitmap;
        addChild(bk);
    }

    private function addBtn():void {
        var btnTexture:Bitmap = new EmbedImages.CLOSE_BTN() as Bitmap;
        _btn = new Button(100, 100, null, btnTexture);
        _btn.x = 1650;
        _btn.y = 77;
        this.addChild(_btn);
    }

    private function onClick(e:MouseEvent):void {
        dispatchEvent(new ScreenNavigatorEvent(ScreenNavigatorEvent.CLOSE_POPUP));
    }
}
}
