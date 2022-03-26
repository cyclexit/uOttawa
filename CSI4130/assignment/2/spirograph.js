/**
 * Student Name: Hongyi Lin
 * Student No.: 300053082
 */

import { GLTFLoader } from "https://cdn.skypack.dev/three-stdlib@2.8.5/loaders/GLTFLoader";

const container = document.getElementById("container");
const scene = new THREE.Scene();
const renderer = new THREE.WebGLRenderer({antialias: true});
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
const curveGroup = new THREE.Group();
let airplane = (await new GLTFLoader().loadAsync("./assets/airplane.glb")).scene.children[0];
let windowWidth, windowHeight;

class MyCurve extends THREE.Curve {
    constructor(k, l, r=20) {
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
        var tz = 5; // TODO: replace this
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
    const light = new THREE.DirectionalLight( 0xffffff );
    light.position.set( 0, 0, 1 );
    scene.add( light );

    // add the shadow
    const canvas = document.createElement( 'canvas' );
    canvas.width = 128;
    canvas.height = 128;

    const context = canvas.getContext( '2d' );
    const gradient = context.createRadialGradient( canvas.width / 2, canvas.height / 2, 0, canvas.width / 2, canvas.height / 2, canvas.width / 2 );
    gradient.addColorStop( 0.1, 'rgba(0,0,0,0.15)' );
    gradient.addColorStop( 1, 'rgba(0,0,0,0)' );
    context.fillStyle = gradient;
    context.fillRect( 0, 0, canvas.width, canvas.height );

    const shadowTexture = new THREE.CanvasTexture( canvas );
    const shadowMaterial = new THREE.MeshBasicMaterial( { map: shadowTexture, transparent: true } );
    const shadowGeo = new THREE.PlaneGeometry( 300, 300, 1, 1 );

    let shadowMesh;
    shadowMesh = new THREE.Mesh( shadowGeo, shadowMaterial );
    shadowMesh.position.y = - 250;
    shadowMesh.rotation.x = - Math.PI / 2;
    scene.add( shadowMesh );

    // add the spirograph curve
    scene.add(curveGroup);
    updateCurve(0.3, 0.9);

    // add the airplane
    airplane.scale.set(0.005, 0.005, 0.005);
    airplane.rotation.set(0, 0, 0);
    airplane.position.set(0, 0, 10);
    scene.add(airplane);

    // add controls
    const controls = {
        k: 0.3,
        l: 0.9,
        update: () => {
            updateCurve(controls.k, controls.l);
        }
    }
    const gui = new dat.GUI();
    gui.add(controls, 'k', 0.0, 1.0, 0.01).onChange(controls.update);
    gui.add(controls, 'l', -1.0, 1.0, 0.01).onChange(controls.update);

    // configure the renderer
    renderer.setPixelRatio(devicePixelRatio);
    renderer.setSize(innerWidth, innerHeight);
    container.appendChild(renderer.domElement);
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

function render() {
    updateSize();

    // rotate the curve
    // curveGroup.rotateY(Math.PI / 300);

    for ( let i = 0; i < views.length; ++ i ) {
        const view = views[ i ];
        const camera = view.camera;

        const left = Math.floor( windowWidth * view.left );
        const bottom = Math.floor( windowHeight * view.bottom );
        const width = Math.floor( windowWidth * view.width );
        const height = Math.floor( windowHeight * view.height );

        renderer.setViewport( left, bottom, width, height );
        renderer.setScissor( left, bottom, width, height );
        renderer.setScissorTest( true );
        renderer.setClearColor( view.background );

        camera.aspect = width / height;
        camera.updateProjectionMatrix();

        renderer.render( scene, camera );
    }
}

function animate() {
    render();
    requestAnimationFrame( animate );
}

init();
animate();