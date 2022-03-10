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

// set the camera z-position
camera.position.z = 10;

// start the animation
function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}
animate();
