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

// add the cylinder base
const cylinderBase = new THREE.Mesh(
    new THREE.CylinderGeometry(5, 5, 1, 32),
    new THREE.MeshBasicMaterial({color: 0xd3e8f8})
);
cylinderBase.position.set(0, 20, 0);
scene.add(cylinderBase);

// add the cylinder lower arm
const cylinderLowerArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 10, 32),
    new THREE.MeshBasicMaterial({color: 0xe4e6e4})
)
cylinderLowerArm.position.set(-20, -30, 0);
scene.add(cylinderLowerArm);

// add the cylinder upper arm
const cylinderUpperArm = new THREE.Mesh(
    new THREE.CylinderGeometry(2, 2, 10, 32),
    new THREE.MeshBasicMaterial({color: 0xe4e6e4})
)
cylinderUpperArm.position.set(20, -30, 0);
scene.add(cylinderUpperArm);

// add 3 sphere joints
var sphereJoins = [];
for (var i = 0; i < 3; ++i) {
    sphereJoins.push(new THREE.Mesh(
        new THREE.SphereGeometry(5, 32, 32),
        new THREE.MeshBasicMaterial({color: 0xd3e8f8})
    ));
    sphereJoins[i].position.set(i * 20, 0, 0);
    scene.add(sphereJoins[i]);
}

// add the cylinder upper lamp shade
const cylinderUpperLampShade = new THREE.Mesh(
    new THREE.CylinderGeometry(4, 4, 8, 64),
    new THREE.MeshBasicMaterial({color: 0x9f4cc3})
);
cylinderUpperLampShade.position.set(50, 30, 0);
scene.add(cylinderUpperLampShade);

// add the cylinder lower lamp shade
const cylinderLowerLampShade = new THREE.Mesh(
    new THREE.CylinderGeometry(4, 8, 8, 64),
    new THREE.MeshBasicMaterial({color: 0x9f4cc3})
);
cylinderLowerLampShade.position.set(-50, -20, 0);
scene.add(cylinderLowerLampShade);

// add the sphere bulb
const sphereBulb = new THREE.Mesh(
    new THREE.SphereGeometry(4, 64, 64),
    new THREE.MeshBasicMaterial({color: 0xffe139})
);
sphereBulb.position.set(-30, 0, 0);
scene.add(sphereBulb);

// set the camera z-position
camera.position.z = 50;

// start the animation
function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}
animate();
