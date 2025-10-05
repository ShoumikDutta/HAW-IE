/*
	Student: Ievgenii Nudga
	Matr. num.: 2159839
	Date: 30.11.2017
	Semester: IE7
	Course: CM1
*/

//---------- Initialize webGL --------------
const canvas = document.getElementById('mycanvas');
const renderer = new THREE.WebGLRenderer( {canvas:canvas, antialias:true} );
renderer.setSize( window.innerWidth, window.innerHeight );
renderer.setClearColor('lightsteelblue');    

//---------- Create a scene with camera and light --------
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 100, canvas.width / canvas.height, 0.1, 1000 );
camera.position.set( 0, 13, 0.1 );
camera.lookAt( scene.position ); //camera looks at the origin
const ambientLight = new THREE.AmbientLight('white');
scene.add( ambientLight );

//------------- Axishelper --------------
const axisHelper = new THREE.AxisHelper( 15 );
scene.add( axisHelper );

//------------- Clock body --------------
const clockRadius = 10;
const clockHeight = 1;
const geometry1 = new THREE.CylinderGeometry( clockRadius, clockRadius, clockHeight, 64 );
const material1 = new THREE.MeshPhongMaterial( {color: 'black',
												polygonOffset: true,
												polygonOffsetFactor: 2,
												polygonOffsetUnits: 2,} );
const clockBody = new THREE.Mesh( geometry1, material1 );
scene.add( clockBody );

//------------- Clock's outer ring -------------- 
//цикл нужен, если форма нужна более математичная, например синусоида там или еще что хитрое
//var points = [new THREE.Vector3( 10, -1, 0.5), new THREE.Vector3( 10.1 , 0, 0.5), new THREE.Vector3( 10, 1, 0.5)];
//здесь мы строит цилиндр из 3х слоев
//первый на удалении 0 - 1 = -1 , второй на удалении 1 - 1 = 0 и третий на удалении 2 -1 = 1
//можно построить и из 2х слоев
//слоев нужно больше только если мы хотим цилиндр разной толщины на разном удалении от центра
// var points = [];
// for ( var i = 0; i < 3; i++ ) {
	// // points.push( new THREE.Vector2( Math.sin( i * 0.01 ) * 10 + 10, ( i - 5 ) * 0.5 ) );
	
	// // //points.push( new THREE.Vector3( 10+i*1, 5, 10 ) );
	// //  ; 0- смещение кольца вперёд-назад относительно часов;
	
	// //points.push( new THREE.CylinderGeometry( clockRadius+2, clockRadius+2, clockHeight+1, 64 ) );
	
	// //первый параметр - радиус цилиндра, второй - его удаление от центра координат, третий - я думал толщина 
	// // points.push(new THREE.Vector3( 10, i - 1, 0.5));
	// var points = [
      // new THREE.Vector3( 10+i*10,     1,  10),//top left
      // new THREE.Vector3( 10+i*10-10, -1,  10),//top right
      // new THREE.Vector3( 10+i*10-10,  1, -10),//bottom right
      // new THREE.Vector3( 10+i*10,    -1, -10),//bottom left
      // new THREE.Vector3( 10+i*10,     1,  10) //back to top left - close square path
    // ];
// }
const points = [
      new THREE.Vector3( clockRadius+0.2,  1,  10),//top left
      new THREE.Vector3( clockRadius,   -1,  10),//top right
      new THREE.Vector3( clockRadius,    1, -10),//bottom right
      new THREE.Vector3( clockRadius+0.2, -1, -10),//bottom left
      new THREE.Vector3( clockRadius+0.2,  1,  10) //back to top left - close square path
    ];
const geometry2 = new THREE.LatheGeometry( points, 100 ); //with 100 we smooth the object making it round
//var geometry2 = new THREE.LatheGeometry( new THREE.CylinderGeometry( clockRadius+20, clockRadius+20, clockHeight+10, 64 ) );
const material2 = new THREE.MeshBasicMaterial( {color: 'gray',
												side: THREE.DoubleSide,//that's the trick with rendering two sides
												polygonOffset: true,
												polygonOffsetFactor: 1,
												polygonOffsetUnits: 1} );
const ring = new THREE.Mesh( geometry2, material2 );
clockBody.add( ring );

