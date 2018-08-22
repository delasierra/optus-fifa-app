package components {
import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextField;

public class TextFieldPlaceholder extends TextField {

    private var _placeholderText:String;
    private var _currentText:String;

    public function TextFieldPlaceholder(placeholderText:String = 'Input text here') {
        _placeholderText = placeholderText;
        _currentText = '';
        this.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
        this.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
        super();
    }

    override public function get text():String {
        if (_currentText == _placeholderText) {
            return '';
        }
        return _currentText;
    }

    override public function set text(value:String):void {
        _currentText = value;
        if (!_currentText) {
            super.text = _placeholderText;
        } else {
            super.text = _currentText;
        }
    }

    private function onFocusIn(e:Event):void {
        super.text = _currentText;
    }

    private function onFocusOut(e:Event):void {
        this.text = super.text;
    }
}
}
