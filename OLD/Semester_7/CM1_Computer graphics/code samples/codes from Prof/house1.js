/*global createRoofGeo */

// Create a maze

//* Initialize webGL with camera and lights
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('rgb(255,255,255)');
// create scene and camera
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight,
                                         0.1, 1000);
camera.position.z = 10;

var ambientLight = new THREE.AmbientLight(0x909090);
scene.add(ambientLight);
var light = new THREE.DirectionalLight(0x444444);
light.position.set( 1.5,1,1 );
scene.add(light);


//* Build the house

// Build the house
var width = 1;
var len = 2;
var height = 0.8;


// Add the body to the house
var house = new THREE.Object3D();
house.position.x = 2;


var bodyMat = new THREE.MeshPhongMaterial({color: "gray",
                                           side:THREE.DoubleSide} );
// transparent body for debugging:
// bodyMat.transparent = true;
// bodyMat.opacity = 0.3;
var bodyGeo = new THREE.BoxGeometry(width,height,len);
var body = new THREE.Mesh(bodyGeo, bodyMat);
body.position.y = height/2 + 0.0001;
scene.add(body);

// Add the roof
var roofMat = new THREE.MeshPhongMaterial({color: "red",
                                           side:THREE.DoubleSide} );
var roofGeo = createRoofGeo(1.1*len,1.2*width,0.5*height);
var roof = new THREE.Mesh(roofGeo, roofMat);
roof.position.y = height;
scene.add(roof);

// Add the ground
var groundMat = new THREE.MeshPhongMaterial({color:"green",
                                             side:THREE.DoubleSide} );
groundMat.transparent = true;
groundMat.opacity = 0.5;
var groundGeo = new THREE.PlaneGeometry(20,20);
var ground = new THREE.Mesh(groundGeo, groundMat);
ground.rotation.x = -Math.PI/2;
scene.add(ground);


addAxes(scene);
//* Render loop
var controls = new THREE.TrackballControls( camera, canvas );
controls.rotateSpeed = 2;

function render() {
  requestAnimationFrame(render);

  controls.update();
  renderer.render(scene, camera);
}

render();









