window.addEventListener("load", main, false);

function main() {
    const canvas = document.getElementById("webgl-canvas");
    const gl = canvas.getContext("webgl");

    // If we don't have a GL context, give up now
    if (!gl) {
        console.log('Failed to get the rendering context for WebGL');
        return;
    }

    // Vertex shader program
    const vertexShader = `
        attribute vec4 aVertexPosition;
        uniform mat4 uModelViewMatrix;
        uniform mat4 uProjectionMatrix;
        void main() {
            gl_Position = uProjectionMatrix * uModelViewMatrix * aVertexPosition;
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
}

function initVertexBuffers(gl) {
    
}
