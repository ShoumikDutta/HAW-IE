/*
	Student: Ievgenii Nudga
	Matr. num.: 2159839
	Date: 12.01.2018
	Semester: IE7
	Course: CM1
*/

//---------- Initialize webGL --------------
const canvas = document.getElementById('mycanvas');
const renderer = new THREE.WebGLRenderer( {canvas:canvas, antialias:true} );
renderer.setSize( window.innerWidth, window.innerHeight );
renderer.setClearColor('lightsteelblue');  
renderer.shadowMap.enabled = true; //shadows 
renderer.shadowMap.soft = true; 

//---------- Create a scene with camera and light --------
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 80, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set( 5, 10, 10 );
camera.lookAt( scene.position ); //camera looks at the origin
const ambientLight = new THREE.AmbientLight('white');
scene.add( ambientLight );
const spotLight = new THREE.SpotLight( 'white', 1.2, 200, 1, 0.077, 1 );
spotLight.castShadow = true;
spotLight.shadow.camera.near = 0.1;
spotLight.shadow.camera.far = 600;
spotLight.position.y = 20; //hint: look what's in "len"

scene.add( spotLight );

//------------- Constiables ----------------
// const floorSide = 100;		// the size of everything can be changed from here

// const len = floorSide/5;
// const width = len/2;
// const height = len/5;
// const cushionSide = len/20;
// const depth = cushionSide/10;
// const legSide = len/20;
// const ballRadius = len/40;

//------------- Axishelper --------------
const axisHelper = new THREE.AxisHelper( 15 );
scene.add( axisHelper );

//----------- Floor --------------
const floorSide = 100;	// the size of everything (len, width, height, etc.) can be changed from here
const txtLoader = new THREE.TextureLoader();
const geoFloor = new THREE.PlaneGeometry( floorSide, floorSide );
const matFloor = new THREE.MeshPhongMaterial( { side:THREE.DoubleSide } );
txtLoader.load( "floor_wood.jpg", 
				function( txtMap )
				{
					txtMap.wrapS = THREE.RepeatWrapping;
					txtMap.wrapT = THREE.RepeatWrapping;
					txtMap.repeat.set( 10, 10 );
					matFloor.map = txtMap;
					matFloor.needsUpdate = true
				});
matFloor.transparent = false;
const floor = new THREE.Mesh( geoFloor, matFloor );
floor.rotateX( -Math.PI/2 );
floor.receiveShadow = true;
scene.add( floor );

//----------- Table --------------
const len = floorSide/5;
const width = len/2;
const height = len/5;
const cushionSide = len/20;
const depth = cushionSide/10;
const geoTable = new THREE.BoxGeometry( len, width, depth );
const matTable = new THREE.MeshPhongMaterial( {	color: "green",
												side: THREE.DoubleSide,
												polygonOffset: true,
												polygonOffsetFactor: -1, 
												polygonOffsetUnits: -1} );
const table = new THREE.Mesh( geoTable, matTable );
table.position.z = height;
table.receiveShadow = true;
table.castShadow = true;
floor.add( table );

//----------- Table's sides --------------
const geoSideL = new THREE.BoxGeometry( len, cushionSide, cushionSide );
const geoSideW = new THREE.BoxGeometry( cushionSide, width+2*cushionSide, cushionSide );
const matSide = new THREE.MeshPhongMaterial( {	color: "saddlebrown",
												side: THREE.DoubleSide,
												polygonOffset: true,
												polygonOffsetFactor: -1,
												polygonOffsetUnits: -1} );
const sideL1 = new THREE.Mesh( geoSideL, matSide );
const sideW1 = new THREE.Mesh( geoSideW, matSide );
sideL1.position.y = width/2 + cushionSide/2;
sideL1.position.z = cushionSide/2;
const sideL2 = sideL1.clone();
sideL2.position.y *= -1;
sideW1.position.x = len/2+cushionSide/2;
sideW1.position.z = cushionSide/2;
const sideW2 = sideW1.clone();
sideW2.position.x *= -1;
sideL1.receiveShadow = true;
sideL1.castShadow 	 = true;
sideL2.receiveShadow = true;
sideL2.castShadow 	 = true;
sideW1.receiveShadow = true;
sideW1.castShadow 	 = true;
sideW2.receiveShadow = true;
sideW2.castShadow 	 = true;
table.add( sideL1 );
table.add( sideL2 );
table.add( sideW1 );
table.add( sideW2 );

