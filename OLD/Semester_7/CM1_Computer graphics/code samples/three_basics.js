// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setClearColor('black');    // set background color

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );//(fov(it's an angle), aspect ratio, near, far)
camera.position.set(0,0,3);
camera.lookAt(scene.position);   // camera looks at origin
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);


// Create geometry
//var geo = new THREE.BoxGeometry(1,1,1);
var geo = new THREE.SphereGeometry(1,32,32);
var geo1 = new THREE.SphereGeometry(1/4,32,32);
var geo2 = new THREE.SphereGeometry(1/10,32,32);
/* var geo = new THREE.Geometry();
geo.vertices[0] = new THREE.Vector3(1,0,0);
geo.vertices[1] = new THREE.Vector3(0,1,0);
geo.vertices[2] = new THREE.Vector3(0,0,0);
geo.vertices[3] = new THREE.Vector3(1/2,1/2,1);
geo.faces[0] = new THREE.Face3(0,2,1);
geo.faces[1] = new THREE.Face3(0,3,2);
geo.faces[2] = new THREE.Face3(1,2,3);
geo.faces[3] = new THREE.Face3(0,1,3);
*/

// material specifies how triangle looks like
var mat = new THREE.MeshPhongMaterial({color: "yellow",
                                       wireframe:false,
                                       wireframeLinewidth:2} );	//wireframe shows only edges of object when true
var mat1 = new THREE.MeshPhongMaterial({color: "blue",
                                       wireframe:false,
                                       wireframeLinewidth:2} );									   
var mat2 = new THREE.MeshPhongMaterial({color: "white",
                                       wireframe:false,
                                       wireframeLinewidth:2} );
// Combine geometry and material to a new object:
var obj = new THREE.Mesh(geo, mat);
var obj1 = new THREE.Mesh(geo1, mat1);
var obj2 = new THREE.Mesh(geo2, mat2);

scene.add(obj);
obj.add(obj1);
obj1.add(obj2);
 addAxes(scene);
 
//----------------------------------event listeners-------------------------------------
 function myCallback(event){
//	 console.log(event.keyCode);	//check key codes
	 if(event.keyCode === 37){		//left key
		 obj.position.x -= 1;
	 }
	 if(event.keyCode === 39){		//right key
		 obj.position.x += 1;
	 }
 }
 document.addEventListener('keydown', myCallback);
//-------------------------------------------------------------------------------------- 

// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );

var vx = 1;
var r = 5;
var wt1 = 2*Math.PI/15;	//15 seconds per rotation
var wt2 = 2*Math.PI/5;	//5 sec per rotation
var clock = new THREE.Clock();

function render() {
  requestAnimationFrame(render);
  var h = clock.getDelta();
  var t = clock.getElapsedTime();
  // if(Math.abs(obj.position.x)>3){
	  // vx = -vx;
  // }
  // obj.position.x += vx*h;
  
  obj1.position.x = r * Math.cos(wt1*t);	//rotating acc to x and y axis, counter clockwise in this case
  obj1.position.y = r * Math.sin(wt1*t);
  
  obj2.position.x = -Math.cos(wt2*t);		//rotate clockwise
  obj2.position.y = Math.sin(wt2*t);

  controls.update();
  renderer.render(scene, camera);
}
render();
