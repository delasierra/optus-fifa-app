package components {
import assets.EmbedFonts;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class ProgressBar extends Sprite{

    private var _progressText:TextField;

    public function ProgressBar() {
        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
    }

    public function update(currentProgress:uint, totalProgress:uint):void {
        _progressText.text = 'Question ' + currentProgress + '/' + totalProgress;
        this.visible = true;
    }

    public function hide():void {
        this.visible = false;
    }

    private function addTextField():void {
        var questionTextFormat:TextFormat = new TextFormat();
        questionTextFormat.size = 40;
        questionTextFormat.font = EmbedFonts.MACPRO_MEDIUM;
        questionTextFormat.color = 0xffffff;
        questionTextFormat.align = 'center';

        _progressText = new TextField();
        _progressText.autoSize = TextFieldAutoSize.LEFT;
        _progressText.mouseEnabled = false;
        _progressText.defaultTextFormat = questionTextFormat;
        _progressText.embedFonts = true;
        _progressText.x = 60;
        this.addChild(_progressText);
    }

//    Handlers
    private function onAddedToStage(e:Event):void {
        addTextField();
    }
}
}
