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
var rotationAngles = {
    x: 90,
    y: 90,
    z: 0
};
var rotationRadius = 50;
camera.position.set(0, 0, rotationRadius);
function rotateX() {
    var x = camera.position.x, y= camera.position.y, z = camera.position.z;
    var angle = rotationAngles.x * Math.PI / 180;
    camera.position.x = x;
    camera.position.y = Math.cos(angle) * y - Math.sin(angle) * z;
    camera.position.z = Math.sin(angle) * y + Math.cos(angle) * z;
    camera.lookAt(0, 0, 0);
}
function rotateY() {
    var x = camera.position.x, y= camera.position.y, z = camera.position.z;
    var angle = rotationAngles.y * Math.PI / 180;
    camera.position.x = Math.cos(angle) * x + Math.sin(angle) * z;
    camera.position.y = y;
    camera.position.z = -Math.sin(angle) * x + Math.cos(angle) * z;
    camera.lookAt(0, 0, 0);
}
function rotateZ() {
    var x = camera.position.x, y= camera.position.y, z = camera.position.z;
    var angle = rotationAngles.z * Math.PI / 180;
    camera.position.x = Math.cos(angle) * x - Math.sin(angle) * y;
    camera.position.y = Math.sin(angle) * x + Math.cos(angle) * y;
    camera.position.z = z;
    camera.lookAt(0, 0, 0);
}
cameraRotation.add(rotationAngles, "x", 0, 360, 1).onChange(rotateX);
cameraRotation.add(rotationAngles, "y", 0, 360, 1).onChange(rotateY);
cameraRotation.add(rotationAngles, "z", 0, 360, 1).onChange(rotateZ);
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

// start the animation
function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}
animate();
