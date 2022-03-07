function main() {
    // get the canvas
    var canvas = document.getElementById("webgl-canvas");
    var gl = getWebGLContext(canvas);
}

window.onload = main;