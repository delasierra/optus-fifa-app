package services {
public class UtilitiesService {
    //get date
    public static function getDate():String {
        var dateObj:Date = new Date();
        var year:String = String(dateObj.getFullYear());
        var month:String = String(dateObj.getMonth() + 1);
        if (month.length == 1) {
            month = "0" + month;
        }
        var date:String = String(dateObj.getDate());
        if (date.length == 1) {
            date = "0" + date;
        }
        return date + "/" + month + "/" + year;
    }

    public static function getRandomNumber(minNum:Number, maxNum:Number):Number {
        return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);

    }
}
}
