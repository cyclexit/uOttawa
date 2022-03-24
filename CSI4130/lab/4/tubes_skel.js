// ==========================================================================
// $Id: tubes.js,v 1.2 2019/02/03 03:55:34 jlang Exp $
// Curve animation with Three.js
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
// $Log: tubes.js,v $
// Revision 1.2  2019/02/03 03:55:34  jlang
// Added starter code.
//
// Revision 1.1  2019/02/03 03:43:07  jlang
// Created lab3 solution
//
// ==========================================================================

// global variables
var camera, renderer;

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
    // add the output of the renderer to the html element
    container.appendChild(renderer.domElement);

    function jet(value) {
        var ret = new THREE.Color(0,0,0);
        // 007FFF
        // 7FFF7F
        // FF7F00
        // 7F0000
        ret.r = (value < 0.666 ) ? 1.5 * value : 2-1.5*value;
        ret.g = (value > 0.333 ) ? 1.5-1.5*value : 1.5*value+0.5;
        ret.b = (value < 0.666 ) ? 1-1.5*value : 0;
        return ret;
    }

    // create an implicit object
    var implicit = new function() {
        // plane normal
        this.norm = new THREE.Vector3(1,1,0);
        this.norm.normalize();
        // normal distance from origin
        this.d = 0.5;
        // signed distance from plane
        this.planeDistance = function(pos) {
            // dist = n.dot(p) + d
            return this.norm.dot(pos)+this.d;
        }
    }

    // All drawing will be organized in a scene graph
    var scene = new THREE.Scene();
    // A camera with fovy = 90deg means the z distance is y/2
    szScreen = 5;

    // show axes at the origin
    var axes = new THREE.AxesHelper(10);
    scene.add(axes);

    // lissajous group
    var lissajousGroup = new THREE.Group();
    scene.add(lissajousGroup)

    // // extend THREE.Curve
    class lissajousCurve extends THREE.Curve {
        constructor(aSpeed, bSpeed, delta, scale) {
            super();
            this.aSpeed = ( aSpeed === undefined ) ? 1 : aSpeed;
            this.bSpeed = ( bSpeed === undefined ) ? 1 : bSpeed;
            this.delta = ( delta === undefined ) ? 0 : delta;
            this.scale = ( scale === undefined ) ? 1 : scale;
        }
    }

    lissajousCurve.prototype = Object.create( THREE.Curve.prototype );
    lissajousCurve.prototype.constructor = lissajousCurve;

    lissajousCurve.prototype.getPoint = function ( t ) {
        var tx = Math.cos( this.aSpeed * 2 * t * Math.PI + this.delta);
        var ty = Math.sin( this.bSpeed * 2 * t * Math.PI );
        var tz = Math.cos( 2 * t * Math.PI );
        return new THREE.Vector3( tx, ty, tz ).multiplyScalar( this.scale );
    };

    // setup the controls
    controls = new function () {
        this.speed = -10;
        this.segments = 100;
        this.radius = 0.1;
        this.radialSegments = 8;
        this.update = function() {
            updateLissajous(Math.round(controls.segments), controls.radius, Math.round(controls.radialSegments));
        };
        this.redraw = function() {
        };
    };

    function updateLissajous(segments,radius,radialSegments ) {
        lissajousGroup.remove( lissajousMesh );
        var lissaPath = new lissajousCurve( 5, 4 );
        var geometry = new THREE.TubeGeometry( lissaPath, segments, radius, radialSegments, false );

        // Loop over all vertices and update their color based on the distance to the plane
        var pt = new THREE.Vector3();
        var dCol = function ( nId ) {
        // var dist = geometry.vertices[nId].distanceTo(pt);
            var dist = implicit.planeDistance(geometry.vertices[nId]);
            return jet(Math.abs(dist)/(Math.sqrt(2)));
        }
        for (var i = 0; i < geometry.faces.length; i++) {
            geometry.faces[i].vertexColors = [dCol(geometry.faces[i].a),
                        dCol(geometry.faces[i].b),
                        dCol(geometry.faces[i].c)];
        }
        geometry.colorsNeedUpdate = true;
        // Select vertex coloring
        var vertColMat = new THREE.MeshBasicMaterial({vertexColors: THREE.VertexColors});
        lissajousMesh = new THREE.Mesh( geometry, vertColMat );
        lissajousGroup.add( lissajousMesh );
    }

    // create a dummy node
    lissajousMesh = new THREE.Group();
    updateLissajous(controls.segments,controls.radius,controls.radialSegments);

    // need a camera to look at things
    // calcaulate aspectRatio
    var aspectRatio = window.innerWidth / window.innerHeight;
    // Camera needs to be global
    camera = new THREE.PerspectiveCamera(90, aspectRatio, 0.5, 10);
    // position the camera back and point to the center of the scene
    camera.position.z = szScreen/2;
    camera.lookAt(scene.position);

    // render the scene
    renderer.render(scene, camera);

    var gui = new dat.GUI();
    gui.add(controls, 'speed', -15, -1).onChange(controls.redraw);
    gui.add(controls, 'segments', 10, 500).onChange(controls.update);
    gui.add(controls, 'radialSegments', 3, 20).onChange(controls.update);
    gui.add(controls, 'radius', 0.01, 2.0).onChange(controls.update);
    render();

    function render() {
        // render using requestAnimationFrame - register function
        requestAnimationFrame(render);
        speed = 2 ** controls.speed
        // spin lissajous in y
        lissajousGroup.rotation.y = (lissajousGroup.rotation.y + speed) % (2.0 * Math.PI);
        // Traditional lissajous animation by cycling delta
        // not really efficient in this way as every frame we create a new Mesh
        // lissaPath.delta = lissaPath.delta + speed;
        // lissajousGroup.remove(lissajousMesh);
        // geometry = new THREE.TubeGeometry( lissaPath, 50, 0.1, 8, false );
        // lissajousMesh = new THREE.Mesh( geometry, vertColMaterial );
        // lissajousGroup.add( lissajousMesh );
        renderer.render(scene, camera);
    }

}

function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    // If we use a canvas then we also have to worry of resizing it
    renderer.setSize(window.innerWidth, window.innerHeight);
}

init();

// register our resize event function
window.addEventListener('resize', onResize, true);
