// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('white');    // set background color
renderer.shadowMap.enabled=true;		//SHADOWS
// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set(1,25,-1);
camera.lookAt(scene.position);   // camera looks at origin
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);
var light = new THREE.SpotLight(0xffffff);
light.castShadow = true;
light.shadow.camera.near = 0.1;
light.shadow.camera.far = 40;
scene.add(light);

var floorSide = 100;		// the size of everything can be changed from here

var len = floorSide/5;
var width = len/2;
var height = len/3.333333333;
var cushionSide = len/20;
var depth = cushionSide/10;
var legSide = len/20;
var ballRadius = len/40;

// Create geometry
var geoFloor = new THREE.PlaneGeometry(floorSide,floorSide);
var geoTable = new THREE.BoxGeometry(len,width,depth);
var geoSideL = new THREE.BoxGeometry(len,cushionSide,cushionSide);
var geoSideW = new THREE.BoxGeometry(cushionSide,width+2*cushionSide,cushionSide);
var geoLeg = new THREE.BoxGeometry(legSide,legSide,height);
var geoBall = new THREE.SphereGeometry(ballRadius,32,32);
var geoBulb = new THREE.SphereGeometry(ballRadius/2,16,16);

// material 
var matFloor = new THREE.MeshPhongMaterial({color:'gray', side:THREE.DoubleSide});
var matTable = new THREE.MeshPhongMaterial({color: "green", side:THREE.DoubleSide,
											polygonOffset: true, polygonOffsetFactor: -1, polygonOffsetUnits: -1} );	
var matLeg = new THREE.MeshPhongMaterial({color: "brown"} );	
var matBall = new THREE.MeshPhongMaterial({color: "white", wireframe:true, wireframeLinewidth:2} );		
var matBulb = new THREE.MeshPhongMaterial({color: 'black', emissive:'yellow'});								   
									   
// Combine geometry and material to a new object:
var floor = new THREE.Mesh(geoFloor, matFloor);
var table = new THREE.Mesh(geoTable, matTable);
var sideL1 = new THREE.Mesh(geoSideL, matTable);
var sideW1 = new THREE.Mesh(geoSideW, matTable);
var leg1 = new THREE.Mesh(geoLeg, matLeg);
var bulb = new THREE.Mesh(geoBulb, matBulb);


//building table plot and sides
bulb.position.y = len;
bulb.position.x = width;
light.position.copy(bulb.position);
floor.rotateX(-Math.PI/2);
table.position.z = height;
sideL1.position.y = width/2+cushionSide/2;
sideL1.position.z = cushionSide/2;
var sideL2 = sideL1.clone();
sideL2.position.y *= -1;
sideW1.position.x = len/2+cushionSide/2;
sideW1.position.z = cushionSide/2;
var sideW2 = sideW1.clone();
sideW2.position.x *= -1;
//building up legs
leg1.rotateZ(Math.PI/2);
leg1.position.set(len/2-legSide, width/2-legSide, -height/2);
var leg2 = leg1.clone();
leg2.position.x *= -1;
var leg3 = leg2.clone();
leg3.position.y *= -1;
var leg4 = leg1.clone();
leg4.position.y *= -1;


floor.receiveShadow = true;
table.receiveShadow = true;
table.castShadow = true;
sideL1.receiveShadow = true;
sideL1.castShadow = true;
sideL2.receiveShadow = true;
sideL2.castShadow = true;
sideW1.receiveShadow = true;
sideW1.castShadow = true;
sideW2.receiveShadow = true;
sideW2.castShadow = true;
leg1.castShadow = true;
leg2.castShadow = true;
leg3.castShadow = true;
leg4.castShadow = true;

scene.add(bulb);
scene.add(floor);
floor.add(table);
table.add(sideL1);
table.add(sideL2);
table.add(sideW1);
table.add(sideW2);
table.add(leg1);
table.add(leg2);
table.add(leg3);
table.add(leg4);


//---------------------------------help functions---------------------------------------------------------


function roll(t,dt){
	for(var i=0; i<balls.length; i++){
		pos[i].add(ballSpeed[i].clone().multiplyScalar(dt));
		var transMat = new THREE.Matrix4();
		transMat.makeTranslation(pos[i].x, pos[i].y, pos[i].z);
		omega[i] = ballSpeed[i].length()/ballRadius;
		var rotMat = new THREE.Matrix4();
		rotMat.makeRotationAxis(rotAxis[i], omega[i]*t);
		balls[i].matrix.copy(transMat);
		balls[i].matrix.multiply(rotMat);
		balls[i].updateMatrixWorld();
		if(Math.abs(pos[i].x)+ballRadius >= len/2){		
			ballSpeed[i].x *= -1;					//spec reflection acc to X axis
			ballSpeed[i].multiplyScalar(0.8);
			rotAxis[i] = new THREE.Vector3(0,0,1);
			rotAxis[i].cross(ballSpeed[i]).normalize();
		}
		if(Math.abs(pos[i].y)+ballRadius >= width/2){		
			ballSpeed[i].y *= -1;					//spec reflection acc to Y axis
			ballSpeed[i].multiplyScalar(0.8);
			rotAxis[i] = new THREE.Vector3(0,0,1);
			rotAxis[i].cross(ballSpeed[i]).normalize();
		}
		
	}
}
function reduceSpeed(){
	for(var i=0; i<balls.length; i++){
		ballSpeed[i].multiplyScalar(0.8);
	}
}
// function noOverlappingBalls(pos,i){
	// for(var j=0; j<i; j++){
		// if(Math.abs(pos.x-balls[j].position.x) < 2*ballRadius) return true;
		// if(Math.abs(pos.y-balls[j].position.y) < 2*ballRadius) return true;
	// }
	// return false;
// }

//------------------------------------------------------------------------------------------------------------
var balls = new Array(8);		//number of balls can be changed here
var pos = [];
var ballSpeed = [];
var rotAxis = [];
var omega = [];
var maxBallSpeed = 10;			//max ball speed can be changed here
for(var i=0; i<balls.length; i++){
	balls[i] = new THREE.Mesh(geoBall, matBall);
	balls[i].castShadow = true;
	pos[i] = new THREE.Vector3((Math.random()-0.5)*(len-4*ballRadius), (Math.random()-0.5)*(width-4*ballRadius), ballRadius+depth/2);
	balls[i].matrixAutoUpdate = false;
	table.add(balls[i]);
	ballSpeed[i] = new THREE.Vector3((Math.random()-0.5)*maxBallSpeed, (Math.random()-0.5)*maxBallSpeed, 0);	// ball speed only w.r.t X and Y axis
	rotAxis[i] = new THREE.Vector3(0,0,1);
	rotAxis[i].cross(ballSpeed[i]).normalize();
}

table.add( new THREE.AxisHelper( 7 ) );
 
//----------------------------------event listeners-------------------------------------
 
//-------------------------------------------------------------------------------------- 

// Draw everything
var controls = new THREE.TrackballControls( camera, canvas );
controls.rotateSpeed = 10;

var clock = new THREE.Clock();
var old_t = 0;
function render() {
	requestAnimationFrame(render);
    var dt = clock.getDelta();
	var t = clock.getElapsedTime();
	roll(t,dt);
	if(t - old_t >= 1){
		old_t = t;
		reduceSpeed();//roll(t,dt);
	}
	//setTimeout(function() {clearInterval(interval);}, 11000);
	controls.update();
	renderer.render(scene, camera);
}
render();
