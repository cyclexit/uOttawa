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
var curveMesh;

let windowWidth, windowHeight;

// class
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

    // create shadow
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

    // add the object
    const radius = 200;
    const geometry1 = new THREE.IcosahedronGeometry( radius, 1 );
    const count = geometry1.attributes.position.count;
    geometry1.setAttribute( 'color', new THREE.BufferAttribute( new Float32Array( count * 3 ), 3 ) );

    const color = new THREE.Color();
    const positions1 = geometry1.attributes.position;
    const colors1 = geometry1.attributes.color;
    for ( let i = 0; i < count; i ++ ) {
        color.setHSL( ( positions1.getY( i ) / radius + 1 ) / 2, 1.0, 0.5 );
        colors1.setXYZ( i, color.r, color.g, color.b );
    }

    const material = new THREE.MeshPhongMaterial( {
        color: 0xffffff,
        flatShading: true,
        vertexColors: true,
        shininess: 0
    } );
    const wireframeMaterial = new THREE.MeshBasicMaterial( { color: 0x000000, wireframe: true, transparent: true } );
    mesh = new THREE.Mesh( geometry1, material );
    wireframe = new THREE.Mesh( geometry1, wireframeMaterial );
    mesh.add( wireframe );
    // scene.add( mesh );

    // add the curve 
    scene.add(curveGroup);
    updateCurve(0.3, 0.9);

    // configure the renderer
    renderer.setPixelRatio(devicePixelRatio);
    renderer.setSize(innerWidth, innerHeight);
    container.appendChild(renderer.domElement);
}

function updateCurve(k, l) {
    curveGroup.remove(curveMesh);
    // TODO: use the value from dat.gui
    var curvePath = new MyCurve(k, l);
    var curveGeometry = new THREE.TubeGeometry(curvePath, 100, 1, 100, false);
    curveMesh = new THREE.Mesh(curveGeometry, new THREE.MeshPhongMaterial({color: 0x6495ED}));
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
    curveGroup.rotateY(Math.PI / 300);

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
