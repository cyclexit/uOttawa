// constants
const TOTAL_SLOTS = 16;

// global variables
var emptySlotID = -1;

// HTML elements
var slots = new Array(TOTAL_SLOTS);

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
    }
}

// util functinos
function rand(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}

function shuffle(arr) {
    arr.sort(() => Math.random() - 0.5);
}

window.onload = init;