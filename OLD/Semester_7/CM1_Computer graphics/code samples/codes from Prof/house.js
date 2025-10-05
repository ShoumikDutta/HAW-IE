// Create a maze

//* Initialize webGL with camera and lights
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('rgb(255,255,255)');
renderer.shadowMap.enabled=true;
// create scene and camera
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight,
                                         0.1, 1000);
camera.position.z = 3;
camera.position.y = 1;

// Add lights
var ambientLight = new THREE.AmbientLight(0x505050);
scene.add(ambientLight);
var light = new THREE.SpotLight(0xffffff);
light.position.set(5,3,4);
light.castShadow = true;
light.shadow.camera.near = 0.1;
light.shadow.camera.far = 40;
// light.shadowDarkness = 0.3; Wiki: Removed shadowDarkness. Add a THREE.AmbientLight to you scene instead.
scene.add(light);
// Add sun at position of spotlight
var sun = new THREE.Mesh(new THREE.SphereGeometry(0.5, 32, 32),
                         new THREE.MeshPhongMaterial({color:"black", emissive:"yellow"}));
sun.position.copy(light.position);
scene.add(sun);

// Add the ground
var groundMat = new THREE.MeshPhongMaterial({color: "lime", side:THREE.DoubleSide} );
groundMat.transparent = true;
groundMat.opacity = 0.5;
var groundGeo = new THREE.PlaneGeometry(20,20);
var ground = new THREE.Mesh(groundGeo, groundMat);
ground.rotation.x = -Math.PI/2;
ground.receiveShadow = true;
scene.add(ground);



// Build the house
var width = 1;
var len = 2;
var height = 0.8;
var house = new THREE.Object3D();
scene.add(house);


// Add the body to the house
var bodyMat = new THREE.MeshPhongMaterial({color: "grey"} );
// transparent body for debugging:
// bodyMat.transparent = true;
// bodyMat.opacity = 0.3;
var bodyGeo = new THREE.BoxGeometry(width,height,len);
var body = new THREE.Mesh(bodyGeo, bodyMat);
body.castShadow = true;
body.position.y = height/2 + 0.0001;
house.add(body);

// Add the roof to the house
var roofMat = new THREE.MeshPhongMaterial({color: "darkred"} );
var roofGeo = createRoofGeo(1.1*len,1.1*width,0.5*height);
var roof = new THREE.Mesh(roofGeo, roofMat);
roof.castShadow = true;
roof.position.y = height;
house.add(roof);

// windows
var windowGeo = new THREE.BoxGeometry(height/3, len/10, 0.01);
var windowMat = new THREE.MeshPhongMaterial( { color: 'black',
                                               specular:"white",
                                               shininess:50} );
var win1 = new THREE.Mesh(windowGeo, windowMat);
house.add(win1);
win1.rotation.z = Math.PI/2;
win1.rotation.y = Math.PI/2;
win1.position.x = width/2;
win1.position.y = height/2;
win1.position.z = len/4;
var win2 = win1.clone();
win2.position.z = -len/4;
house.add(win2);
var win3 = win1.clone();
win3.position.x = -width/2;
house.add(win3);
var win4 = win2.clone();
win4.position.x = -width/2;
house.add(win4);
var win5 = new THREE.Mesh(windowGeo, windowMat);
win5.rotation.z = Math.PI/2;
win5.position.z = len/2;
win5.position.y = height/2;
house.add(win5);


//* Render loop
// addWorldAxes(scene);
var controls = new THREE.TrackballControls( camera, canvas );
controls.rotateSpeed = 2;

function render() {
    requestAnimationFrame(render);

    controls.update();
    renderer.render(scene, camera);
}

render();
