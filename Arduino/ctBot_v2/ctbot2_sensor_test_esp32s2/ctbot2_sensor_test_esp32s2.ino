#include <SparkFun_GridEYE_Arduino_Library.h>
#include <QTRSensors.h>
#include "Adafruit_Crickit.h"
#include "seesaw_motor.h"
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ST7789.h>  // Hardware-specific library for ST7789
#include <Fonts/FreeSans12pt7b.h>

// Crickit
Adafruit_Crickit crickit;
seesaw_Motor motor_a(&crickit);
seesaw_Motor motor_b(&crickit);

// TFT
Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);
GFXcanvas16 canvas(240, 135);

// QTR Sensor Array
#define USE_LINESENSOR
#ifdef USE_LINESENSOR
QTRSensors qtr;
#define DEBUG_QTR_LINESENSOR 

const uint8_t SensorCount = 6;
uint16_t sensorValues[SensorCount];
#endif
// Qwicc Zio
#define SLAVE_BROADCAST_ADDR 0x00  //default address
#define SLAVE_ADDR 0x00            //SLAVE_ADDR 0xA0-0xAF
//#define DEBUG_ULTRASONIC

// Qwicc GridEYE
//#define DEBUG_GRIDEYE
// Use these values (in degrees C) to adjust the contrast
#define HOT 40
#define COLD 20
#define MAX_X 8
#define MAX_Y 8
// This table can be of type int because we map the pixel
// temperature to 0-3. Temperatures are reported by the
// library as floats
int pixelTable[64];
int pixelEval[MAX_Y];
GridEYE grideye;


uint16_t distance_mm = 0;

uint16_t readUltraSonic() {
  uint8_t distance_H = 0;
  uint8_t distance_L = 0;
  uint16_t distance = 0;

  Wire.beginTransmission(SLAVE_ADDR);  // transmit to device #8
  Wire.write(1);                       // measure command: 0x01
  Wire.endTransmission();              // stop transmitting

  Wire.requestFrom(SLAVE_ADDR, 2);  // request 6 bytes from slave device #8
  if (Wire.available()) {           // slave may send less than requested
    distance_H = Wire.read();       // receive a byte as character
    distance_L = Wire.read();
    distance = (uint16_t)distance_H << 8;
    distance = distance | distance_L;
#ifdef DEBUG_ULTRASONIC
    Serial.print(distance);  // print the character
    Serial.println("mm");
    delay(1);
#endif
  }
  return distance;  // distance in mm
}

void readGridEye() {
  for (unsigned char i = 0; i < 64; i++) {
    pixelTable[i] = map(grideye.getPixelTemperature(i), COLD, HOT, 0, 3);
  }
#ifdef DEBUG_GRIDEYE
  for (unsigned char i = 0; i < 64; i++) {
    if (pixelTable[i] == 0) {
      Serial.print(".");
    } else if (pixelTable[i] == 1) {
      Serial.print("o");
    } else if (pixelTable[i] == 2) {
      Serial.print("0");
    } else if (pixelTable[i] == 3) {
      Serial.print("O");
    }
    Serial.print(" ");
    if ((i + 1) % 8 == 0) {
      Serial.println();
    }
  }
  Serial.println();
  Serial.println();
#endif
}

void evaluateGridEye() {
  int y, ofs;

  for (y = 0; y < MAX_Y; y++) {
    pixelEval[y] = 0;
  }
  for (ofs = 0; ofs < MAX_X; ofs++) {
    for (y = 0; y < MAX_Y; y++) {
      if (pixelTable[y * ofs + y] > 0) pixelEval[y]++;
    }
  }
#ifdef DEBUG_GRIDEYE
  for (y = 0; y < MAX_Y; y++) {
    Serial.print(pixelEval[y], DEC);
    Serial.print(",");
  }
  Serial.println();
#endif
}

uint16_t position = 0;

#ifdef USE_LINESENSOR
void readQTRLineSensor() {
  // read calibrated sensor values and obtain a measure of the line position
  // from 0 to 5000 (for a white line, use readLineWhite() instead)
  position = qtr.readLineBlack(sensorValues);
#ifdef DEBUG_QTR_LINESENSOR
  for (uint8_t i = 0; i < SensorCount; i++)
  {
    Serial.print(sensorValues[i]);
    Serial.print('\t');
  }
  Serial.println(position);
#endif
}
#endif

int yofs[MAX_Y] = { 56, 48, 40, 32, 24, 16, 8, 0 };
int xofs[MAX_X] = { 0, 8, 16, 24, 32, 40, 48, 56 };

