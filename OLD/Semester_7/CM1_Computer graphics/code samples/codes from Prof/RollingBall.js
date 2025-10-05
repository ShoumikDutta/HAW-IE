/*global addAxes, dat, THREE */

//* Initialize webGL
var canvas = document.getElementById("myCanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas});
renderer.setClearColor('rgb(255, 255, 255)');    // set background color

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 45, canvas.width / canvas.height,
                                          0.1, 1000 );
camera.position.set(20,10,20);
camera.lookAt(scene.position);

var light = new THREE.PointLight();
scene.add( light );
scene.add(new THREE.AmbientLight(0xffffff));


//* Add floor
var floorX = 20;
var floorZ = 20;
var floorMesh = new THREE.Mesh(new THREE.PlaneBufferGeometry(floorX, floorZ, 20, 20),
                               new THREE.MeshBasicMaterial({wireframe:true,
                                                            color:0x000000,
                                                            side:THREE.DoubleSide}));
floorMesh.rotation.x = Math.PI/2;
scene.add(floorMesh);
var floor = new THREE.Mesh(new THREE.PlaneBufferGeometry(floorX, floorZ, 20, 20),
                           new THREE.MeshBasicMaterial({wireframe:false,
                                                        color:0x505050,
                                                        side:THREE.DoubleSide}));
floor.material.transparent = true;
floor.material.opacity = 0.5;
floor.rotation.x = Math.PI/2;
scene.add(floor);

addAxes(scene);

//* Add ball
var ballRadius = 2;
var ballGeo = new THREE.SphereGeometry(ballRadius, 8, 8);
var ball = new THREE.Mesh(ballGeo,  new THREE.MeshBasicMaterial( {color: 0x0000ff,
                                                                  wireframe:true}));
// initialize position
var currentPos = new THREE.Vector3(0,  ballRadius, -floorZ/2);

scene.add(ball);
var ballSpeed = new THREE.Vector3(5*Math.random(), 0, 5*Math.random());
var rotAxis = new THREE.Vector3(0,1,0);
rotAxis.cross(ballSpeed.clone()).normalize();	//clone is not necessary here
var omega = ballSpeed.length()/ballRadius;
ball.matrixAutoUpdate = false;		//prevent overwriting our matrix


//* Render loop
var computerClock = new THREE.Clock();
var controls = new THREE.TrackballControls( camera );

function render() {
  requestAnimationFrame(render);

  var dt = computerClock.getDelta();  // must be before call to getElapsedTime, otherwise dt=0 !!!
  var t = computerClock.getElapsedTime();
  
  // Motion along a straight line:
  currentPos.add(ballSpeed.clone().multiplyScalar(dt));		//p+v*dt for speed changes; v*t for constant speed
  
  var transMat = new THREE.Matrix4();
  transMat.makeTranslation(currentPos.x, currentPos.y, currentPos.z);
  
  var rotMat = new THREE.Matrix4();
  rotMat.makeRotationAxis(rotAxis, omega*t);
  
  ball.matrix.copy(transMat);
  ball.matrix.multiply(rotMat);
  
  if(Math.abs(currentPos.x)>floorX/2-ballRadius){
		ballSpeed.x *= -1;
		rotAxis = new THREE.Vector3(0,1,0);
		rotAxis.cross(ballSpeed.clone()).normalize();
  }

  controls.update();
  renderer.render(scene, camera);
}
render();
