// Some basics about Javascript objects

var a1 = {x:1, y:2};
a1.f = function() {
   // The this keyword is necessary to refer to the fields of obj
   return this.x * this.y;
};

// Objects are reference types: copied variables refer to the same object
var a2 = a1;
a2.x = 12;
console.log(a1.x);   //12 because the prev. line the object that a1 and a2 refer to




// Creation of objects with same field with constructor
function A(a,b) {
   // "use strict";
   this.x = a;
   this.y = b;
   this.f = function() {return this.x*this.y;};
}
var b1 = new A(1,2);    // correct object creation
console.log(b1 instanceof A);
// var b2 = A(1,2);   // BUG: In this call 'this' refers to the global scope
var b2 = new A(3,4);


// Use the prototype to add something to any object of type A
A.prototype.z = 12;   // now accessible in all A objects

// Its a good idea to add methods to the prototype
A.prototype.f2 = function() {return this.x + this.y;};
