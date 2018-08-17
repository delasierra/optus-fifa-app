package screens {
import assets.EmbedFonts;
import assets.EmbedImages;

import components.screenNavigator.EventsNavigation;
import components.screenNavigator.ScreenModel;
import components.ui.Button;
import components.ui.Checkbox;

import data.OptusData;

import flash.display.Bitmap;

import flash.events.KeyboardEvent;

import flash.events.MouseEvent;
import flash.events.SoftKeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import services.OptusService;

import services.UtilitiesService;

public class FormScreen extends ScreenModel {

    private var _submitBtn:Button;
    private var _termsBtn:Button;
    private var _inputs:Array = [];
    private var _legalCheckbox:Checkbox;
    private var _promoCheckbox:Checkbox;
    private var _panLimit:Number;


    public function FormScreen() {
        super();
    }

    override protected function init():void {
        _panLimit = (stage.height / 4) * -1;
        addBk();
        addBtns();
        addInputs();
        addLegalCheckbox();
        addPromoCheckbox();
//        focusNextInput();
        enable();
    }

    override public function enable():void {
        _submitBtn.addEventListener(MouseEvent.CLICK, submitForm);
        _termsBtn.addEventListener(MouseEvent.CLICK, showTermsText);

        this.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, panOnSofkeyboardShows);
        this.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, panOnSofkeyboardHides);
        this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        resetForm();
        this.y = 0;
        this.visible = true;
    }

    override public function disable():void {
        _submitBtn.removeEventListener(MouseEvent.CLICK, submitForm);
        _termsBtn.removeEventListener(MouseEvent.CLICK, showTermsText);

        this.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, panOnSofkeyboardShows);
        this.removeEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, panOnSofkeyboardHides);
        this.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        this.y = 0;
        this.visible = false;
    }

    override public function popUpClosed(popupId:String):void {
        if (popupId == OptusData.LEGAL_POPUP_SCREEN) {
//            if (isFormDataOk()) {
//            _signatureField.addEventListener(Event.COMPLETE, recordDaraOnLocalDb);
//            _signatureField.makeSignatureImg();
//        }
        }
    }

    //UI
    private function addBk():void {
        var bk:Bitmap = new EmbedImages.FORM_SCREEN_BG() as Bitmap;
        addChild(bk);
    }

    private function addBtns():void {
        _submitBtn = new Button(776, 96);
        _submitBtn.x = 633;
        _submitBtn.y = 1119;
        _submitBtn.setLabel("BEGIN");
        this.addChild(_submitBtn);

        _termsBtn = new Button(351, 34);
        _termsBtn.x = 910;
        _termsBtn.y = 918;
        _termsBtn.setLabel("terms");
        this.addChild(_termsBtn);
    }

    private function addInputs():void {
        var formElementWidth:Number = 776 - 40;
        var formElementHeight:Number = 50;
        var x:Number = 633 + 20;
        var adjustY:Number = 31;

        var nameInput:TextField = getInput(
                formElementWidth,
                formElementHeight,
                x,
                491 + adjustY);
        this.addChild(nameInput);
        _inputs.push(nameInput);

        var emailInput:TextField = getInput(
                formElementWidth,
                formElementHeight,
                x,
                582 + adjustY);
        this.addChild(emailInput);
        _inputs.push(emailInput);

        var dobInput:TextField = getInput(
                formElementWidth,
                formElementHeight,
                x,
                674 + adjustY);
        this.addChild(dobInput);
        _inputs.push(dobInput);

        var mobileInput:TextField = getInput(
                formElementWidth,
                formElementHeight,
                x,
                766 + adjustY);
        this.addChild(mobileInput);
        _inputs.push(mobileInput);
    }

    private function addLegalCheckbox():void {
        _legalCheckbox = new Checkbox();
        _legalCheckbox.x = 631;
        _legalCheckbox.y = 917.5;
        this.addChild(_legalCheckbox);
    }

    private function addPromoCheckbox():void {
        _promoCheckbox = new Checkbox();
        _promoCheckbox.x = 631;
        _promoCheckbox.y = 994;
        this.addChild(_promoCheckbox);
    }

    //inputs focus
    private function focusNextInput():void {
//        trace(focusNextInput, _inputs)
        for (var i:uint = 0; i < _inputs.length; i++) {
            if (_inputs[i].text == "") {
                stage.focus = _inputs[i];
                _inputs[i].requestSoftKeyboard();
                break;
            }
        }
    }

    //local getters
    private function getFormData():Object {
        var formData:Object;
        formData = {
            name: _inputs[0].text,
            email: _inputs[1].text,
            dob: _inputs[2].text,
            mobile: _inputs[3].text,
            promo: _promoCheckbox.isChecked ? 1 : 0,
            terms: _legalCheckbox.isChecked ? 1 : 0,
            date: UtilitiesService.getDate()
        };
        return formData;
    }

    private function getInput(width:uint, height:uint, x:uint, y:uint):TextField {
        var inputTextFormat:TextFormat = new TextFormat();
        inputTextFormat.size = 32;
        inputTextFormat.font = EmbedFonts.MACPRO_REGULAR;
        inputTextFormat.color = "0x414141";

        var tfInput:TextField = new TextField();
        tfInput.type = TextFieldType.INPUT;
//        tfInput.embedFonts = true;
        tfInput.defaultTextFormat = inputTextFormat;
        tfInput.multiline = false;
        tfInput.width = width;
        tfInput.height = height + 2;
        tfInput.x = x;
        tfInput.y = y;
//        tfInput.text = 'test text';
//        tfInput.y += Math.round((tfInput.height - tfInput.textHeight) / 2);
//        tfInput.border = 1;
        return tfInput;
    }

    //inputs checkers
    private function isFormDataOk():Boolean {
//        TODO delete the next line (is only for debug)
//        return true;
        for (var i:uint = 0; i < _inputs.length; i++) {
            if (_inputs[i].text == "" || _inputs[i].text == undefined || !_legalCheckbox.isChecked) {
//                dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {msg: WinstonData.FORM_DATA_MISSING, btn: true}));
                trace('form is incomplete');
                return false;
            }
        }
        return true;
    }

    private function resetForm():void {
        for (var i:uint = 0; i < _inputs.length; i++) {
            _inputs[i].text = "";
        }
//        _signatureField.reset();
        _legalCheckbox.uncheck();
        _promoCheckbox.uncheck();
    }

    //event handlers
    //panning app with softKeyboard
    private function panOnSofkeyboardShows(e:SoftKeyboardEvent = null):void {
//        if (this.y + 20 > _panLimit) {
//            TweenMax.to(this, .2, {y: (stage.focus.y) * -1 + 20});
//        }
    }

    private function panOnSofkeyboardHides(e:SoftKeyboardEvent = null):void {
//        TweenMax.to(this, .2, {y: 0});
    }

    private function onKeyDown(e:KeyboardEvent):void {
//        trace("e.charCode", e.charCode);
        if (e.charCode == 13 || e.charCode == 9) {
            focusNextInput();
        }
    }

//    private function onError(e:EventsWinston):void {
//        OptusService.localDB().removeEventListener(EventsWinston.RESPONSE, onDataSubmited);
//        OptusService.localDB().removeEventListener(EventsWinston.ERROR, onError);
//        dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {msg: WinstonData.ERROR, btn: true}));
//    }

    private function showTermsText(e:MouseEvent):void {
//        _submitBtn.removeEventListener(MouseEvent.CLICK, gotoLegal);

        dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {
            msg: "",
            popupId: OptusData.LEGAL_POPUP_SCREEN
        }));
    }

    private function submitForm(e:MouseEvent):void {
        if (isFormDataOk()) {
            OptusService.startQuiz(getFormData());
            dispatchEvent(new EventsNavigation(EventsNavigation.NEXT_SCREEN));
        }
    }

}
}