//------------- Clock face ( main face ) --------------
const geometry3 = new THREE.CircleGeometry( clockRadius, 64 );
const material3 = new THREE.MeshBasicMaterial( {color: 'white',
												side: THREE.DoubleSide,
												polygonOffset: true,
												polygonOffsetFactor: 1,
												polygonOffsetUnits: 1} );
const clockFace = new THREE.Mesh( geometry3, material3 );
clockFace.position.y = clockHeight/2;// we put the face on one of clock's surfaces
clockFace.rotateX( Math.PI/2 ); 
clockBody.add( clockFace );

//------------- Blob at the centre of clock --------------
const geometry4 = new THREE.SphereGeometry( clockRadius/15, 32, 32 );
const material4 = new THREE.MeshBasicMaterial( {color: 'black'} );
const blob = new THREE.Mesh( geometry4, material4 );
clockFace.add( blob );

//------------- Minutes "hand" --------------
const handLength = clockRadius/5;
const geometry5 = new THREE.SphereGeometry( handLength, 32, 32 );
const material5 = new THREE.MeshBasicMaterial( {color: 'black', side: THREE.DoubleSide} );
const minuteHand = new THREE.Mesh( geometry5, material5 );
minuteHand.scale.set( 0.2, 2, 0.1 );
minuteHand.position.set( 0, 
						-minuteHand.scale.y*handLength,
						-minuteHand.scale.z*handLength/2 );

//------------- Hour "hand" --------------
const hourHand = minuteHand.clone();
hourHand.scale.set( 0.1, 1.5, 0.1 );
hourHand.position.set( 	0, 
						-hourHand.scale.y*handLength,
						-hourHand.scale.z*handLength/2 );

//------------- Normal "ticks" --------------
const normalTickHeight = 1.5;
const normalTickWidth = 0.4;
const geometry6 = new THREE.PlaneGeometry( normalTickWidth, normalTickHeight );
const material6 = new THREE.MeshBasicMaterial( {color: 'red', side: THREE.DoubleSide} );
const normalTick = new THREE.Mesh( geometry6, material6 );
//creating one more tick to mark the twelve o'clock position - it will be positioned over the red tick
const geometry7 = new THREE.PlaneGeometry( normalTickWidth, normalTickHeight );
const material7 = new THREE.MeshBasicMaterial( {color: 'black', side: THREE.DoubleSide} );
const normalTickMarked = new THREE.Mesh( geometry7, material7 );

normalTick.position.y = normalTickHeight/2-clockRadius;
normalTickMarked.position.y = normalTick.position.y;
clockFace.add( normalTickMarked );
createTicks( normalTick, 12 );

//------------- Seconds "hand" --------------
const geometry8 = new THREE.PlaneGeometry( normalTickWidth, normalTickHeight );
const material8 = new THREE.MeshBasicMaterial( {color: 'red', side: THREE.DoubleSide} );
const secHand = new THREE.Mesh( geometry8, material8 );
secHand.scale.set( 0.5, 5, 1 );
secHand.position.set(    0, 
					  ( -0.35 )*secHand.scale.y*normalTickMarked.geometry.parameters.height,
					  ( -0.3 )*handLength ); //this way seconds "hand" would be over hours and minute "hands"
					  
//------------- Blob in seconds "hand" --------------
const geometry9 = new THREE.SphereGeometry( clockRadius/20, 32, 32 );
const material9 = new THREE.MeshPhongMaterial( {color: 'red'} );
const secBlob = new THREE.Mesh( geometry9, material9 );
secBlob.position.set(    0, 
					  ( -0.7 )*secHand.scale.y*normalTickMarked.geometry.parameters.height,
					  ( -0.3 )*handLength ); //this way "seconds" blob would
											 //be less obstructed by hours and minute "hands"

//------------- Small "ticks" --------------
const smallTick = normalTick.clone();
smallTick.scale.set( 0.5, 0.5, 0.1);
//for normal ticks we used normalTickHeight/2-clockRadius
//but big ticks are 2 times longer => for small ticks which are shorter we need
//scale 0.5, meaning we need (normalTickHeight/2)/2 = normalTickHeight/4
//in such way we can place small ticks right at the border of the clock
smallTick.position.y = normalTickHeight/4-clockRadius;
createTicks( smallTick, 60 );


