// HTML elements
const startRaceButton = document.getElementById("start-race");

// constants
const START = 0;
const END = 69;

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function startRace() {
    const beginText = document.getElementById("begin");
    startRaceButton.disabled = true;
    beginText.innerHTML = "ON YOUR MARK, GET SET<br>";
    await sleep(1000).then(() => {
        beginText.innerHTML += "BANG!!!<br>";
        beginText.innerHTML += "AND THEY'RE OFF!!!<br>";
    });
    racing();
}

var tortoise = START;
var hare = START;

function racing() {
    // init the race text
    updateRaceText();
    // start the clock
    var cnt = 0;
    var racingClock = setInterval(() => {
        ++cnt;
        move();
        if (tortoise === END || hare === END) {
            clearInterval(racingClock);
            // show the result
            console.log(tortoise, hare);
            const resultText = document.getElementById("result");
            resultText.style.color = "red";
            if (tortoise === END && hare === END) {
                resultText.innerHTML += "IT’S A TIE";
            } else if (tortoise === END) {
                resultText.innerHTML += "TORTOISE WINS!!! YAY!!!";
            } else if (hare === END) {
                resultText.innerHTML += "HARE WINS. YUCK!";
            }
            resultText.innerHTML += `<br> Time elapsed: ${cnt}`;
        }
    }, 100);
}

function move() {
    var t = Math.floor(Math.random() * 10) + 1;
    if (1 <= t && t <= 5) {
        tortoise += 3;
    } else if (6 <= t && t <= 7) {
        tortoise -= 6;
    } else if (8 <= t && t <= 10) {
        tortoise += 1;
    }
    tortoise = Math.max(tortoise, START);
    tortoise = Math.min(tortoise, END);

    var h = Math.floor(Math.random() * 10) + 1;
    if (1 <= h && h <= 2) {
        // do nothing
    } else if (3 <= h && h <= 4) {
        hare += 9;
    } else if (h === 5) {
        hare -= 12;
    } else if (6 <= h && h <= 8) {
        hare += 1;
    } else if (9 <= h && h <= 10) {
        hare -= 2;
    }
    hare = Math.max(hare, START);
    hare = Math.min(hare, END);

    updateRaceText();
}


function updateRaceText() {
    const raceText = document.getElementById("race");
    for (var i = 0; i < 70; ++i) {
        if (i === tortoise && i === hare) {
            raceText.innerHTML += "OUCH!!!";
        } else if (i == tortoise) {
            raceText.innerHTML += "T";
        } else if (i == hare) {
            raceText.innerHTML += "H";
        } else {
            raceText.innerHTML += "&nbsp";
        }
    }
    raceText.innerHTML += "<br>";
    raceText.scrollTop = raceText.scrollHeight;
}