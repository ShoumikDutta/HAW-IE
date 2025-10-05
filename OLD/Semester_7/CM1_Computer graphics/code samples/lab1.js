/*
	Author: Nikolay Stoitsov, 2159769
	Date: 20.10.2016
	IE7 CM1
*/

// Initialize webGL
var canvas = document.getElementById("mycanvas");
var renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('white');    

// Create a new Three.js scene with camera and light
var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set(0,-10,3);
camera.lookAt(scene.position);   // camera looks at origin
var ambientLight = new THREE.AmbientLight("white");
scene.add(ambientLight);

//variable declarations
var collisionCheck = false;				//if there is a collision, variable is changed to true and the event listener is removed
var big_radius = 5;
var small_radius = big_radius/20;	
var user_ball_radius = big_radius/18;
var small_spheres = [];
var speed = [];
var number_of_spheres = 10;
//********************************** Create geometry ******************************************
//big sphere
var big_sphere = createSphere(big_radius);
big_sphere.material.wireframe = true;
scene.add(big_sphere);

// small spheres as an array
for(var i=0; i<number_of_spheres; i++){
	small_spheres.push(createSphere(small_radius, '#'+Math.random().toString(16).substr(-6)));		//2nd param is random color
	startingPoint(small_spheres[i]);
	big_sphere.add(small_spheres[i]);
	speed[i] = new THREE.Vector3(Math.random()*10-5, Math.random()*10-5, Math.random()*10-5);		//speed between -5 and 5
}

// user controlled sphere
var user_sphere = createSphere(user_ball_radius, 'black');
big_sphere.add(user_sphere);

// field for movement for user ball
var geo = new THREE.CircleGeometry( big_radius, 32 );
var mat = new THREE.MeshBasicMaterial({color: 'yellow', side:THREE.DoubleSide, transparent: true, opacity: 0.5});
var circle = new THREE.Mesh(geo, mat);
big_sphere.add( circle );
//*********************************************************************************************	

//================================ Help functions =============================================
function createSphere(radius, sphere_color='gray'){
	var geo = new THREE.SphereGeometry(radius, 32, 32);
	var mat = new THREE.MeshPhongMaterial({color: sphere_color} );
	return new THREE.Mesh(geo, mat);
}
function startingPoint(obj){
	var pos = new THREE.Vector3(Math.random()*big_radius, Math.random()*big_radius, Math.random()*big_radius);
	obj.position.set(pos.x-(big_radius+small_radius)/1.5, pos.y-(big_radius+small_radius)/1.5, pos.z-(big_radius+small_radius)/1.5);//a bit long but independent on radius changes
}
function specRef(vin, n){
	var n2 = n.clone();
	n2.normalize();
	var vout = vin.clone();
	var f = 2*n2.dot(vin);
	vout.sub(n2.multiplyScalar(f));
	return vout;
}
function spheresAnimation(){
	var h = clock.getDelta();
	for(var i=0; i<number_of_spheres; i++){
		var len = small_spheres[i].position.length();			//take the distance of the current sphere from the center of the big sphere
		if(len >= big_radius-small_radius){						//if the distance is at least equal to the difference of both radiuses
			speed[i] = specRef(speed[i], small_spheres[i].position);//the reflected speed vector is calculated
		}		   
		small_spheres[i].position.x += speed[i].x*h;
		small_spheres[i].position.y += speed[i].y*h;
		small_spheres[i].position.z += speed[i].z*h;
		var pos = user_sphere.position.clone();					//take the current position of the user controlled sphere
		var dist = pos.sub(small_spheres[i].position);			//substract vrom it the position of the current moving sphere
		if(dist.length() <= small_radius+user_ball_radius){		//if the length of resulting vector is smaller that the sum of their radiuses
			collisionCheck = true;								//we have a collision
			return;
		}		
	}
}
//=============================================================================================
//addAxes(scene);
//---------------------------------- event listeners ------------------------------------------
 function myCallback(event){
//	 console.log(event.keyCode);	//check key codes
	switch(event.keyCode){
		case 37:		//left key
			user_sphere.position.x -= 0.5;
			break;
		case 38:		//up key
			user_sphere.position.y += 0.5;
			break;
		case 39:		//right key
			user_sphere.position.x += 0.5;
			break;
		case 40:		//down key
			user_sphere.position.y -= 0.5;
			break;
	}
	var pos = user_sphere.position.clone();
	if(pos.length() >= big_radius-user_ball_radius){
		collisionCheck = true;
	}
 }
 document.addEventListener('keydown', myCallback);
 
//---------------------------------------------------------------------------------------------
var controls = new THREE.TrackballControls( camera, canvas );
var clock = new THREE.Clock();

function render() {
	requestAnimationFrame(render);
	spheresAnimation();
	if(collisionCheck){
		alert('Game over!');
		document.removeEventListener('keydown', myCallback);
		collisionCheck = false;
	}	
	controls.update();
	renderer.render(scene, camera);	
}
render();