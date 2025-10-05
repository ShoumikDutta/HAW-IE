//Program for the slave 

// include LCD library code:
#include <LiquidCrystal.h>

//I2C lib
#include <Wire.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7, 8, 9, 10, 11, 12, 13);

void setup() {
  Wire.begin(4);                // join i2c bus with address #4
  Wire.onReceive(receiveEvent); // register event
  Serial.begin(9600); 
  
  digitalWrite(8, LOW);
  // set up the LCD's number of columns and rows:
  lcd.begin(8, 2);
  lcd.print("MASTER:");
  lcd.setCursor(0, 1); 
  lcd.print("SLAVE:");
}

void loop() {
  delay(100);
}

void receiveEvent(int howMany)
{
    char x = Wire.read(); // receive byte as a character
    Serial.println(x);
    lcd.setCursor(7, 0); // Print the char from master
    lcd.print(x);
    lcd.setCursor(7, 1); // Print the next char to the LCD.
    lcd.print(char(x+1));
}
