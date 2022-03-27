/**
 * Student Name: Hongyi Lin
 * Student No.: 300053082
 */

import { GLTFLoader } from "https://cdn.skypack.dev/three-stdlib@2.8.5/loaders/GLTFLoader";

const canvas = document.getElementById("canvas");
const scene = new THREE.Scene();
const renderer = new THREE.WebGLRenderer({canvas:canvas, antialias: true, preserveDrawingBuffer: true});
const views = [
    {
        left: 0,
        bottom: 0,
        width: 0.5,
        height: 1.0,
        background: new THREE.Color( 0.5, 0.5, 0.7 ),
        eye: [ 0, 0, 100 ],
        up: [ 0, 1, 0 ],
        fov: 60
    },
    {
        left: 0.5,
        bottom: 0,
        width: 0.5,
        height: 1.0,
        background: new THREE.Color( 0.7, 0.5, 0.5 ),
        eye: [ 0, 100, 0 ],
        up: [ 0, 0, 1 ],
        fov: 60
    },
];
const controls = {
    k: 0.3,
    l: 0.9,
    update: () => {
        renderer.clear();
        updateCurve(controls.k, controls.l);
    },
    is2D: true
}
const curveGroup = new THREE.Group();
const OUTER_RADIUS = 20;
let airplane = (await new GLTFLoader().loadAsync("./assets/airplane.glb")).scene.children[0];
let windowWidth, windowHeight;

class MyCurve extends THREE.Curve {
    constructor(k, l, r=OUTER_RADIUS) {
        super();
        this.k = k; // inner radius = k * outer radius, 0 < k < 1
        this.l = l; // pen position
        this.r = r; // outer radius
    }

    getPoint(t) {
        t = t * Math.PI * 6;
        console.log(t);
        var tx = this.r * ((1 - this.k) * Math.cos(t) + this.l * this.k * Math.cos((1 - this.k) * t / this.k));
        var ty = this.r * ((1 - this.k) * Math.sin(t) - this.l * this.k * Math.sin((1 - this.k) * t / this.k));
        var tz = 0;
        return new THREE.Vector3(tx, ty, tz);
    }
}

function init() {
    // add axis helper
    const axesHelper = new THREE.AxesHelper(1000);
    scene.add(axesHelper);

    // add camera to the views
    for ( let i = 0; i < views.length; ++ i ) {
        const view = views[ i ];
        const camera = new THREE.PerspectiveCamera( view.fov, window.innerWidth / window.innerHeight, 1, 10000 );
        camera.position.fromArray(view.eye);
        camera.up.fromArray(view.up);
        camera.lookAt(scene.position);
        view.camera = camera;
    }

    // add the light
    var light = new THREE.DirectionalLight(0xffffff);
    light.position.set( 0, 0, 1 );
    scene.add(light);

    light = new THREE.DirectionalLight(0xffffff);
    light.position.set(0, 1, 0);
    scene.add(light);

    // add the spirograph curve
    scene.add(curveGroup);
    updateCurve(0.3, 0.9);

    // add the airplane
    airplane.scale.set(0.003, 0.003, 0.003);
    airplane.rotation.set(0, 0, 0);
    airplane.position.set(0, 0, 0);
    scene.add(airplane);

    // add dat.gui controls
    const gui = new dat.GUI();
    gui.add(controls, 'k', 0.0, 1.0, 0.01).onChange(controls.update);
    gui.add(controls, 'l', -1.0, 1.0, 0.01).onChange(controls.update);
    gui.add(controls, "is2D").onChange(controls.update);

    // configure the renderer
    renderer.autoClear = false;
    renderer.setPixelRatio(devicePixelRatio);
    renderer.setSize(innerWidth, innerHeight);
    renderer.setClearColor(new THREE.Color( 0.5, 0.5, 0.7 ));
    // container.appendChild(renderer.domElement);
}

function updateCurve(k, l) {
    curveGroup.clear();
    var curvePath = new MyCurve(k, l);
    var curveGeometry = new THREE.TubeGeometry(curvePath, 100, 0.3, 100, false);
    var curveMesh = new THREE.Mesh(
        curveGeometry,
        new THREE.MeshPhongMaterial({color: 0x6495ED, flatShading: true})
    );
    curveGroup.add(curveMesh);
}

function updateSize() {
    if ( windowWidth != window.innerWidth || windowHeight != window.innerHeight ) {
        windowWidth = window.innerWidth;
        windowHeight = window.innerHeight;
        renderer.setSize( windowWidth, windowHeight );
    }
}

var t = 0;
function airplaneMove(k, l, r=OUTER_RADIUS) {
    t += 0.01;
    var tx = r * ((1 - k) * Math.cos(t) + l * k * Math.cos((1 - k) * t / k));
    var ty = r * ((1 - k) * Math.sin(t) - l * k * Math.sin((1 - k) * t / k));
    var tz = 0;
    airplane.position.set(tx, ty, tz);
}

function render() {
    updateSize();

    // airplaneMove(controls.k, controls.l);

    // rotate the curve
    curveGroup.rotation.y += Math.PI / 300; // rotate spirograph around y
    curveGroup.rotation.z += Math.PI / 300; // rotate spirograph around z

    renderer.setClearColor(new THREE.Color( 0.5, 0.5, 0.7 ));
    for (let i = 0; i < views.length; ++i) {
        const view = views[ i ];
        const camera = view.camera;

        const left = Math.floor( windowWidth * view.left );
        const bottom = Math.floor( windowHeight * view.bottom );
        const width = Math.floor( windowWidth * view.width );
        const height = Math.floor( windowHeight * view.height );

        renderer.setViewport(left, bottom, width, height);
        renderer.setClearColor(view.background);

        camera.aspect = width / height;
        camera.updateProjectionMatrix();

        renderer.render(scene, camera);
    }
}

function animate() {
    render();
    requestAnimationFrame( animate );
}

init();
animate();
