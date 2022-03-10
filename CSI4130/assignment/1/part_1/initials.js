// Constants
const SPACE_DIMENSION = 2;
const CIRCLE_RADIUS = 0.5;

// Global variables
var gl, canvas;
var verticesH = new Float32Array([
    -0.02, 0.06,
    -0.02, -0.06,
    -0.04, -0.06,
    -0.04, -0.01,
    -0.08, -0.01,
    -0.08, -0.06,
    -0.1, -0.06,
    -0.1, 0.06,
    -0.08, 0.06,
    -0.08, 0.01,
    -0.04, 0.01,
    -0.04, 0.06
]);
var verticesL = new Float32Array([
    0.02, 0.06,
    0.02, -0.06,
    0.1, -0.06,
    0.1, -0.04,
    0.04, -0.04,
    0.04, 0.06
]);

window.addEventListener("load", main, false);

function main() {
    canvas = document.getElementById("webgl-canvas");
    gl = getWebGLContext(canvas);
    // If we don't have a GL context, give up now
    if (!gl) {
        console.log('Failed to get the rendering context for WebGL');
        return;
    }

    // Vertex shader program
    const vertexShader = `
        attribute vec4 aVertex;
        uniform mat4 uModelViewMatrix;
        uniform mat4 uProjectionMatrix;
        void main() {
            gl_Position = uProjectionMatrix * uModelViewMatrix * aVertex;
        }
    `;

    // Fragment shader program
    const fragmentShader = `
        void main() {
            gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
    `;

    // Init shaders
    if (!initShaders(gl, vertexShader, fragmentShader)) {
        console.log('Failed to intialize shaders.');
        return;
    }

    initMatrices();

    initScreen();

    // translate the letters to prepare for the spining.
    translateX(CIRCLE_RADIUS);
    
    // Draw letter H
    if (!draw(gl.LINE_LOOP, verticesH)) {
        console.log('Failed to draw H.');
        return;
    }

    // Draw letter L
    if (!draw(gl.LINE_LOOP, verticesL)) {
        console.log('Failed to draw L.');
        return;
    }
}

function translateX(distance) {
    for (var i = 0; i < verticesH.length; i += 2) {
        verticesH[i] += distance
    }
    for (var i = 0; i < verticesL.length; i += 2) {
        verticesL[i] += distance
    }
}

function initMatrices() {
    // Set the model view matrix
    var uModelViewMatrix = gl.getUniformLocation(gl.program, 'uModelViewMatrix');
    if (!uModelViewMatrix) {
        console.log('Failed to get the storage location of uModelViewMatrix');
        return false;
    }
    var modelViewMatrix = glMatrix.mat4.create();
    gl.uniformMatrix4fv(uModelViewMatrix, false, modelViewMatrix);

    // Set the projection matrix
    var uProjectionMatrix = gl.getUniformLocation(gl.program, 'uProjectionMatrix');
    if (!uProjectionMatrix) {
        console.log('Failed to get the storage location of uProjectionMatrix');
        return false;
    }
    var projectionMatrix = glMatrix.mat4.create();
    gl.uniformMatrix4fv(uProjectionMatrix, false, projectionMatrix);
}

function initScreen() {
    gl.clearColor(0.0, 0.0, 0.0, 1.0); // Clear to black, fully opaque
    gl.clearDepth(1.0); // Clear everything
    gl.enable(gl.DEPTH_TEST); // Enable depth testing
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT); // Clear <canvas> - both color and depth
    gl.viewport(0, 0, canvas.width, canvas.height); // set the viewport
}

function draw(mode, vertices) {
    // Init vertex buffers
    if (!initVertexBuffers(vertices)) {
        console.log('Failed to set the positions of the vertices for H.');
        return false;
    }

    // Draw the shape
    gl.drawArrays(mode, 0, vertices.length / SPACE_DIMENSION);

    return true;
}

function initVertexBuffers(vertices) {
    // Create a buffer object
    var vertexBuffer = gl.createBuffer();
    if (!vertexBuffer) {
        console.log('Failed to create the buffer object');
        return false;
    }
    // Bind the buffer object to target
    gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
    // Write data into the buffer object
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);

    var aVertex = gl.getAttribLocation(gl.program, 'aVertex');
    if (aVertex < 0) {
        console.log('Failed to get the storage location of aVertex');
        return false;
    }

    gl.vertexAttribPointer(aVertex, SPACE_DIMENSION, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(aVertex);
    
    return true;
}
