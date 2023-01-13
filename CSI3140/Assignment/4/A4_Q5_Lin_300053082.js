var canvas = document.getElementById("text-canvas");
var context = canvas.getContext("2d");

// text
context.fillStyle = "black";
context.textAlign = "center";
context.font = "bold 36px courier";
// shadow
context.shadowOffsetX = 2;
context.shadowOffsetY = 5;
context.shadowBlur = 6;
context.shadowColor = "gray";

context.fillText("HTML5 Canvas", canvas.width / 2, canvas.height / 2);
