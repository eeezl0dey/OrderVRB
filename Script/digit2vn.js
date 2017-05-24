
/* преобразование числа в строку
*/
function transform(digitStr) {
    var digitArr = ["số không", // 0
                    "một", // 1
                    "hai", // 2
                    "ba", // 3
                    "bốn", // 4
                    "năm", // 5
                    "sáu", // 6
                    "bảy", // 7
                    "tám", // 8
                    "chín"] // 9
    //    var digitArr10 = ["", // 0
    //                    "một",      // 1
    //                    "hai",      // 2
    //                    "ba",       // 3
    //                    "bốn",      // 4
    //                    "lăm",      // 5
    //                    "sáu",      // 6
    //                    "bảy",      // 7
    //                    "tám",      // 8
    //                    "chín"];    // 9
    var levelArr = ["",
                    "mươi", // десятки
                    "trăm", // сотни
                    "ngàn", // тысячи
                    "triệu", // миллионы
                    "tỷ"] // миллиарды
    var separateDigit = []
    var separateString = []
    var intStr = Number(digitStr)
    var returnStr = ""
    var level = 0

    do {
        var subdigit = intStr % 10
        separateDigit[level] = subdigit


        //        switch(level){
        //            case 0:
        //                sublevelString = levelArr[0];
        //                break;
        //            case 1:
        //            case 4:
        //            case 7:
        //            case 10:
        //                sublevelString = levelArr[1];
        //                break;
        //            case 2:
        //            case 5:
        //            case 8:
        //            case 11:
        //                sublevelString = levelArr[2];
        //                break;
        //            case 3:
        //                sublevelString = levelArr[3];
        //                break;
        //            case 6:
        //                sublevelString = levelArr[4];
        //                break;
        //            case 9:
        //                sublevelString = levelArr[5];
        //                break;
        //        }

        //        returnStr = sublevelString + returnStr;

        //        if(subdigit > 0)
        //            returnStr = digitArr[subdigit] + returnStr;
        level++
        intStr = Math.floor(intStr / 10)
    } while (intStr !== 0)

    //числа
    var i;
    for (i = 0; i < level; i++) {
        if (separateDigit[i] > 0) {
            switch (i) {
            case 0:
                if (level > 1 && separateDigit[1] > 0 && separateDigit[i] === 5)
                    separateString[i] = "lăm"
                else
                    separateString[i] = digitArr[separateDigit[i]]
                break
            case 1:
                if (separateDigit[i] === 1 && level > 3)
                    separateString[i] = "và"
                else
                    separateString[i] = digitArr[separateDigit[i]]
                if (level > 2 && separateDigit[2] > 0 && separateDigit[i] === 7)
                    separateString[i] = "và " + separateString[i]
                break
            default:
                separateString[i] = digitArr[separateDigit[i]]
            }
        }
        else
            separateString[i] = "";
    }

    //порядок
    for (i = 0; i < level; i++) {
        if (separateDigit[i] > 0) {
            switch (i % 3) {
            case 0:
                if(i === 3)
                    separateString[i] = separateString[i] + " " + levelArr[3]
                else if(i === 6)
                    separateString[i] = separateString[i] + " " + levelArr[4]
                else if(i === 9)
                    separateString[i] = separateString[i] + " " + levelArr[5]
                break;
            case 1:
            case 2:
            case 3:
                    separateString[i] = separateString[i] + " " + levelArr[i % 3]
                break
            }
        }
        else
            separateString[i] = "";
    }


    //суммируем
    for (var j = 0; j < level; j++)
        if(separateDigit[j] > 0)
            returnStr = separateString[j] + " " + returnStr;

    return returnStr.charAt(0).toUpperCase() + returnStr.slice(1);
}
