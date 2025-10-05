//Program for the slave

// include LCD library code:
#include <LiquidCrystal.h>
//I2C lib
#include <Wire.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7, 8, 9, 10, 11, 12, 13);
byte counter = 0;
byte counter1 = 0;
long startTime;
byte flag =0;
int signal = 3;
int uOut = 5;

void setup() {
  pinMode(signal, OUTPUT);
  pinMode(uOut, INPUT);
  analogWrite(signal, 255);
  digitalWrite(8, LOW);
  Wire.begin(8);                // join i2c bus with address #8, 1st lave
  //Wire.begin(9);                // join i2c bus with address #9, 2nd slave
  Wire.onReceive(receiveEvent); // register event
  Wire.onRequest(requestEvent);
  lcd.begin(8, 2);            // set up the LCD's number of columns and rows:
  lcd.print("AXES:");
}

void loop() { 
  lcd.setCursor(5, 0);
  lcd.print(counter1);
  if (digitalRead(uOut) == HIGH){
    startTime = millis();
    analogWrite(signal, 0); // red on
    do{
       if (digitalRead(uOut) == HIGH && !flag ){
          flag = 1;
       }
       if ((digitalRead(uOut) == LOW) && flag){
           counter1++;
           flag = 0;
       }
       lcd.setCursor(5, 0);     
       lcd.print(counter1);
    }while(millis() - startTime < 5000);
    counter = counter1; 
  } 
counter1=0;
startTime = 0;
}

void receiveEvent(int howMany)
{
  byte x = (byte)Wire.read(); // receive byte 0 or 255
  analogWrite(signal, x);
}
void requestEvent(){
  if(counter > 0){
    Wire.write(counter);
  }
  counter = 0;
}

