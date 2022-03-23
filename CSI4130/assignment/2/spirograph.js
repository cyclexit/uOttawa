/**
 * Student Name: Hongyi Lin
 * Student No.: 300053082
 */

// global variables
var stats;
var scene, renderer;

const views = [
    // front view: look from z-positive
    {
        left: 0,
        bottom: 0,
        width: 0.5,
        height: 1.0,
        background: new THREE.Color(0.5, 0.5, 0.7),
        eye: [0, 300, 1800],
        up: [0, 1, 0],
        fov: 30
    },
    // top view: look from y-positive
    {
        left: 0.5,
        bottom: 0,
        width: 0.5,
        height: 0.5,
        background: new THREE.Color(0.7, 0.5, 0.5),
        eye: [0, 1800, 0],
        up: [0, 0, 1],
        fov: 45
    }
];

function init() {
    // const container = document.getElementById("canvas-container");

    // add the camera to each view
    for (var i = 0; i < views.length; ++i) {
        const view = views[i];
        const camera = new THREE.PerspectiveCamera(
            view.fov, innerWidth, innerHeight, 1, 10000
        );
        camera.position.fromArray(view.eye);
        camera.up.fromArray(view.up);
        view.camera = camera;
    }

    // create the scene
    scene = new THREE.Scene();

    // add light to the scene
    const light = new THREE.DirectionalLight(0xffffff);
    light.position.set(0, 0, 1);
    scene.add(light);

    // create the shadow on the canvas
    const canvas = document.createElement("canvas");
    canvas.width = 128;
    canvas.height = 128;

    const context = canvas.getContext("2d");
    const gradient = context.createRadialGradient(
        canvas.width / 2, canvas.height / 2, 0,
        canvas.width / 2, canvas.height / 2, canvas.width / 2
    );
    gradient.addColorStop(0.1, "rgba(0,0,0,0.15)");
    gradient.addColorStop(1, "rgba(0,0,0,0)");

    context.fillStyle = gradient;
    context.fillRect(0, 0, canvas.width, canvas.height);

    const shadowTexture = new THREE.CanvasTexture(canvas);
    const shadowMaterial = new THREE.MeshBasicMaterial({
        map: shadowTexture,
        transparent: true
    });
    const shadowGeometry = new THREE.PlaneGeometry(300, 300, 1, 1);
    
    var shadowMesh;
    // the first shadow
    shadowMesh = new THREE.Mesh(shadowGeometry, shadowMaterial);
    shadowMesh.position.y = -250;
    shadowMesh.rotation.x = -Math.PI / 2;
    scene.add(shadowMesh);
    // the second mesh
    shadowMesh = new THREE.Mesh(shadowGeometry, shadowMaterial);
    shadowMesh.position.x = -400;
    shadowMesh.position.y = -250;
    shadowMesh.rotation.x = -Math.PI / 2;
    scene.add( shadowMesh );

}