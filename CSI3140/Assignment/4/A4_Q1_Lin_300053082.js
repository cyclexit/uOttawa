// constants
const TOTAL_SLOTS = 16;
const TOTAL_ROWS = 4;
const TOTAL_COLS = 4;

// global variables
var emptySlotID = -1;

// HTML elements
var slots = new Array(TOTAL_SLOTS);

function rand(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}

function shuffle(arr) {
    arr.sort(() => Math.random() - 0.5);
}

function isLegalSlot(id) {
    // res many contains some outbounded values, and it does not matter
    var res = [emptySlotID - TOTAL_COLS, emptySlotID + TOTAL_COLS];
    if (emptySlotID % 4 == 0) { // leftmost col
        res.push(emptySlotID + 1);
    } else if (emptySlotID % 4 == 3) { // rightmost col
        res.push(emptySlotID - 1);
    } else {
        res.push(emptySlotID + 1);
        res.push(emptySlotID - 1);
    }
    console.log("id = ", id, "empty", emptySlotID, "legal = ", res); // test
    for (var i = 0; i < res.length; ++i) {
        if (id === res[i]) {
            return true;
        }
    }
    return false;
}

function clickListener() {
    this.onclick = (e) => {
        var id = parseInt(e.target.id.substr(5));
        if (id === emptySlotID) {
            alert("Illegal Move: You cannot click the empty slot to make the move.");
            return;
        }
        if (isLegalSlot(id)) {
            slots[emptySlotID].textContent = e.target.textContent;
            e.target.textContent = "";
            emptySlotID = id;
        } else {
            alert("Illegal Move: This slot is not adjacent to the empty slot.");
        }
    }
}

function init() {
    var values = new Array(TOTAL_SLOTS - 1);
    for (var i = 0; i < TOTAL_SLOTS; ++i) {
        if (i < values.length) {
            values[i] = i + 1;
        }
        slots[i] = document.getElementById(`slot-${i}`);
    }
    shuffle(values);
    console.log(values); // test
    emptySlotID = rand(0, TOTAL_SLOTS);
    console.log(emptySlotID);
    var idx = 0;
    for (var i = 0; i < TOTAL_SLOTS; ++i) {
        if (i != emptySlotID) {
            slots[i].textContent = values[idx++];
        }
        slots[i].addEventListener("click", clickListener());
    }
}

window.onload = init;