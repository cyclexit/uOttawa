// ==========================================================================
// $Id: shapes.js,v 1.2 2019/01/12 19:52:51 jlang Exp $
// First lab scene with Three.js 
// ==========================================================================
// (C)opyright:
//
//    Jochen Lang
//    EECS, University of Ottawa
//    800 King Edward Ave.
//    Ottawa, On., K1N 6N5
//    Canada.
//    http:www.eecs.uottawa.ca
//
// Creator: jlang (Jochen Lang)
// Email:   jlang@uottawa.ca
// ==========================================================================
// $Log: shapes.js,v $
// Revision 1.2  2019/01/12 19:52:51  jlang
// Lab 0 solution; animation, resizing, various geometries
//
// ========================================================================== 
 
// initialization of Three.js
function init() {
	// Check if WebGL is available see Three/examples
	// No need for webgl2 here - change as appropriate
    if ( WEBGL.isWebGLAvailable() === false ) {
		// if not print error on console and exit
    	document.body.appendChild( WEBGL.getWebGLErrorMessage() );
    }
	// add our rendering surface and initialize the renderer
    var container = document.createElement( 'div' );
    document.body.appendChild( container );
	// WebGL2 examples suggest we need a canvas
    // canvas = document.createElement( 'canvas' );
    // var context = canvas.getContext( 'webgl2' );
    // var renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
	renderer = new THREE.WebGLRenderer( );
    // set some state - here just clear color
    renderer.setClearColor(new THREE.Color(0x333333));
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);
    
	
    // All drawing will be organized in a scene graph
    var scene = new THREE.Scene();
	
    // show axes at the origin
    var axes = new THREE.AxesHelper(10);
    scene.add(axes);
	
    // put a plane on the ground 
	// 20 wide, 40 deep - this is x/y
    var planeGeometry = new THREE.PlaneGeometry(20, 40);
    var planeMaterial = new THREE.MeshBasicMaterial({color: 0x55cc00, side: THREE.DoubleSide});
    var plane = new THREE.Mesh(planeGeometry, planeMaterial);
    // now rotate the plane such that it is on the ground
	// let's use Euler angles
    plane.rotation.x = -0.5 * Math.PI;
	// first position than rotation
    plane.position.set( 0, -0.5, 0.0 );
    // add the plane to the scene
    scene.add(plane);
	
    // Put four objects in the corners at a distance 5, 5 from the change
	// cube of size 1
    var cubeGeometry = new THREE.BoxGeometry(1, 1, 1);
	// Use two materials to see the wireframe (edges of the triangles) and a face color
    // Need to duplicate mesh and put it in a group
	var cubeGroup = new THREE.Group();
    var faceMaterial = new THREE.MeshBasicMaterial({color: 'tan'});
	cubeGroup.add( new THREE.Mesh( cubeGeometry, faceMaterial ) );
	var wireMaterial = new THREE.MeshBasicMaterial({color: 'black', wireframe: true});
	cubeGroup.add( new THREE.Mesh( cubeGeometry, wireMaterial ) );
    // position the cube - left front
    cubeGroup.position.set( -5, 0, 5 );
    // add the cube to the scene
    scene.add(cubeGroup);
	// cylinder of radius 0.25 and height 1 and 64 segments
    var cylGeometry = new THREE.CylinderGeometry(0.25, 0.25, 1, 64);
	// Use the same two materials to see the wireframe (edges of the triangles) and a face color
	var cylinder = 	new THREE.Mesh(cylGeometry, faceMaterial);
    // position the cylinder - left rear
    cylinder.position.set( -5, 0, -5 );
    // add the cylinder to the scene
    scene.add(cylinder);
	// dodecahedron of radius 1 
    var dodGeometry = new THREE.DodecahedronGeometry(1);
	// Use the same two materials to see the wireframe (edges of the triangles) and a face color
	var dod = new THREE.Mesh(dodGeometry, faceMaterial);
    // position the dodecahedron - right rear
    dod.position.set( 5, 0, -5 );
    // add the dodecahedron to the scene
    scene.add(dod);
	// Finally add a sphere
    var sphereGeometry = new THREE.SphereGeometry(1, 20, 20);
    var sphere = new THREE.Mesh(sphereGeometry,faceMaterial);
    // position the sphere - right front
    sphere.position.set( 5, 0, 5 );
    // add the dodecahedron to the 
    // add the sphere to the scene
    scene.add(sphere);


	// Add a spinning donut
    var torusGeometry = new THREE.TorusGeometry(0.8, 0.1, 64, 16 );
    var torus = new THREE.Mesh(torusGeometry, 
						new THREE.MeshBasicMaterial({color: 'cadet blue'}));
    // position the torus up
    torus.position.set( 0, 5, 0 );
    // add the dodecahedron to the 
    // add the sphere to the scene
    scene.add(torus);

	
	
	// need a camera to look at things
	// calcaulate aspectRatio
	var aspectRatio = window.innerWidth/window.innerHeight;
	var width = 20;
	// The orthographic camera seems to have its axes changed from WebGL
    // var camera = new THREE.OrthographicCamera( -width/2, width/2, aspectRatio*width/2, -aspectRatio*width/2,  -10*width/2, 10*width/2);
	// Camera needs to be global
	camera = new THREE.PerspectiveCamera(45, aspectRatio, 1, 1000);
    // position the camera back and point to the center of the scene
    camera.position.set( 0, width, width ); 
	// at 0 0 0 on the scene
    camera.lookAt(scene.position); 

	
	
    // render the scene
    renderer.render(scene, camera);

    // setup the control gui
    var controls = new function () {
        this.radius = sphere.geometry.parameters.radius;

        this.redraw = function () {
        // remove the old sphere
	    var tmp = sphere.position.clone();
        scene.remove(sphere);
        // create a new one
	    sphere = new THREE.Mesh(new THREE.SphereGeometry(controls.radius, 20, 20),
			faceMaterial);
	    sphere.position.copy(tmp);
        // add it to the scene.
        scene.add(sphere);
        };
    };


    var gui = new dat.GUI();
    gui.add(controls, 'radius', 0.1, 10).onChange(controls.redraw);
    render();


    function render() {
		// render using requestAnimationFrame - register function
		requestAnimationFrame(render);
		torus.rotation.y = (torus.rotation.y + 0.1) % Math.PI;
		renderer.render(scene, camera);
    }

 }

function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
	// If we use a canvas then we also have to worry of resizing it
	renderer.setSize(window.innerWidth, window.innerHeight);
}
 
window.onload = init;
	
// register our resize event function
window.addEventListener('resize', onResize, true);



