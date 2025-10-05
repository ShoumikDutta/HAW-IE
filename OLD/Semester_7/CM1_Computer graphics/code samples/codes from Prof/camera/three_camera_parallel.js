/*global dat */

// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas});
renderer.setClearColor('black');    // set background color
renderer.setSize(window.innerWidth, window.innerHeight);

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);

var camSize = 1.5;
var camera = new THREE.OrthographicCamera(-camSize, camSize, -camSize, camSize, 0.1, 100);
camera.position.set(0,0,10);
camera.lookAt(scene.position);   // camera initially looks at origin




// Create wireframe box
var geo = new THREE.BoxGeometry(1,1,2);
var mat = new THREE.MeshPhongMaterial({color: "white",
                                       wireframe:true,
                                       wireframeLinewidth:2} );
var obj = new THREE.Mesh(geo, mat);
scene.add(obj);

// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );
function render() {
  requestAnimationFrame(render);
  controls.update();
  renderer.render(scene, camera);

}
render();
