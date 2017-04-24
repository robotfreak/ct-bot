
// analog inputs
const int distLtPin  = A0;    // distance sensor left
const int distRtPin  = A1;    // distance sensor right
const int lineLtPin  = A2;    // line sensor left
const int lineRtPin  = A3;    // line sensor right
const int ldrLtPin   = A4;    // ldr sensor left
const int ldrRtPin   = A5;    // ldr sensor right
const int cliffLtPin = A6;    // cliff sensor left
const int cliffRtPin = A7;    // cliff sensor right

// digital pins
const int rxPin      = 0;     // PD0 RXD0
const int txPin      = 1;     // PD1 TXD0
const int ctsPin     = 2;     // PD2 RXD1
const int wheelRtPin = 3;     // PD3 RXD2
const int pwm1bPin   = 30;    // PD4 OC1B
const int pwm1aPin   = 8;     // PD5 OC1A
const int doorPin    = 9;     // PD6 OC2B
const int pwm2Pin    = 31;    // PD7 OC2A

const int barrierPin = 4;     // PB0 
const int remotePin  = 5;     // PB1 
const int errorPin   = 6;     // PB2 AIN0
const int pmw0Pin    = 7;     // PB3 AIN1 OC0A
const int wheelLtPin = 10;    // PB4 SS OC0B
const int mosiPin    = 11;    // PB5 MOSI
const int misoPin    = 12;    // PB6 MISO
const int sclkPin    = 13;    // PB7 SCK

const int dataPin    = 22;    // PC0 SCL SH595 1,2,3 data pin
const int latch1Pin  = 23;    // PC1 SDA SH595 1 latch pin
const int latch2Pin  = 23;    // PC1 TCK SH595 2 latch pin
const int latch3Pin  = 24;    // PC2 TCK SH595 3 latch pin
const int clock1Pin  = 26;    // PC4 TDO SH595 1 clock pin
const int clock2Pin  = 25;    // PC3 TMS SH595 2 clock pin
const int clock3Pin  = 23;    // PC1 TMS SH595 3 clock pin
const int pc5Pin     = 27;    // PC5 TDI
const int pc6Pin     = 28;    // PC6 
const int pc7Pin     = 29;    // PC7 

// shift register definitions
// shift register 1 led pins
#define LED_FRONT_LT   (1 << 0)
#define LED_FRONT_RT   (1 << 1)
#define LED_BLUE       (1 << 2)
#define LED_RED        (1 << 3)
#define LED_ORANGE     (1 << 4)
#define LED_YELLOW     (1 << 5)
#define LED_GREEN      (1 << 6)
#define LED_WHITE      (1 << 7)
// shift register 2 enable pins
#define ENA_DIST_SENS  (1 << 0)
#define ENA_WHEEL_SENS (1 << 1)
#define ENA_BARRIER    (1 << 2)
#define ENA_CLIFF_SENS (1 << 3) 
#define ENA_DOOR_SENS  (1 << 4) 
#define ENA_MOUSE      (1 << 5) 
#define ENA_EXP1       (1 << 6) 
#define ENA_EXP2       (1 << 7) 
// shift register 3 lcd pins


// sensor Defines
//#define LEFT 0
//#define RIGHT 1

// global variables
int ledState = 0;        // all leds off
int blockState = 0xFF;   // all enable blocks off

// shift register functions
void shiftClear(void)
{
  digitalWrite(latch2Pin, LOW);
  digitalWrite(latch1Pin, LOW);
  digitalWrite(clock2Pin, LOW);
  digitalWrite(clock1Pin, LOW);
  digitalWrite(dataPin, LOW);
}

void initShiftRegister(void)
{
  pinMode(latch2Pin, OUTPUT);
  pinMode(latch1Pin, OUTPUT);
  pinMode(clock2Pin, OUTPUT);
  pinMode(clock1Pin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  shiftClear();

}

void shiftDataOut(uint8_t data, int latchPin, int clockPin)
{
  shiftClear();
  // shift out the bits:
  shiftOut(dataPin, clockPin, MSBFIRST, data);  
  //take the latch pin high so the LEDs will light up:
  digitalWrite(latchPin, HIGH);
  delay(1);
  shiftClear();
 
}

// led functions
void setLed(uint8_t led, int state)
{
  if (state)
    ledState |= led;
  else
    ledState &= ~led;
 shiftDataOut(ledState,latch1Pin, clock1Pin); 
}

void setAllLeds(uint8_t leds)
{
  ledState = leds;
  shiftDataOut(ledState, latch1Pin, clock1Pin); 
}

// enable block functions
void enableBlock(uint8_t block, int state)
{
  // inverse logic, On = LOW, Off = HIGH
  if (state)
    blockState &= ~block;
  else
    blockState |= block;
 shiftDataOut(blockState,latch2Pin, clock2Pin); 
 delay(20);  
}

void enableAllBlocks(uint8_t blocks)
{
  blockState = blocks;
  shiftDataOut(blockState, latch2Pin, clock2Pin);
  delay(100); 
}

// sensor functions
uint16_t readAnalogRaw(uint8_t analogIn)
{
  uint16_t ret;
  ret = analogRead(analogIn);
  return ret;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("c't-Bot Analog Test v0.1");
  initShiftRegister();
  setAllLeds(0);
//  enableAllBlocks(0);
  enableBlock(ENA_DIST_SENS, true );   // enable distance sensors block
  enableBlock(ENA_CLIFF_SENS, true );  // enable cliff sensors block
  enableBlock(ENA_MOUSE, true );       // enable line sensors block
}

void loop() {
  // send the value of analog input 0:
  Serial.print(analogRead(A0));
  Serial.print(",");
  Serial.print(analogRead(A1));
  Serial.print(",");
  Serial.print(analogRead(A2));
  Serial.print(",");
  Serial.print(analogRead(A3));
  Serial.print(",");
  Serial.print(analogRead(A4));
  Serial.print(",");
  Serial.print(analogRead(A5));
  Serial.print(",");
  Serial.print(analogRead(A6));
  Serial.print(",");
  Serial.print(analogRead(A7));
  Serial.println("");
  // wait a bit for the analog-to-digital converter
  // to stabilize after the last reading:
  delay(10);
}
