// Create a maze

//* Initialize webGL with camera and lights
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('rgb(255,255,255)');
renderer.shadowMap.enabled=true;		//SHADOWS
// create scene and camera
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight,
                                         0.1, 1000);
camera.position.x = 20;
//camera.rotation.x = Math.PI/2;

var ambientLight = new THREE.AmbientLight(0x505050);
scene.add(ambientLight);
// var light = new THREE.DirectionalLight(0x444444);
// light.position.set( 1.5,1,1 );
// scene.add(light);
var spotlight = new THREE.SpotLight(0xffffff);
spotlight.position.set(15,5,-5);
spotlight.castShadow = true;
spotlight.shadow.camera.near = 0.1;
spotlight.shadow.camera.far = 40;
scene.add(spotlight);

//================================= help functions ====================================================================
//CONSTRUCTOR
function CreateObject(sze){
	if(sze === undefined){				//if sze is omitted
		this.geo = new THREE.Object3D();
	}												
	else if(sze.z === undefined){		//if sze is Vector2
		this.geo = new THREE.PlaneGeometry(sze.x, sze.y);
	}
	else {								//if sze is Vector3
		this.geo = new THREE.BoxGeometry(sze.x, sze.y, sze.z);
	}
	this.mat = null;
	this.obj = null;
}
CreateObject.prototype.createMeshMaterial = function(valuesList){	//valueList is object of components
	this.mat = new THREE.MeshPhongMaterial(valuesList );
}
CreateObject.prototype.createMesh = function(){					//create the mesh
	this.obj = new THREE.Mesh(this.geo, this.mat);
}
CreateObject.prototype.rotate = function(axis, angle){			//axis is a Vector3, angle is in rad e.g. Math.PI/2
	this.obj.rotateOnAxis(axis, angle);
}
CreateObject.prototype.positionate = function(pos){			//pos is Vector3
	this.obj.position.set(pos.x, pos.y, pos.z);
}
CreateObject.prototype.addToScene = function(parentObject){			//add object to scene
	if(parentObject === undefined) scene.add(this.obj);
	else parentObject.obj.add(this.obj);							//or to parent
}
CreateObject.prototype.addAxis = function(){				//adds a help Axis
	var axisHelper = new THREE.AxisHelper( 7 );
	scene.add( axisHelper );
}
CreateObject.prototype.cloneObject = function(){		//clone object
	var cloned = new CreateObject();
	cloned.obj = this.obj.clone();
	return cloned;
}

//------------------------------ declarations of components' sizes ---------------------------------------------------------------------

var groundSize = new THREE.Vector2(50, 70);
var groundPosition = new THREE.Vector3(Math.PI/2, 0, 0);

var houseSize = new THREE.Vector3(10, 7, 3);
var housePosition = new THREE.Vector3(0, 0, houseSize.z/2);			// z - house lies on the ground

var roofSize = new THREE.Vector3(houseSize.x + 1, houseSize.y + 1, 3);
var roofPosition = new THREE.Vector3(0, 0, housePosition.z);//roof is always on top of the house

var roomSize = new THREE.Vector3(houseSize.x/2, houseSize.y/2, houseSize.z);
var roomPosition = new THREE.Vector3((houseSize.x-roomSize.x)/2, (roomSize.y-houseSize.y)/2, 0);

var doorSize1 = new THREE.Vector2(2, 1);
var doorPosition1 = new THREE.Vector3(houseSize.x/2, houseSize.y/4, (doorSize1.x-houseSize.z)/2);

var windowSize1 = new THREE.Vector2(1, roomSize.y-1);
var windowPosition1 = new THREE.Vector3(houseSize.x/2, roomPosition.y, 0);

var windowSize2 = new THREE.Vector2(2,1);
var windowPosition2 = new THREE.Vector3(houseSize.x/4, houseSize.y/2, 0);

var chimneySize = new THREE.Vector3(1, 1, 2);
var chimneyPosition = new THREE.Vector3(0, roofSize.y/4, roofSize.z/2);

var chimneyHoleSize = new THREE.Vector3(chimneySize.x/2, chimneySize.y/2, chimneySize.z);
var chimneyHolePosition = new THREE.Vector3(0, 0, 0);			//initial acc to its parent

//*********************************** Build the house **********************************************************************************88
//ground
var ground = new CreateObject(groundSize);
ground.createMeshMaterial({side:THREE.DoubleSide});
ground.createMesh();
ground.obj.receiveShadow = true;
ground.rotate(new THREE.Vector3(1,0,0), -Math.PI/2);
ground.addToScene();

var txtLoader = new THREE.TextureLoader();
txtLoader.load("desert.jpg",
				function(txtMap){
					ground.obj.material.map = txtMap;
					ground.obj.material.needsUpdate = true;
				});

//house
var house = new CreateObject(houseSize);
house.createMeshMaterial({side:THREE.DoubleSide, //transparent: true, opacity: 0.5,
										 polygonOffset: true, 		//to prevent flickering of overlapping objects.
										 polygonOffsetFactor: 1,    //Positive value pushes polygon further away
										 polygonOffsetUnits: 1});
house.createMesh();
house.positionate(housePosition);
house.obj.castShadow = true;
house.addToScene(ground);
house.addAxis();


