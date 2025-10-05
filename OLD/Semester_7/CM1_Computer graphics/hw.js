console.log("Hello World!");

// --- Variables and types ---
var x = 2;
var y = 4;
var z = (x+2)*y;

// Maths
y = Math.sin(x);
y = Math.pow(x,3);  // x^3, no ^-operator in JS
var pi = Math.PI;


// Special values and types
var u1 = undefined;
var u2 = Number.NaN;
var u3 = null;

// Strings
z = 'abc';
var z1 = "xyz";
var zType = typeof z;
console.log('The value of z = ' + z);     // String concatenation
console.log('x='+x);

// logical comparison
var flag = (7>3);
x = 2;
y = 2;
console.log(x==y);
console.log(x===y);
console.log(2=="2");   // true if equal up to type conversion
console.log(2==="2");   // true if type and value are the same


// --- Control flow ---
// while and switch similar to C
var count = 0;
for(var k=0; k<5; k++) {
   count += 2;
}
console.log("count="+count);



if (count>8) {
   // executed
} else {
   // not executed
}


// Simple user interaction
// alert("Message");
// var x = prompt('Some question');

// Exercise: Multiplication app

// --- Functions ---
function f1(a,b,c) {
   var tmp = a+b+c;   // tmp is local variable
   return tmp;
}

x = f1(1,2,3);

// function definition is assignment:
var f2 = function(a,b,c) {
   return a*b*c;
};

var s = Math.sin;     // alias for Math.sin
console.log(s(Math.PI));


// Exercise: Newton iteration


// --- Arrays ---
var v1 = [1,2,3,4];			//accessing bigger index is undefined
var v2 = new Array(4);
for (k=0; k<v2.length; ++k) {
   console.log(k);
   v2[k] = Math.random();
}


var v = [];			//empty array
v[4] = 12;			//result is: [undefined x 4, 12], length is 5

v = [];
v[0] = 12;
v[1] = 'Hallo';

v = [1,2,3,4];
console.log(v[2]);
Math.sin(v);     // doesn't work like Matlab :-(


function myPrint(value, idx) {	//function used in forEach must have this signature
   console.log('The value at index ' + idx + ' is ' + value);
}
v.forEach(myPrint);			//function forEach doesn't return anything


function mySine(value) {
   return Math.sin(value);
}
var w = v.map(mySine);		//function map returns new array

//using anonimous function
var w2 = v.map(function(value) {
   return Math.sin(value);
});

var w3 = v.map(Math.sin); 



//  --- Objects ---
var A = {
      x: 3,
      y: 'Hello'
};


var obj = {
   field1: 12,
   field2: 'Hello',
   func: function() {
      console.log('Here is f');
      console.log('field 1 = '  + this.field1);	//THIS must be here in order to look for the local variable
   }
};

// Copying means creating a new reference, not a new object !!
var obj2 = obj;
obj2.field1 = 15;
obj2.func();    // as expected field1 is 15
obj.func();     // !! field1 is also 15


// --- Errors ---
function factorial(n) {
   if (n===0 || n===1) {
      return 1;
   } else if(n>1) {
      return n*factorial(n-1);
   } else {
      throw Error("n must be a non-negative integer");
   }
}

try {
   x = factorial(2.3);
} catch(err) {
   console.log("Something happened: " + err.message);
}




// the with statement: to be avoided
with(Math) {
   x = sin(PI/2);
     console.log(x);
}

// Browser code runs in
// with (window) {
// ...
// }
//


// with is slow and dangerous
function ff(E) {
   with(Math) {
      return sin(E);
   }
}