void updateDisplay() {
  int x, y, idx;
  // Clear the buffer.
  canvas.fillScreen(ST77XX_BLACK);
  // show ultrasonic
  canvas.setFont(&FreeSans12pt7b);
  canvas.setCursor(80, 25);
  canvas.print("       mm");
  canvas.setCursor(80, 25);
  if (distance_mm < 100) {
    canvas.setTextColor(ST77XX_RED);
  } else if (distance_mm < 300) {
    canvas.setTextColor(ST77XX_YELLOW);
  } else {
    canvas.setTextColor(ST77XX_GREEN);
  }
  canvas.print(distance_mm, DEC);

  canvas.setCursor(80, 50);
  canvas.setTextColor(ST77XX_WHITE);
  canvas.print("         ");
  canvas.setCursor(80, 50);
  canvas.print(position, DEC);

  canvas.setCursor(0, 0);
  canvas.setFont();
  canvas.setTextColor(ST77XX_WHITE);

  for (int y = 0; y < MAX_Y; y++) {
    for (int x = 0; x < MAX_X; x++) {
      idx = (y * MAX_X) + x;
      //canvas.setCursor(yofs[y], xofs[x]);
      if (pixelTable[idx] == 0) {
        //canvas.setTextColor(ST77XX_BLUE);
        //canvas.print(".");
        canvas.fillRect(yofs[y], xofs[x], 8, 8, ST77XX_BLUE);
      } else if (pixelTable[idx] == 1) {
        //canvas.setTextColor(ST77XX_YELLOW);
        //canvas.print("o");
        canvas.fillRect(yofs[y], xofs[x], 8, 8, ST77XX_YELLOW);
      } else if (pixelTable[idx] == 2) {
        //canvas.setTextColor(ST77XX_ORANGE);
        //canvas.print("0");
        canvas.fillRect(yofs[y], xofs[x], 8, 8, ST77XX_ORANGE);
      } else if (pixelTable[idx] == 3) {
        //canvas.setTextColor(ST77XX_RED);
        //canvas.print("O");
        canvas.fillRect(yofs[y], xofs[x], 8, 8, ST77XX_RED);
      }
    }
  }
  tft.drawRGBBitmap(0, 0, canvas.getBuffer(), 240, 135);
  //tft.display();
}

void followLine() {
  if (distance_mm > 0 && distance_mm < 100) {
    motor_a.throttle(0);
    motor_b.throttle(0);
  }
  else if (position < 2000) {
    motor_a.throttle(0.06);
    motor_b.throttle(-0.06);

  }
  else if (position > 3000) {
    motor_a.throttle(-0.06);
    motor_b.throttle(0.06);
  
  }
  else {
    motor_a.throttle(0.06);
    motor_b.throttle(0.06);

  }
}

void followHand() {
  if (distance_mm > 0 && distance_mm < 150) {
    motor_a.throttle(-0.05);
    motor_b.throttle(-0.05);

  }
  else if (distance_mm > 200 && distance_mm < 300) {
    motor_a.throttle(0.07);
    motor_b.throttle(0.07);
  
  }
  else {
    motor_a.throttle(0);
    motor_b.throttle(0);

  }
}

void setup() {
  Serial.begin(115200);

  Serial.println("ct-Bot-v2 Sensor test");
  delay(250);  // wait for the OLED to power up

  if(!crickit.begin()){
    Serial.println("ERROR!");
    while(1) delay(1);
  }
  else Serial.println("Crickit started");


  Wire.begin();
  // Library assumes "Wire" for I2C but you can pass something else with begin() if you like
  grideye.begin();

#ifdef USE_LINESENSOR
  // configure the sensors
  qtr.setTypeRC();
  qtr.setSensorPins((const uint8_t[]){A0, A1, A2, A3, A4, A5}, SensorCount);
  qtr.setEmitterPin(13);
  delay(500);
#endif

  //attach motor a
  motor_a.attach(CRICKIT_MOTOR_A1, CRICKIT_MOTOR_A2);

  //attach motor b
  motor_b.attach(CRICKIT_MOTOR_B1, CRICKIT_MOTOR_B2);

  // turn on backlite
  pinMode(TFT_BACKLITE, OUTPUT);
  digitalWrite(TFT_BACKLITE, HIGH);

  // turn on the TFT / I2C power supply
  pinMode(TFT_I2C_POWER, OUTPUT);
  digitalWrite(TFT_I2C_POWER, HIGH);
  delay(10);

  // initialize TFT
  tft.init(135, 240);  // Init ST7789 240x135
  tft.setRotation(3);
  tft.fillScreen(ST77XX_BLACK);
  canvas.setFont(&FreeSans12pt7b);
  canvas.setTextColor(ST77XX_WHITE);
  Serial.println("ct-Bot start");

  // Show image buffer on the display hardware.
  // Since the buffer is intialized with an Adafruit splashscreen
  // internally, this will display the splashscreen.
  //tft.display();
  // analogRead() takes about 0.1 ms on an AVR.
  // 0.1 ms per sensor * 4 samples per sensor read (default) * 6 sensors
  // * 10 reads per calibrate() call = ~24 ms per calibrate() call.
  // Call calibrate() 400 times to make calibration take about 10 seconds.
#ifdef USE_LINESENSOR
  for (uint16_t i = 0; i < 400; i++)
  {
    qtr.calibrate();
  }
  for (uint8_t i = 0; i < SensorCount; i++)
  {
    Serial.print(qtr.calibrationOn.minimum[i]);
    Serial.print(' ');
  }
  Serial.println();

  // print the calibration maximum values measured when emitters were on
  for (uint8_t i = 0; i < SensorCount; i++)
  {
    Serial.print(qtr.calibrationOn.maximum[i]);
    Serial.print(' ');
  }
#endif
  // Clear the buffer.
  canvas.fillScreen(ST77XX_BLACK);

  // text display tests
  //tft.setTextSize(1);
  canvas.setTextColor(ST77XX_WHITE);
  canvas.setCursor(0, 0);
  canvas.print("ct-Bot v2 Sensors");
  tft.drawRGBBitmap(0, 0, canvas.getBuffer(), 240, 135);
  //tft.display(); // actually display all of the above
  delay(1000);
}


void loop() {
  distance_mm = readUltraSonic();
  readGridEye();
  evaluateGridEye();
  readQTRLineSensor();
  followLine();
  //followHand();

  yield();
  updateDisplay();
  delay(100);
}