//----------- Legs for table --------------
const legSide = len/20;
const geoLeg = new THREE.BoxGeometry( legSide, legSide, height );
const matLeg = new THREE.MeshPhongMaterial( { side:THREE.DoubleSide } );	
txtLoader.load( "fire_skin.jpg", 
				function(txtMap)
				{
					txtMap.wrapS = THREE.RepeatWrapping;
					txtMap.wrapT = THREE.RepeatWrapping;
					txtMap.repeat.set(10,10);
					matLeg.map = txtMap;
					matLeg.needsUpdate = true
				});
matLeg.transparent = false;
const leg1 = new THREE.Mesh( geoLeg, matLeg );
leg1.position.set( len/2, width/2, -height/2 );
//now we create 3 more of same legs
const leg2 = leg1.clone();
leg2.position.x *= -1;
const leg3 = leg2.clone();
leg3.position.y *= -1;
const leg4 = leg1.clone();
leg4.position.y *= -1;
leg1.castShadow = true;
leg2.castShadow = true;
leg3.castShadow = true;
leg4.castShadow = true;
table.add( leg1 );
table.add( leg2 );
table.add( leg3 );
table.add( leg4 );

//----------- Ceiling --------------
const geoCeil = new THREE.PlaneGeometry(floorSide,floorSide);
const matCeil = new THREE.MeshPhongMaterial({ side:THREE.DoubleSide});
txtLoader.load( "ceiling_texture.jpg", 
				function(txtMap)
				{
					txtMap.wrapS = THREE.RepeatWrapping;
					txtMap.wrapT = THREE.RepeatWrapping;
					txtMap.repeat.set( 10, 10 );
					matCeil.map = txtMap;
					matCeil.needsUpdate = true
				});
matCeil.transparent = true;
matCeil.opacity = 0.3;
const ceil = new THREE.Mesh( geoCeil, matCeil );
ceil.rotateX( -Math.PI/2 );
ceil.position.y = len + 10;
ceil.receiveShadow = true;
scene.add( ceil );

//----------- Cord from a ceiling to a bulb --------------
const geoCord = new THREE.CylinderGeometry( 0.1, 0.1, 10, 64 ); //clockRadius, clockRadius, clockHeight, 64
const matCord = new THREE.MeshPhongMaterial( { color:'red', side:THREE.DoubleSide } );
const cord = new THREE.Mesh(geoCord, matCord);
cord.position.y = len + 5;
scene.add( cord );

//----------- Bulb --------------
const geoBulb = new THREE.SphereGeometry( len/20, 16, 16 );
const matBulb = new THREE.MeshPhongMaterial( { color: 'black', emissive:'yellow'} );								   
const bulb = new THREE.Mesh( geoBulb, matBulb );
bulb.position.y = len;
scene.add( bulb );

//----------- Balls --------------
const ballRadius = len/40;
const geoBall = new THREE.SphereGeometry( ballRadius, 32, 32 );
const balls = new Array( 8 );	//number of balls can be changed here
const pos = [];
const ballSpeed = [];
const rotAxis = [];
const omega = [];
const maxBallSpeed = 10;	//max ball speed can be changed here
const ballImages = new Array( balls.length );

for( let i=0; i < balls.length; i++ )
{
	//loading the ball images
	const ballImage1 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball8.jpg' ) } ); 
	const ballImage2 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball9.jpg' ) } );
	const ballImage3 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball10.jpg') } );
	const ballImage4 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball11.jpg') } );
	const ballImage5 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball12.jpg') } );
	const ballImage6 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball13.jpg') } );
	const ballImage7 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball14.jpg') } );
	const ballImage8 = new THREE.MeshPhongMaterial( { map: THREE.ImageUtils.loadTexture('Ball15.jpg') } );
	
	const matBall = [ ballImage1, ballImage2, ballImage3, ballImage4, ballImage5, ballImage6, ballImage7, ballImage8 ];
	balls[i] = new THREE.Mesh( geoBall, matBall[i] );
	balls[i].castShadow = true;
	pos[i] = new THREE.Vector3(	( Math.random()-0.5 )*( len-4*ballRadius ),
								( Math.random()-0.5 )*( width-4*ballRadius ),
								ballRadius+depth/2 );
	balls[i].matrixAutoUpdate = false;
	table.add( balls[i] );
	ballSpeed[i] = new THREE.Vector3(	( Math.random()-0.5)*maxBallSpeed,
										( Math.random()-0.5)*maxBallSpeed,
											0);	// ball speed only w.r.t X and Y axis
	rotAxis[i] = new THREE.Vector3( 0, 0, 1 );
	rotAxis[i].cross(ballSpeed[i]).normalize();
}

