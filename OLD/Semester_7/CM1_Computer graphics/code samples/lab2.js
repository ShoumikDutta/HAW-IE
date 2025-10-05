/*
	Author: Nikolay Stoitsov, 2159769
	Date: 11.11.2016
	IE7 CM1
*/

// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('black');    

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set(0,10,0.1);
camera.lookAt(scene.position);   // camera looks at origin
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);

//variable declarations
var clockRadius = 5;				//determines size of clock
var clockHeight = 0.1*clockRadius;	//determines height of clock

var minTickHeight = clockRadius/6.25;
var minTickWidth = clockRadius/25;
var blobRadius = clockRadius/25;
var blobHeight = clockRadius/17;
var armRadius = clockRadius/5;
//********************************** Create geometry ******************************************
// Clock body
var geo = new THREE.CylinderGeometry(clockRadius, clockRadius, clockHeight, 64);
var mat = new THREE.MeshPhongMaterial({color: 0x112233, polygonOffset: true,polygonOffsetFactor: 2,polygonOffsetUnits: 2} );
var cylinder = new THREE.Mesh(geo, mat);
scene.add(cylinder);

// Clock face
geo = new THREE.CircleGeometry(clockRadius, 64);
mat = new THREE.MeshBasicMaterial({color: 0xddeeff, side:THREE.DoubleSide, polygonOffset: true,polygonOffsetFactor: 1,polygonOffsetUnits: 1} );
var clockFace = new THREE.Mesh(geo, mat);
clockFace.position.y = clockHeight/2;
clockFace.rotateX(Math.PI/2);
cylinder.add(clockFace);

// Minute tick
geo = new THREE.PlaneGeometry(minTickWidth, minTickHeight);
mat = new THREE.MeshPhongMaterial({color: 0x00FF00, side:THREE.DoubleSide});
var minuteTick12 = new THREE.Mesh(geo,mat);
mat = new THREE.MeshPhongMaterial({color: 'black', side:THREE.DoubleSide});
var minuteTick = new THREE.Mesh(geo,mat);
minuteTick.position.y = minTickHeight/2-clockRadius;
minuteTick12.position.y = minuteTick.position.y;
clockFace.add(minuteTick12);
makeTicks(minuteTick, 12);

//Second ticks - the same as minute ticks but scaled
var secTicks = minuteTick.clone();
secTicks.scale.set(0.5, 0.5, 1);
makeTicks(secTicks, 60);

// Seconds arm - same as 12 o'clock tick but scaled
var secArm = minuteTick12.clone();
secArm.scale.set(0.5, 6, 1);
secArm.position.y = (1/10 - 1/2)*secArm.scale.y*minuteTick12.geometry.parameters.height;
secArm.position.z -= 0.1*armRadius;		//in order to be over the other arms;

// Minute arm - scaled sphere
geo = new THREE.SphereGeometry(armRadius, 32, 32);
mat = new THREE.MeshPhongMaterial({color: 'black', side:THREE.DoubleSide});
var minuteArm = new THREE.Mesh(geo, mat);
minuteArm.scale.set(0.2, 2, 0.05);
minuteArm.position.set(0, -minuteArm.scale.y*armRadius, -minuteArm.scale.z*armRadius/2);

// Hour arm - same as minute arm but scaled
var hourArm = minuteArm.clone();
hourArm.scale.set(0.1, 1.6, 0.05);
hourArm.position.set(0, -hourArm.scale.y*armRadius, -hourArm.scale.z*armRadius/2);

// Blob
geo = new THREE.ConeGeometry( blobRadius, blobHeight, 32 );
mat = new THREE.MeshPhongMaterial({color: 'black'});
var blob = new THREE.Mesh(geo,mat);
blob.rotateX(-Math.PI/2);
blob.position.z = -blobHeight/2;
clockFace.add(blob);

// Back clock face is same as the front face
var clockFaceHometown = clockFace.clone();
clockFaceHometown.rotateY(Math.PI);
clockFaceHometown.position.y = -clockHeight/2;
cylinder.add(clockFaceHometown);

clockFace.add(secArm);
clockFace.add(minuteArm);
clockFace.add(hourArm);

// Arms for back clock face - same as front 
var hourArmHometown = hourArm.clone();
var minuteArmHometown = minuteArm.clone();
var secArmHometown = secArm.clone();

clockFaceHometown.add(hourArmHometown);
clockFaceHometown.add(minuteArmHometown);
clockFaceHometown.add(secArmHometown);

//*********************************************************************************************	
document.addEventListener('keydown', function(event){
	if(event.keyCode == 82){//'r' key puts the camera in initial position
		camera.position.set(0,10, 0.1);
		camera.lookAt(scene.position);
		camera.up.set(0,1,0);
	}
})
//================================ Help functions =============================================

// Rotates the object with rotation matrix with the passed angle 
function rotate(obj, angle){
	var rotMat = new THREE.Matrix3().set(Math.cos(angle), -Math.sin(angle), 0, Math.sin(angle), Math.cos(angle), 0, 0, 0, 1);	//rotation around Z axis
	obj.position.applyMatrix3(rotMat);
	obj.rotateZ(angle);
}
// Rotates and adds the ticks
function makeTicks(obj, numOfTicks){
	var angle = 2*Math.PI/numOfTicks;
	for (var i=1; i<numOfTicks; i++){
		var obj1 = obj.clone();
		rotate(obj1, i*angle);
		clockFace.add(obj1);
	}
}
//=============================================================================================
//addAxes(clockFace);

//	Angles of rotation for each arm at every second
var angle_sec = Math.PI/30;		// 2*pi/60
var angle_min = angle_sec/60;
var angle_h = angle_min/12;		//12=60/5

// Get current time
var date = new Date();
var sec = date.getSeconds();
var minutes = date.getMinutes();
var hours = date.getHours() % 12;
var hoursHometown = (hours+1) % 12;

// Set initial position of the arms acc to current time
rotate(secArm, sec*angle_sec);
rotate(minuteArm, minutes*angle_sec + sec*angle_min);
rotate(hourArm, 5*(hours*angle_sec + minutes*angle_min + sec*angle_h));
rotate(secArmHometown, sec*angle_sec);
rotate(minuteArmHometown, minutes*angle_sec + sec*angle_min);
rotate(hourArmHometown, 5*(hoursHometown*angle_sec + minutes*angle_min + sec*angle_h));

var controls = new THREE.TrackballControls( camera, canvas );

function render() {
	requestAnimationFrame(render);
	date = new Date();
	var newSec = date.getSeconds();
	if(newSec - sec){		//true at every second
		sec = newSec;
		rotate(secArm, angle_sec);
		rotate(minuteArm, angle_min);
		rotate(hourArm, angle_h);
		rotate(secArmHometown, angle_sec);
		rotate(minuteArmHometown, angle_min);
		rotate(hourArmHometown, angle_h);
	}
	controls.update();
	renderer.render(scene, camera);	
}
render();