// HTML elements
const usrInputText = document.getElementById("usr-input");
const pigLatinText = document.getElementById("pig-latin");

function printLatinWord(word) {
    pigLatinText.innerHTML += word.substr(1) + word[0] + "ay" + " ";
    pigLatinText.scrollTop = pigLatinText.scrollHeight;
}

function pigLatinEncode() {
    var usrInputArray = usrInputText.value.toString().split(" ");
    for (var i = 0; i < usrInputArray.length; ++i) {
        printLatinWord(usrInputArray[i]);
    }
    pigLatinText.innerHTML += "\n";
}