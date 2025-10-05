// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setClearColor('yellow');    // set background color

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set(0,0,3);
camera.lookAt(scene.position);   // camera looks at origin
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);


// Create geometry
var geo = new THREE.Geometry();
geo.vertices[0] = new THREE.Vector3(1,1,0);
geo.vertices[1] = new THREE.Vector3(-1,1,0);
geo.vertices[2] = new THREE.Vector3(-1,-1,0);
geo.vertices[3] = new THREE.Vector3(1,-1,0);
geo.vertices[4] = new THREE.Vector3(1/2,0,1);
geo.vertices[5] = new THREE.Vector3(-1/2,0,1);
geo.faces[0] = new THREE.Face3(0,2,1);
geo.faces[1] = new THREE.Face3(0,3,2);
geo.faces[2] = new THREE.Face3(0,4,3);
geo.faces[3] = new THREE.Face3(1,2,5);
geo.faces[4] = new THREE.Face3(0,1,5);
geo.faces[5] = new THREE.Face3(0,5,4);
geo.faces[6] = new THREE.Face3(2,3,4);
geo.faces[7] = new THREE.Face3(2,4,5);

// material specifies how triangle looks like
var mat = new THREE.MeshPhongMaterial({color: "white",
                                       wireframe:true,
                                       wireframeLinewidth:2} );	//wireframe shows only edges of object when true

// Combine geometry and material to a new object:
var obj = new THREE.Mesh(geo, mat);



scene.add(obj);
 addAxes(scene);
// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );
function render() {
  requestAnimationFrame(render);

  controls.update();
  renderer.render(scene, camera);
}
render();
