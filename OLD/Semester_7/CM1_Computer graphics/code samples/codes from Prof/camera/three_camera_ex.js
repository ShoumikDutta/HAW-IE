/*global dat, addAxes */

// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas});
renderer.setClearColor('black');    // set background color
renderer.setSize(window.innerWidth, window.innerHeight);

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth/window.innerHeight , 0.1, 100);
var camSize = 3;
// var camera = new THREE.OrthographicCamera(-camSize, camSize, -camSize, camSize, 0.1, 100);
camera.position.set(0,0,5);
camera.lookAt(scene.position);   // camera initially looks at origin

// resize callback to adjust aspect ration if canvas changes size.
window.addEventListener("resize", function() {
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth/window.innerHeight;
  camera.updateProjectionMatrix();
});



var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);

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
    gui.add(camCon, 'aspect', 0.5,1.5).onChange(updateCam);
    gui.add(camCon, 'near', 0.1, 5).onChange(updateCam);
    gui.add(camCon, 'far', 10, 50).onChange(updateCam);
    var lookAt = gui.addFolder('Look at');
    lookAt.add(camCon, 'x', -20, 20).onChange(updateCam);
    lookAt.add(camCon, 'y', -20, 20).onChange(updateCam);
    lookAt.add(camCon, 'z', -20, 20).onChange(updateCam);
});



// Create geometry
var geo = new THREE.SphereGeometry(1, 16, 16);
var mat = new THREE.MeshPhongMaterial({color: "white",
                                       wireframe:true,
                                       wireframeLinewidth:2} );
var obj = new THREE.Mesh(geo, mat);
scene.add(obj);
var speed = 3;
var speedVec = new THREE.Vector3(0,0,0);


// add mouse control for myBall
function speedChanger(event) {

  //event.preventDefault();
  //--------exercise from slide---------------
  var mat = camera.matrixWorld.clone();
  mat.setPosition(new THREE.Vector3());
  var vecx = new THREE.Vector3(1,0,0);
  vecx.applyMatrix4(mat);
  var vecy = new THREE.Vector3(0,1,0);
  vecy.applyMatrix4(mat);
  //------------------------------------------
  if(event.keyCode === 37) {  // Left
    //speedVec = new THREE.Vector3(-speed, 0, 0);
	speedVec = vecx.multiplyScalar(-speed);		//also part of the exercise
  } else if(event.keyCode === 38) {  // Up
    //speedVec = new THREE.Vector3(0, speed, 0);
	speedVec = vecy.multiplyScalar(speed);
  } else if(event.keyCode === 39) {  // Right
    //speedVec = new THREE.Vector3(speed, 0, 0);
	speedVec = vecx.multiplyScalar(speed);
  } else if(event.keyCode === 40) {  // Down
    //speedVec = new THREE.Vector3(0, -speed, 0);
	speedVec = vecy.multiplyScalar(-speed);
  }
}

document.addEventListener("keydown",speedChanger);
document.addEventListener("keyup", function(event) {
  speedVec = new THREE.Vector3(0,0,0);
});

// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );
var clock = new THREE.Clock();
//addAxes(scene);
function render() {
  requestAnimationFrame(render);
  var dt = clock.getDelta();

  // move ball
  obj.position.add(speedVec.clone().multiplyScalar(dt));

  controls.update();
  renderer.render(scene, camera);

}
render();
