// Wire Master Writer
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Writes data to an I2C/TWI slave device
// Refer to the "Wire Slave Receiver" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>

byte axesSet,axesReceive;
byte slaveAddr = 1;

void setup()
{
  axesSet=0;
  Wire.begin(); // join i2c bus (address optional for master)
  Serial.begin(9600);
 
}



void loop()
{
  
  if(Wire.available()){
    if(axesSet){Serial.print(axesSet);
      axesReceive=Wire.read();
      if(axesReceive==axesSet){
        Wire.beginTransmission(1); // transmit to device #1
        Wire.write(255);              // sends one byte  
        Wire.endTransmission();    // stop transmitting
        slaveAddr++;
      }
      else {
        Wire.beginTransmission(1); // transmit to device #1
        Wire.write(0);              // sends one byte  
        Wire.endTransmission();    // stop transmitting
        slaveAddr++;
      }
    }
    else 
    {
       axesSet = Wire.read();
    }
  }
 

//  x++;
 // if(x=='z')x = 'a';
  delay(100);
}
