// Wire Master Writer

#include <Wire.h>

byte axesSet,axesReceive;
int slaveAddr = 8;

void setup()
{
  axesSet=0;
  Wire.begin(); // join i2c bus (address optional for master)
}
void loop()
{
  Wire.requestFrom(slaveAddr, 1,true);//request 8 bits from Slave #slaveAddr
  if(Wire.available()){
    if(axesSet){
      Wire.requestFrom(slaveAddr+1, 1, true);
      axesReceive=(byte)Wire.read();
      if(axesReceive==axesSet){ 
        Wire.beginTransmission(slaveAddr); // transmit to device #slaveAddr
        Wire.write(255);              // sends one byte  
        Wire.endTransmission();    // stop transmitting
        slaveAddr++;
      }
      else {
        Wire.beginTransmission(slaveAddr); // transmit to device #slaveAddr
        Wire.write(0);              // sends one byte  
        Wire.endTransmission();    // stop transmitting
      }
    }
    else 
    {
      axesSet = (byte)Wire.read();
    }
  }
  delay(500);
}
