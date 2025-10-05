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


var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight ,
                                          0.1, 100);
camera.position.set(0,0,5);
camera.lookAt(scene.position);   // camera initially looks at origin


window.addEventListener("resize", function() {
  console.log("Hallo");
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth/window.innerHeight;
  camera.updateProjectionMatrix();
});

// Add dat.gui for camera control,
// see http://workshop.chromeexperiments.com/examples/gui/#1--Basic-Usage
var CameraController = function() {
  this.fov = 75;
  this.near = 0.1;
  this.far = 50;
  this.x = 0;
  this.y = 0;
  this.z = 0;
  this.aspect = camera.aspect;
};

var camCon = new CameraController();
function updateCam() {
  camera.fov = camCon.fov;
  camera.near = camCon.near;
  camera.far = camCon.far;
  camera.aspect = camCon.aspect;
  camera.lookAt(new THREE.Vector3(camCon.x, camCon.y, camCon.z));
  // Necessary, because mouse control internally calls camera.lookAt
  controls.target.set(camCon.x, camCon.y, camCon.z);
  camera.updateProjectionMatrix();
}
window.addEventListener("load", function() {
  var gui = new dat.GUI();
  gui.add(camCon, 'fov', 25, 120).onChange(updateCam);
  var asp = gui.add(camCon, 'aspect', 0.1,5);
  asp.onChange(updateCam);
  asp.listen();
  gui.add(camCon, 'near', 0.1, 5).onChange(updateCam);
  gui.add(camCon, 'far', 10, 50).onChange(updateCam);
  var lookAt = gui.addFolder('Look at');
  lookAt.add(camCon, 'x', -20, 20).onChange(updateCam);
  lookAt.add(camCon, 'y', -20, 20).onChange(updateCam);
  lookAt.add(camCon, 'z', -20, 20).onChange(updateCam);
});



// Create wireframe box
var radius = 1/2;
var geo = new THREE.SphereGeometry(radius,16,16);
var mat = new THREE.MeshPhongMaterial({color: "white",
                                       wireframe:true,
                                       wireframeLinewidth:2} );
var v = new THREE.Vector3(1,0,0);

// Combine geometry and material to a new object:
var obj = new THREE.Mesh(geo, mat);
scene.add(obj);
var posInCam;
// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );
var clock = new THREE.Clock();
function render() {
  requestAnimationFrame(render);
  var dt = clock.getDelta();
  obj.position.add(v.clone().multiplyScalar(dt));

  posInCam = obj.position.clone();
  posInCam.applyMatrix4(camera.matrixWorldInverse);
  var zc= Math.abs(posInCam.z);
  var hc = 2 * zc * Math.tan(Math.PI/180 * camera.fov/2);
  var wc = camera.aspect * hc;

  if(posInCam.x >= (wc/2 - radius)) v.x = - Math.abs(v.x);   // left bounce
  if(posInCam.x <= (-wc/2 - radius)) v.x =  Math.abs(v.x);  // right bounce

  controls.update();
  renderer.render(scene, camera);

}
render();
