/**
 * Created by Carlos de la Sierra on 8/2/17.
 */
package components.ui {

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    public class Button extends Sprite {

        private var _bg:Sprite;
        private var _tf:TextField;
        private var _data:Object;
        private var _texture:Bitmap;

        public function Button(width:int = 200, height:int = 25, data:Object = null, texture:Bitmap = null) {
            _data = data;
            _texture = texture;
            init(width, height);
        }

        public function get data():Object {
            return _data;
        }

        private function init(width:int, height:int):void {
            this.buttonMode = true;
            this.mouseChildren = false;
            this.useHandCursor = true;
            trace('_texture', _texture);
            if(!_texture){
                _bg = new Sprite();
                _bg.graphics.beginFill(0xababab);
                _bg.graphics.drawRect(0, 0, width, height);
                _bg.graphics.endFill();
                _bg.alpha = 0;
                this.addChild(_bg);
            }else{
                trace('----- texture');
                this.addChild(_texture);
            }



            _tf = new TextField();

            var format:TextFormat = _tf.defaultTextFormat;
            format.size = 14;
            format.align = TextFormatAlign.CENTER;

            _tf.y = 3;
            _tf.width = width;
            _tf.defaultTextFormat = format;

            this.addChild(_tf);
        }

        public function setLabel(label:String):void {
            _tf.text = label;
        }
    }
}


