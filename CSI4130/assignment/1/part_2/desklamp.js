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
var rotationRadianAngles = {
    x: Math.PI / 2,
    y: Math.PI / 2,
    z: 0
};
var cameraRotationRadius = 50;
camera.position.set(0, cameraRotationRadius, 0);
function rotateX() {
    
    camera.lookAt(0, 0, 0);
}
function rotateY() {
    camera.lookAt(0, 0, 0);
}
function rotateZ() {
    
    camera.lookAt(0, 0, 0);
}
cameraRotation.add(rotationRadianAngles, "x", 0, Math.PI * 2, 0.01).onChange(rotateX);
cameraRotation.add(rotationRadianAngles, "y", 0, Math.PI * 2, 0.01).onChange(rotateY);
cameraRotation.add(rotationRadianAngles, "z", 0, Math.PI * 2, 0.01).onChange(rotateZ);
cameraRotation.open();


// add the cylinder base
const lampBase = new THREE.Mesh(
    new THREE.CylinderGeometry(10, 10, 1, 32),
    new THREE.MeshMatcapMaterial({color: 0xd3e8f8})
);
scene.add(lampBase);

// add the cylinder lower arm
const cylinderLowerArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 10, 32),
    new THREE.MeshMatcapMaterial({color: 0xe4e6e4})
)
// cylinderLowerArm.position.set(-20, -30, 0);
// scene.add(cylinderLowerArm);

// add the cylinder upper arm
const cylinderUpperArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 10, 32),
    new THREE.MeshMatcapMaterial({color: 0xe4e6e4})
)
// cylinderUpperArm.position.set(20, -30, 0);
// scene.add(cylinderUpperArm);

// add 3 sphere joints
var lampJoins = [];
for (var i = 0; i < 3; ++i) {
    lampJoins.push(new THREE.Mesh(
        new THREE.SphereGeometry(5, 32, 32),
        new THREE.MeshMatcapMaterial({color: 0xd3e8f8})
    ));
    // lampJoins[i].position.set(i * 20, 0, 0);
    // scene.add(lampJoins[i]);
}

// add the cylinder upper lamp shade
const cylinderUpperLampShade = new THREE.Mesh(
    new THREE.CylinderGeometry(4, 4, 8, 64),
    new THREE.MeshMatcapMaterial({color: 0x9f4cc3})
);
// cylinderUpperLampShade.position.set(50, 30, 0);
// scene.add(cylinderUpperLampShade);

// add the cylinder lower lamp shade
const cylinderLowerLampShade = new THREE.Mesh(
    new THREE.CylinderGeometry(4, 8, 8, 64),
    new THREE.MeshMatcapMaterial({color: 0x9f4cc3})
);
// cylinderLowerLampShade.position.set(-50, -20, 0);
// scene.add(cylinderLowerLampShade);

// add the sphere bulb
const sphereBulb = new THREE.Mesh(
    new THREE.SphereGeometry(4, 64, 64),
    new THREE.MeshMatcapMaterial({color: 0xffe139})
);
// sphereBulb.position.set(-30, 0, 0);
// scene.add(sphereBulb);

// assemble the lamp

// start the animation
function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}
animate();