txtLoader.load("brick-wall.jpg",
				function(txtMap){
					house.obj.material.map = txtMap;
					house.obj.material.needsUpdate = true;
				});

//roof
var roof = new CreateObject();
roof.geo = (function(){
				var l = roofSize.x/2;
				var w = roofSize.y/2;
				var h = roofSize.z;
				var geo = new THREE.Geometry();
				geo.vertices[0] = new THREE.Vector3(l,w,0);
				geo.vertices[1] = new THREE.Vector3(-l,w,0);
				geo.vertices[2] = new THREE.Vector3(-l,-w,0);
				geo.vertices[3] = new THREE.Vector3(l,-w,0);
				geo.vertices[4] = new THREE.Vector3(l/2,0,h);
				geo.vertices[5] = new THREE.Vector3(-l/2,0,h);
				geo.faces[0] = new THREE.Face3(0,2,1);
				geo.faces[1] = new THREE.Face3(0,3,2);
				geo.faces[2] = new THREE.Face3(0,4,3);
				geo.faces[3] = new THREE.Face3(1,2,5);
				geo.faces[4] = new THREE.Face3(0,1,5);
				geo.faces[5] = new THREE.Face3(0,5,4);
				geo.faces[6] = new THREE.Face3(2,3,4);
				geo.faces[7] = new THREE.Face3(2,4,5);
				geo.computeFaceNormals();	//for shading effects
				geo.faces.forEach(function(f){
					f.vertexNormals.push(f.normal.clone());
					f.vertexNormals.push(f.normal.clone());
					f.vertexNormals.push(f.normal.clone());
				})
			return geo;	})();
roof.createMeshMaterial({color: "red", wireframe:false,			//wireframe shows only edges of object when true
									   wireframeLinewidth:2,
									   shading: THREE.SmoothShading} );	
roof.createMesh();
roof.positionate(roofPosition);
roof.obj.castShadow = true;
roof.obj.receiveShadow = true;
roof.addToScene(house);

//room
var room = new CreateObject(roomSize);
room.createMeshMaterial({color: "black", side:THREE.DoubleSide, polygonOffset: true, polygonOffsetFactor: 2, polygonOffsetUnits: 2});
room.createMesh();
room.positionate(roomPosition);
room.addToScene(house);

//door1
var door1 = new CreateObject(doorSize1);
door1.createMeshMaterial({color:"brown", side:THREE.DoubleSide});
door1.createMesh();
door1.rotate(new THREE.Vector3(0,1,0), Math.PI/2);			//rotate 90 degrees on the Y axis
door1.positionate(doorPosition1);
door1.addToScene(house);

//door2
var door2 = door1.cloneObject();
door2.rotate(new THREE.Vector3(1,0,0), Math.PI/2);			//rotate 90 degrees on the X axis
door2.positionate(new THREE.Vector3(-roomPosition.x/2, -roomPosition.y, doorPosition1.z));
door2.addToScene(room);
//door2.obj.add(new THREE.AxisHelper( 3 ));

//window1
var window1 = new CreateObject(windowSize1);
window1.createMeshMaterial({color: "blue", side:THREE.DoubleSide, specular:"white", shininess:50});
window1.createMesh();
window1.rotate(new THREE.Vector3(0,1,0), Math.PI/2);		//rotate 90 degrees on the Y axis
window1.positionate(windowPosition1);
window1.addToScene(house);

//window2
var window2 = new CreateObject(windowSize2);
window2.createMeshMaterial({color: "black", side:THREE.DoubleSide, specular:"white", shininess:50});
window2.createMesh();
window2.rotate(new THREE.Vector3(1,0,0), Math.PI/2);		//rotate 90 degrees on the X axis
window2.positionate(windowPosition2);
window2.addToScene(house);

//window3
var window3 = window2.cloneObject();					//clone window2
window3.obj.position.x = -houseSize.x/4;				//change its position
window3.addToScene(house);

// chimney
var chimney = new CreateObject(chimneySize);
chimney.createMeshMaterial({color: "gray", polygonOffset: true, polygonOffsetFactor: 1, polygonOffsetUnits: 1});
chimney.createMesh();
chimney.positionate(chimneyPosition);
chimney.obj.castShadow = true;
chimney.addToScene(roof);

//chimney hole
var chimneyHole = new CreateObject(chimneyHoleSize);
chimneyHole.createMeshMaterial({color: "black"});
chimneyHole.createMesh();
chimneyHole.positionate(chimneyHolePosition);
chimneyHole.addToScene(chimney);

//sun
var sun = new CreateObject();
sun.geo = new THREE.SphereGeometry(1,32,32);
sun.createMeshMaterial({color:"black", emissive:"yellow"});
sun.createMesh();
sun.positionate(spotlight.position);		//positioned at spot light source
sun.addToScene();


//* Render loop
var controls = new THREE.TrackballControls( camera, canvas );
controls.rotateSpeed = 2;

//var clock = new THREE.Clock();

function render() {
    requestAnimationFrame(render);
//	var t = clock.getElapsedTime();//time passed since creating of the clock object
//	var h = clock.getDelta();	//get frames

    controls.update();
    renderer.render(scene, camera);
}

render();
