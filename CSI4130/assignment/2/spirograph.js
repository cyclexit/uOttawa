let scene, renderer;

let mouseX = 0, mouseY = 0;

let windowWidth, windowHeight;

const views = [
    {
        left: 0,
        bottom: 0,
        width: 0.5,
        height: 1.0,
        background: new THREE.Color( 0.5, 0.5, 0.7 ),
        eye: [ 0, 0, 2000 ],
        up: [ 0, 1, 0 ],
        fov: 60,
        updateCamera: function ( camera, scene, mouseX ) {
            camera.position.x += mouseX * 0.05;
            camera.position.x = Math.max( Math.min( camera.position.x, 2000 ), - 2000 );
            camera.lookAt( scene.position );
        }
    },
    {
        left: 0.5,
        bottom: 0,
        width: 0.5,
        height: 1.0,
        background: new THREE.Color( 0.7, 0.5, 0.5 ),
        eye: [ 0, 2000, 0 ],
        up: [ 0, 0, 1 ],
        fov: 60,
        updateCamera: function ( camera, scene, mouseX ) {

            camera.position.x -= mouseX * 0.05;
            camera.position.x = Math.max( Math.min( camera.position.x, 2000 ), - 2000 );
            camera.lookAt( scene.position );

        }
    },
];

function init() {

    const container = document.getElementById( 'container' );

    for ( let i = 0; i < views.length; ++ i ) {
        const view = views[ i ];
        const camera = new THREE.PerspectiveCamera( view.fov, window.innerWidth / window.innerHeight, 1, 10000 );
        camera.position.fromArray( view.eye );
        camera.up.fromArray( view.up );
        view.camera = camera;
    }

    // create the scene
    scene = new THREE.Scene();

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
    scene.add( mesh );

    // create the renderer
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setPixelRatio( window.devicePixelRatio );
    renderer.setSize( window.innerWidth, window.innerHeight );
    container.appendChild( renderer.domElement );

    document.addEventListener( 'mousemove', onDocumentMouseMove );

}

function onDocumentMouseMove(event) {
    mouseX = ( event.clientX - windowWidth / 2 );
    mouseY = ( event.clientY - windowHeight / 2 );
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

    for ( let i = 0; i < views.length; ++ i ) {
        const view = views[ i ];
        const camera = view.camera;

        view.updateCamera( camera, scene, mouseX, mouseY );

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
