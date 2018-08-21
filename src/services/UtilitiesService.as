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

    public static function randomShuffleArray(array:Array):Array {
        var clonedArray:Array = array.slice();
        var shuffledArray:Array = new Array(clonedArray.length);

        var randomPos:Number = 0;
        for (var i:int = 0; i < shuffledArray.length; i++) {
            randomPos = int(Math.random() * clonedArray.length);
            shuffledArray[i] = clonedArray.splice(randomPos, 1)[0];

            if (shuffledArray[i].value == 'true') {
                trace('---------------- \n\ncorrect answer: ', shuffledArray[i].text, '\n\n----------------');
            }
        }

        return shuffledArray;
    }
}
}
