/*
	Student: Ievgenii Nudga
	Matr. num.: 2159839
	Date: 06.11.2017
	Semester: IE7
	Course: CM1
*/

//---------- Initialize webGL --------------
const canvas = document.getElementById("mycanvas");
const renderer = new THREE.WebGLRenderer({canvas:canvas, antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor('white');    

//---------- Create a scene with camera and light --------
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 75, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set( 0, 0, 20 );
camera.lookAt( scene.position );
const ambientLight = new THREE.AmbientLight('white');
scene.add( ambientLight );
const light = new THREE.DirectionalLight('black');
light.position.set( 1.5, 1, 1 );
scene.add( light );

//------------- Axishelper --------------
const axisHelper = new THREE.AxisHelper( 5 );
scene.add( axisHelper );

//------------- Big Sphere --------------
const bigRadiusSphere = 12;
const geometry1 = new THREE.SphereGeometry( bigRadiusSphere, 30, 30 );
const material1 = new THREE.MeshBasicMaterial( {color: 'gray',
												wireframe:true,
												transparent:true,
												opacity:0.4} );
const mainSphere = new THREE.Mesh( geometry1, material1 );
scene.add( mainSphere );

//------------ User controlled black sphere -------------
const userControlledSphereRadius = 1;
const geometry2 = new THREE.SphereGeometry( userControlledSphereRadius, 10, 10 );
const material2 = new THREE.MeshBasicMaterial( {color: 'black', wireframe:false} );
const userSphere = new THREE.Mesh( geometry2, material2 );
const generateUserSphereSpeed = new THREE.Vector3( 0, 0, 0 );
scene.add( userSphere );

//---------- Small spheres (not controlled by user) ---------------
const smallSphereRadius = 0.5;
const amountOfSpheres = prompt('How many spheres would you like to be in the game?');
const speedOfSpheres = new Array( amountOfSpheres ); //array of vectors holding the speed for each sphere

//------------ Generating small spheres, their positions and speed ------------

function generateUserSpheresPosition( sphere )
//the point here is to create spheres as close to the boundaries of big sphere as possible
{ 
		const beta = 2*Math.PI*Math.random(); //elevation angle above "table"
		const yProjection = ( bigRadiusSphere - smallSphereRadius ) * Math.cos( beta ); //angle of direction in the plane of the "table"
		const alpha = 2*Math.PI*Math.random();
		sphere.position.x = yProjection*Math.cos( alpha );
		sphere.position.z = yProjection*Math.sin( alpha );
		sphere.position.y = ( bigRadiusSphere - smallSphereRadius )* Math.sin( beta );
}		

function generateUserSpheresSpeed()
{
	const speed = 0.1;
	return new THREE.Vector3( speed*(Math.random()-0.5 ), speed*(Math.random()-0.5 ), speed*(Math.random()-0.5 ) ); //return vector speed
}

function generateSpheres( mainSphere ) //passing the object that will be the parent to the spheres
{ 		
	for( let i = 0; i < amountOfSpheres ; i++ )
	{
		const colorOfSpheres = '#'+Math.random().toString(16).substr(-6); //generating random colors for each sphere
		const geometry3 = new THREE.SphereGeometry( smallSphereRadius, 10, 10 );
		const material3 = new THREE.MeshBasicMaterial( {color: colorOfSpheres} );
		const sphere = new THREE.Mesh( geometry3, material3 );
		generateUserSpheresPosition( sphere ); 			//calling the generateUserSpheresPosition function 
		speedOfSpheres[i] = generateUserSpheresSpeed(); //calling the generate speed method
		mainSphere.add( sphere );		
	}
}

generateSpheres( mainSphere );

//---------- FPS Counter -------------

var stats = new Stats();
stats.showPanel( 0 ); // 0: fps, 1: ms, 2: mb, 3+: custom
document.body.appendChild( stats.dom );

//---------- Trackball controls and  event listeners -------------

const controls = new THREE.TrackballControls( camera, canvas );
const clock = new THREE.Clock();

function whenKeyNotPressed( event ) //checks if the key isn't pressed
{ 
	generateUserSphereSpeed.x = 0;
	generateUserSphereSpeed.y = 0;
	generateUserSphereSpeed.z = 0;
}

function myCallback(event)
{
	if(event.keyCode === 38) //up arrow
		generateUserSphereSpeed.y=0.2;
	if(event.keyCode === 40) //down arrow
		generateUserSphereSpeed.y=-0.2;
	if(event.keyCode === 37) //left arrow
		generateUserSphereSpeed.x=-0.2;
	if(event.keyCode === 39) //right arrow
		generateUserSphereSpeed.x=0.2;		
	if(event.keyCode === 65) //using 'A' to move in z domain
		generateUserSphereSpeed.z=0.2; 	 
	if(event.keyCode === 68) //using 'D' to move in z domain
		generateUserSphereSpeed.z=-0.2;	 
}

document.addEventListener( "keydown", myCallback );
document.addEventListener( "keyup", whenKeyNotPressed );

//------------- Rendering ----------------
function render()
{
	stats.begin();
	
	requestAnimationFrame( render );
	
	for( let i = 0; i<mainSphere.children.length; i++ ) //going through all the spheres to check for collision
	{ 
		if( mainSphere.children[i].position.length()+smallSphereRadius > bigRadiusSphere ) // if sphere's length + its radius size is reaching the edge of the mainSphere
		{
			const n = mainSphere.children[i].position.clone().normalize(); //using formula Vout = Vin - 2(Vin * n) * n, where 'n' is a unit vector.
			speedOfSpheres[i].sub(n.clone().multiplyScalar( 2*(speedOfSpheres[i].clone().dot(n)))); //after the collision a new speed is given.
		}
		
		//if distance of the sphere to the userSphere is less than radius of the sphere + userSphere then a collision is detected.
		if( mainSphere.children[i].position.clone().distanceTo(userSphere.position.clone()) <= userControlledSphereRadius +  smallSphereRadius )
		{ 
			alert("Game Over!");
			
			//return a user sphere back to the origin.
			userSphere.position.x = 0;
			userSphere.position.y = 0;
			userSphere.position.z = 0;
			
			whenKeyNotPressed(); //set the speed back to 0
			
			//generateSpheres( mainSphere );
			for( let j = 0; j < mainSphere.children.length ; j++ )
			{
				generateUserSpheresPosition( mainSphere.children[j] ); //calling the generateUserSpheresPosition function 
				speedOfSpheres[j] = generateUserSpheresSpeed(); 	//calling the generate speed method
			}
		}
		mainSphere.children[i].position.x += speedOfSpheres[i].x; //updating x,y,z position for each sphere
		mainSphere.children[i].position.y += speedOfSpheres[i].y;
		mainSphere.children[i].position.z += speedOfSpheres[i].z;
	}
	
	if( userSphere.position.length() + userControlledSphereRadius> bigRadiusSphere )
	//if the boundary of the mainSphere is touched by the spheres the game is over as well
	{ 
			alert("Game Over!");
			
			//return a user sphere back to the origin
			userSphere.position.x = 0;
			userSphere.position.y = 0;
			userSphere.position.z = 0;
			
			whenKeyNotPressed(); //set the speed back to 0
			
			//generateSpheres(mainSphere);
			for( let j = 0; j < amountOfSpheres ; j++ )
			{
				generateUserSpheresPosition( mainSphere.children[j] ); //calling the generateUserSpheresPosition function 
				speedOfSpheres[j] = generateUserSpheresSpeed(); 	//calling the generate speed method
			}
	}
	
	//update user sphere speed 
	userSphere.position.x+=generateUserSphereSpeed.x;
	userSphere.position.y+=generateUserSphereSpeed.y;
	userSphere.position.z+=generateUserSphereSpeed.z;
	
	controls.update();
    renderer.render(scene, camera);
	
	stats.end();
}

render();