// ==========================================================================
// $Id: solar_skel.js,v 1.1 2019/01/24 02:03:26 jlang Exp $
// Solar lab scene with Three.js 
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
// Creator: Jochen Lang and Pooja Mamidala
// Email:   jlang@uottawa.ca
// ==========================================================================
// $Log: solar_skel.js,v $
// Revision 1.1  2019/01/24 02:03:26  jlang
// added starter code
//
// Revision 1.1  2019/01/23 04:17:50  jlang
// Created solar system with input from Pooja.
//
// ========================================================================== 

// initialization of Three.js
function init() {
    // Check if WebGL is available see Three/examples
    // No need for webgl2 here - change as appropriate
    // if (WEBGL.isWebGLAvailable() === false) {
    //     // if not print error on console and exit
    //     document.body.appendChild(WEBGL.getWebGLErrorMessage());
    // }
    // add our rendering surface and initialize the renderer
    var container = document.createElement('div');
    document.body.appendChild(container);
    // WebGL2 examples suggest we need a canvas
    // canvas = document.createElement( 'canvas' );
    // var context = canvas.getContext( 'webgl2' );
    // var renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
    renderer = new THREE.WebGLRenderer();
    // set some state - here just clear color
    renderer.setClearColor(new THREE.Color(0x333333));
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);


    // All drawing will be organized in a scene graph
    var scene = new THREE.Scene();

    // show axes at the origin
    var axes = new THREE.AxesHelper(10);
    scene.add(axes);

    // Solar system group
    var solar = new THREE.Group();
    scene.add(solar)
    // sun is a child
    var faceMaterial = new THREE.MeshBasicMaterial({ color: 'yellow' });
    var sphereGeometry = new THREE.SphereGeometry(5, 32, 32);
    var sun = new THREE.Mesh(sphereGeometry, faceMaterial);
    // position the sun - center
    sun.position.set(0, 0, 0);
    // add the sun to the scene
    solar.add(sun);
    
    // earth and group
    var earthGroup = new THREE.Group()
    earthGroup.position.set(15, 0, 0);
    solar.add(earthGroup)
    
    var faceMaterial_earth = new THREE.MeshBasicMaterial({ color: 'blue' });
    var sphereGeometry_earth = new THREE.SphereGeometry(2, 8, 8);
    var earth = new THREE.Mesh(sphereGeometry_earth, faceMaterial_earth);
    // add the earth to the scene
    earthGroup.add(earth)

    // Adding teapot to the earth
    var teapotGeometry = new THREE.TeapotGeometry(1, 15, true, true, true, false, false);
    var teapot = new THREE.Mesh(teapotGeometry, new THREE.MeshBasicMaterial({ color: 'pink' }));
    earthGroup.add(teapot);

    // saturn and group

    // position the saturn relative to sun but offset 30deg rel to earth

    
    var faceMaterial_saturn = new THREE.MeshBasicMaterial({ color: 'saddlebrown' });
    var sphereGeometry_saturn = new THREE.SphereGeometry(3, 16, 16);
    var saturn = new THREE.Mesh(sphereGeometry_saturn, faceMaterial_saturn);
    // add saturn - saturn rotates around sun


    // Adding a ring around saturn
    torusGeometry= new THREE.TorusGeometry(4, 0.5, 32, 16);
    var torus = new THREE.Mesh(torusGeometry,
			       new THREE.MeshBasicMaterial({ color: 'dimgray' }));
    // squish it (scale)
    
    // Create Moon with 15 deg offest to torus ring
    var faceMaterial_moon = new THREE.MeshBasicMaterial({ color: 'wheat' });
    var sphereGeometry_moon = new THREE.SphereGeometry(0.5, 8, 8);
    var moon = new THREE.Mesh(sphereGeometry_moon, faceMaterial_moon);
    


    
    // need a camera to look at things
    // calcaulate aspectRatio
    var aspectRatio = window.innerWidth / window.innerHeight;
    var width = 20;
    // Camera needs to be global
    camera = new THREE.PerspectiveCamera(45, aspectRatio, 1, 1000);
    // position the camera back and point to the center of the scene
    camera.position.z = 100;
    camera.lookAt(scene.position);

    // render the scene
    renderer.render(scene, camera);

    //declared once at the top of your code
    var camera_axis = new THREE.Vector3(-30,30,30).normalize(); // viewing axis
    
    // setup the control gui
    var controls = new function () {
	this.speed = -10
        this.redraw = function () {
        };
    };


    var gui = new dat.GUI();
    gui.add(controls, 'speed', -15, -1).onChange(controls.redraw);
    render();

    
    function render() {
        // render using requestAnimationFrame - register function
        requestAnimationFrame(render);
	speed = 2 ** controls.speed
	// earth group rotates arond sun

	// Teapot has to compensate to stay on top of earth

	// saturn group rotates arond sun

	// saturn ring and moon rotate around saturn


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







