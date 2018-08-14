package screens {
import assets.EmbedFonts;
import assets.EmbedImages;

import com.greensock.TweenMax;

import components.screenNavigator.EventsNavigation;
import components.screenNavigator.ScreenModel;
import components.ui.Button;
import components.ui.Checkbox;

import data.OptusData;

import flash.display.Bitmap;

import flash.events.Event;

import flash.events.KeyboardEvent;

import flash.events.MouseEvent;
import flash.events.SoftKeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import services.UtilitiesService;

public class FormScreen extends ScreenModel {

    private var _submitBtn:Button;
//    private var _legalBtn:Button;
    private var _homeBtn:Button;
    private var _inputs:Array = [];
    private var _legalCheckbox:Checkbox;
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
        focusNextInput();
        enable();
    }

    override public function enable():void {
        _submitBtn.addEventListener(MouseEvent.CLICK, gotoLegal);
//        _legalBtn.addEventListener(MouseEvent.CLICK, gotoLegal);
//        _homeBtn.addEventListener(MouseEvent.CLICK, goHome);
        this.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, panOnSofkeyboardShows);
        this.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, panOnSofkeyboardHides);
        this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        resetForm();
        this.y = 0;
        this.visible = true;
    }

    override public function disable():void {
        _submitBtn.removeEventListener(MouseEvent.CLICK, gotoLegal);
//        _legalBtn.removeEventListener(MouseEvent.CLICK, gotoLegal);
//        _homeBtn.removeEventListener(MouseEvent.CLICK, goHome);
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
        }
//        }
    }

    //UI
    private function addBk():void {
        var bk:Bitmap = new EmbedImages.FORM() as Bitmap;
        addChild(bk);
    }

    private function addBtns():void {
        _submitBtn = new Button(374, 47);
        _submitBtn.x = 454;
        _submitBtn.y = 654;
        _submitBtn.setLabel("Submit");
        this.addChild(_submitBtn);

        _homeBtn = new Button(136, 61);
        _homeBtn.x = 150;
        _homeBtn.y = 660;
        _homeBtn.setLabel("home");
        this.addChild(_homeBtn);
    }

    private function addInputs():void {
        var nameTf:TextField = getInput(647, 32, 453, 195);
        this.addChild(nameTf);
        _inputs.push(nameTf);

        var dobTf:TextField = getInput(230, 32, 461, 257);
        this.addChild(dobTf);
        _inputs.push(dobTf);

        var dniTf:TextField = getInput(286, 32, 814, 257);
        this.addChild(dniTf);
        _inputs.push(dniTf);

        var phoneTf:TextField = getInput(249, 32, 489, 316);
        this.addChild(phoneTf);
        _inputs.push(phoneTf);
    }

    private function addLegalCheckbox():void {
        _legalCheckbox = new Checkbox();
        _legalCheckbox.x = 878;
        _legalCheckbox.y = 566;
        this.addChild(_legalCheckbox);
    }

    //inputs focus
    private function focusNextInput():void {
        for (var i:uint = 0; i < _inputs.length; i++) {
            if (_inputs[i].text == "") {
                _inputs[i].requestSoftKeyboard();
                stage.focus = _inputs[i];
                break;
            }
        }
    }

    //local getters
    private function getFormData():Object {
        var formData:Object;
        formData = {
            name: _inputs[0].text,
            dob: _inputs[1].text,
            dni: _inputs[2].text,
            phone: _inputs[3].text,
            email: 'harcoded',
            date: UtilitiesService.getDate(),
            promo: _legalCheckbox.isChecked ? 1 : 0,
            terms: 'hardcoded'
        };
        return formData;
    }

    private function getInput(width:uint, height:uint, x:uint, y:uint):TextField {
        var inputTextFormat:TextFormat = new TextFormat();
        inputTextFormat.size = 28;
        inputTextFormat.font = EmbedFonts.MACPRO_HEAVY;

        var tfInput:TextField = new TextField();
        tfInput.type = TextFieldType.INPUT;
        tfInput.defaultTextFormat = inputTextFormat;
        tfInput.multiline = false;
        tfInput.width = width;
        tfInput.height = height + 2;
        tfInput.x = x;
        tfInput.y = y;
//        tfInput.border = 1;
        return tfInput;
    }

    //inputs checkers
    private function isFormDataOk():Boolean {
        for (var i:uint = 0; i < _inputs.length; i++) {
            if (_inputs[i].text == "" || _inputs[i].text == undefined) {
//                dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {msg: WinstonData.FORM_DATA_MISSING, btn: true}));
                trace('form is incomplete');
                return false;
            }
        }

//        if (!_signatureField.isSigned) {
//            dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {msg: WinstonData.FORM_SIGNATURE_MISSING, btn: true}));
//            return false;
//        }

        return true;
    }

    private function resetForm():void {
        for (var i:uint = 0; i < _inputs.length; i++) {
            _inputs[i].text = "";
        }
//        _signatureField.reset();
        _legalCheckbox.uncheck();
    }

    //event handlers
    //panning app with softKeyboard
    private function panOnSofkeyboardShows(e:SoftKeyboardEvent = null):void {
        if (this.y + 20 > _panLimit) {
            TweenMax.to(this, .2, {y: (stage.focus.y) * -1 + 20});
        }
    }

    private function panOnSofkeyboardHides(e:SoftKeyboardEvent = null):void {
        TweenMax.to(this, .2, {y: 0});
    }

//    private function onDataSubmited(e:EventsWinston):void {
//        OptusService.localDB().removeEventListener(EventsWinston.RESPONSE, onDataSubmited);
//        OptusService.localDB().removeEventListener(EventsWinston.ERROR, onDataSubmited);
//        resetForm();
//        dispatchEvent(new EventsNavigation(EventsNavigation.HOME));
//    }

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

    private function gotoLegal(e:MouseEvent):void {
//        _submitBtn.removeEventListener(MouseEvent.CLICK, gotoLegal);
        if (isFormDataOk()) {
            dispatchEvent(new EventsNavigation(EventsNavigation.POPUP, {msg: "", popupId: OptusData.LEGAL_POPUP_SCREEN}));
        }
//        dispatchEvent(new EventsNavigation(EventsNavigation.NEXT_SCREEN));
    }

//    private function goHome(e:MouseEvent):void {
//        dispatchEvent(new EventsNavigation(EventsNavigation.HOME));
//        resetForm();
//    }
}
}