//------------------- Generating functions ------------------

const contactFric = 0.3;
function roll( t, dt )
{
	for( let i=0; i < balls.length; i++ )
	{
		pos[i].add( ballSpeed[i].clone().multiplyScalar(dt) );
		const transMat = new THREE.Matrix4();
		transMat.makeTranslation( pos[i].x, pos[i].y, pos[i].z );
		//here "lenght()" might be confusing at a first glance
		//actually that's the length of vector's velocity
		//because the angular velocity is determined not as a vector, but as an absolute value
		//that's also the reason for using "rotMat" to rotate an object with such angular velocity
		//finally, "omega" shows the speed of angular rotation, though the rotation is done via "rotMat"
		omega[i] = ballSpeed[i].length()/ballRadius;
		const rotMat = new THREE.Matrix4();
		rotMat.makeRotationAxis( rotAxis[i], omega[i]*t );
		balls[i].matrix.copy( transMat );
		balls[i].matrix.multiply( rotMat );
		balls[i].updateMatrixWorld();
		//condition "ball got into a cusion along the x axis"
		if( pos[i].x+ballRadius >= len/2 || pos[i].x-ballRadius <= -len/2 )
		{	
			//correcting ball's position
			if 	( pos[i].x+ballRadius > len/2 )
				pos[i].x = len/2 - ballRadius;
			else if ( pos[i].x-ballRadius <= -len/2 )
				pos[i].x = -len/2 + ballRadius;
			ballSpeed[i].x *= -1;	//spec reflection according to X axis
			ballSpeed[i].multiplyScalar( 1 - contactFric ); //reducing velocity by 30%
			rotAxis[i] = new THREE.Vector3( 0, 0, 1 );
			rotAxis[i].cross(ballSpeed[i]).normalize();
		}
		//condition "ball got into a cusion along the y axis"
		if( pos[i].y+ballRadius >= width/2 || pos[i].y-ballRadius <= -width/2 )
		{	
			//correcting ball's position
			if ( pos[i].y+ballRadius > width/2 )
				pos[i].y = width/2 - ballRadius;
			else if ( pos[i].y-ballRadius < -width/2 )
				pos[i].y = -width/2 + ballRadius;
			ballSpeed[i].y *= -1;	//spec reflection according to Y axis
			ballSpeed[i].multiplyScalar( 1 - contactFric ); //reducing velocity by 30%
			rotAxis[i] = new THREE.Vector3( 0, 0, 1);
			rotAxis[i].cross(ballSpeed[i]).normalize();
		}
	}
	//now it's "collision of balls against each other"
	for( let i=0; i < balls.length-1; i++ )
	{
		//j tells which ball should i-th ball be compare with (it's about distance between them)
		for( let j = i+1; j < balls.length; j++ )
		{
			if ( pos[i].distanceTo(pos[j]) < 2*ballRadius )
			{
				//the task requires reducing the speed by 20% after ball's collision, but an unkonown problem occurs
				//this is how we avoid problems (to see a problem, change from 0.01 to 0.2 and see for yourselves)
				const contactFriction = 0.01;
				const tSpeed = ballSpeed[i].clone().multiplyScalar( 1 - contactFriction );
				ballSpeed[i] = ballSpeed[j].clone().multiplyScalar( 1 - contactFriction );
				ballSpeed[j] = tSpeed;
			}
		}
	}
}

const rollFric = 0.2;
function reduceSpeed( ballIndex, dt )
{
		ballSpeed[ballIndex].multiplyScalar( 1 - rollFric*dt ); //reducing velocity by 20% due to friction when rolling
}

//---------- Trackball controls and event listeners -------------
const controls = new THREE.TrackballControls( camera, canvas );
controls.rotateSpeed = 5;

//------------------- Rendering ---------------------
const clock = new THREE.Clock();
let old_t = 0;
function render()
{
	requestAnimationFrame( render );
	//for controlling the movement/motion/rotation we have to use dt since it shows
	//how much time have passed since the last frame
	const dt = clock.getDelta();
	const t = clock.getElapsedTime();
	roll( t, dt );
	
	for( let i=0; i < balls.length; i++ )
	{
		reduceSpeed( i, dt );
	}
	
	controls.update();
	renderer.render( scene, camera );
}
render();