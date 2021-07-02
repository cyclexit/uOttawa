var canvas = document.getElementById("shape-canvas");
var context = canvas.getContext("2d");

// triangle
context.beginPath();
context.moveTo(30, 0);
context.lineTo(0, 40);
context.lineTo(60, 40);
context.lineTo(30, 0);
context.lineWidth = 1;
context.lineJoin = "miter";
context.strokeStyle = "black";
context.stroke();

// vertical gradient
var gradient = context.createLinearGradient(30, 0, 30, 40);
gradient.addColorStop(0, "white");
gradient.addColorStop(0.5, "lightblue");
gradient.addColorStop(1, "steelblue");
context.fillStyle = gradient;
context.fill();