//------------- Back clock face --------------
//after creating main things (clock face, minute hand, hour hand) we can clone them???????????????????
const clockFaceHome = clockFace.clone();
clockFaceHome.rotateY( Math.PI );
clockFaceHome.position.y = -clockHeight/2;
clockBody.add( clockFaceHome );

clockFace.add( secBlob );
clockFace.add( secHand );
clockFace.add( minuteHand );
clockFace.add( hourHand );

//------------- Hands for back clock face --------------
const secBlobHome = secBlob.clone();
const secHandHome = secHand.clone();
const minuteHandHome = minuteHand.clone();
const hourHandHome = hourHand.clone();

clockFaceHome.add( secBlobHome );
clockFaceHome.add( secHandHome );
clockFaceHome.add( minuteHandHome );
clockFaceHome.add( hourHandHome );

//------------ Generating functions ------------
	 
function rotate( obj, angle ) //rotating the object with rotation matrix with the passed angle
{
	const rotMatrix = new THREE.Matrix3().set( Math.cos(angle), -Math.sin(angle), 0,
											Math.sin(angle), Math.cos(angle), 0,
											0, 0, 1 );	//rotation around Z axis
	obj.position.applyMatrix3( rotMatrix );
	obj.rotateZ( angle );
}

function createTicks( ticks, numOfTicks )// rotating and adding the "ticks"
{
	const angle = 2*Math.PI/numOfTicks;
	for ( let i=1; i < numOfTicks; i++ )
	{
		const ticks1 = ticks.clone();
		rotate( ticks1, i*angle );
		clockFace.add( ticks1 );
	}
}

//---------- Angles of rotation for each hand at every second ----------
const angle_sec = Math.PI/30;		// (2*pi)/60 = pi/30
const angle_min = angle_sec/60;
const angle_h = angle_min/12;		// 12 = 60/5

//---------- Getting time ------------------
let now = new Date();
let seconds = now.getSeconds();
let minutes = now.getMinutes();
let hours = now.getHours();
let hoursHome = ( hours + 1 );

//------- Starting positions of the hands at the current time --------

//the point is to get the current time and then start the rotating in the render function
//main face, Hamburg time =)
rotate( secBlob, seconds*angle_sec );
rotate( secHand, seconds*angle_sec );
rotate( minuteHand, minutes*angle_sec + seconds*angle_min );
rotate( hourHand, 5*( hours*angle_sec + minutes*angle_min + seconds*angle_h ) );
//second face, Kiew time =)
rotate( secBlobHome, seconds*angle_sec );
rotate( secHandHome, seconds*angle_sec );
rotate( minuteHandHome, minutes*angle_sec + seconds*angle_min );
rotate( hourHandHome, 5*( hoursHome*angle_sec + minutes*angle_min + seconds*angle_h ) );


//---------- Trackball controls and  event listeners -------------
const controls = new THREE.TrackballControls( camera, canvas );
//const clock = new THREE.Clock(); //оно не нужно для трекбола
controls.rotateSpeed = 5;

function myCallback(event)
{//using 'R' to reset the clock to the initial position
	if (event.keyCode == 82) {
			event.preventDefault(); // prevent default key behavior
			controls.reset();
		}		
}

document.addEventListener( "keydown", myCallback );

//------------- Rendering ----------------
function render()
{	
	requestAnimationFrame( render );
	
	// now = new Date();
	// const nextSeconds = now.getSeconds();
	// //if( nextSeconds != seconds )//i.e. 60-59 = 1, meaning true at every second
	// //and in such manner the time will not go with high speed
	// if( nextSeconds != seconds )
	// {		
		// seconds = nextSeconds;
		// rotate( secBlob, angle_sec );
		// rotate( secHand, angle_sec );
		// rotate( minuteHand, angle_min );
		// rotate( hourHand, angle_h) ;
		// rotate( secBlobHome, angle_sec );
		// rotate( secHandHome, angle_sec) ;
		// rotate( minuteHandHome, angle_min) ;
		// rotate( hourHandHome, angle_h) ;
	// }
	
	rotate( secBlob, angle_sec );
	rotate( secHand, angle_sec );
	rotate( minuteHand, angle_min );
	rotate( hourHand, angle_h) ;
	rotate( secBlobHome, angle_sec );
	rotate( secHandHome, angle_sec) ;
	rotate( minuteHandHome, angle_min) ;
	rotate( hourHandHome, angle_h) ;

	controls.update();
	renderer.render( scene, camera );	
}
render();