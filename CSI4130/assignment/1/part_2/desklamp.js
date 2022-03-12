// set-up
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(
    100, innerWidth / innerHeight, 0.1, 1000
);
const canvas = document.getElementById("webgl-canvas");
const renderer = new THREE.WebGLRenderer({
    antialias: true,
    canvas: canvas
});
renderer.setSize(innerWidth, innerHeight);
renderer.setPixelRatio(devicePixelRatio);
window.addEventListener("resize", () => {
    // update camera
    camera.aspect = innerWidth / innerHeight;
    camera.updateProjectionMatrix();
    // update canvas
    canvas.width = innerWidth;
    canvas.height = innerHeight;
    renderer.setSize(innerWidth, innerHeight);
});

// 3.2: dat.gui control camera rotation
const gui = new dat.GUI();
const cameraRotation = gui.addFolder("Camera Rotation");
var sphereCoordinate = {
    radius: 50,
    theta: 90, // angle from y positive
    phi: 0 // angle from x positive on XOY plane
};
function updateCamera() {
    var {radius, theta, phi} = sphereCoordinate;
    theta = theta * Math.PI / 180;
    phi = phi * Math.PI / 180;
    camera.position.x = radius * Math.sin(theta) * Math.sin(phi);
    camera.position.y = radius * Math.cos(theta);
    camera.position.z = radius * Math.sin(theta) * Math.cos(phi);
    camera.lookAt(0, 0, 0);
}
cameraRotation.add(sphereCoordinate, "radius", 20, 100, 1).listen();
cameraRotation.add(sphereCoordinate, "theta", 0, 180, 1).listen();
cameraRotation.add(sphereCoordinate, "phi", 0, 360, 1).listen();
cameraRotation.open();

// 3.1: create the lamp
// create 3 sphere joints
var lampJoins = [];
for (var i = 0; i < 3; ++i) {
    lampJoins.push(new THREE.Mesh(
        new THREE.SphereGeometry(2, 32, 32),
        new THREE.MeshMatcapMaterial({color: 0xd3e8f8})
    ));
}

// add the cylinder base
const lampBase = new THREE.Mesh(
    new THREE.CylinderGeometry(10, 10, 2, 32),
    new THREE.MeshMatcapMaterial({color: 0xd3e8f8})
);
scene.add(lampBase);

// add the join 0
lampJoins[0].position.set(0, 2, 0);
scene.add(lampJoins[0]);

// add the cylinder lower arm
const lampLowerArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 15, 32),
    new THREE.MeshMatcapMaterial({color: 0xe4e6e4})
)
lampLowerArm.position.set(0, 10, 0);
scene.add(lampLowerArm);

// add the join 1
lampJoins[1].position.set(0, 18, 0);
scene.add(lampJoins[1]);

// add the cylinder upper arm
const lampUpperArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 10, 32),
    new THREE.MeshMatcapMaterial({color: 0xe4e6e4})
);
lampUpperArm.position.set(0, 24, 0);
lampUpperArm.geometry.translate(0, 5, 0);
lampUpperArm.rotateX(Math.PI / 4);
lampUpperArm.geometry.translate(0, -5, 5 / Math.sqrt(2) + Math.sqrt(2) / 2);
// lampUpperArm.lookAt(lampJoins[1].position);
scene.add(lampUpperArm);

// add the join 2
lampJoins[2].position.set(0, 18 + 10 / Math.sqrt(2), 10 / Math.sqrt(2));
scene.add(lampJoins[2]);
    
// add the cylinder upper lamp shade
const lampUpperShade = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 8, 64),
    new THREE.MeshMatcapMaterial({color: 0xcadfef})
);
lampUpperShade.position.set(0, 18 + 10 / Math.sqrt(2), 10 / Math.sqrt(2));
lampUpperShade.translateZ(1);
lampUpperShade.rotateX(-(Math.PI / 4));
scene.add(lampUpperShade);

// add the cylinder lower lamp shade
const lampLowerShade = new THREE.Mesh(
    new THREE.CylinderGeometry(4, 8, 8, 64),
    new THREE.MeshMatcapMaterial({color: 0x9f4cc3})
);
// lampLowerShade.position.set(-50, -20, 0);
// scene.add(lampLowerShade);

// add the sphere bulb
const sphereBulb = new THREE.Mesh(
    new THREE.SphereGeometry(4, 64, 64),
    new THREE.MeshMatcapMaterial({color: 0xffe139})
);
// sphereBulb.position.set(-30, 0, 0);
// scene.add(sphereBulb);

// start the animation
function animate() {
    requestAnimationFrame(animate);
    updateCamera();
    renderer.render(scene, camera);
}
animate();
