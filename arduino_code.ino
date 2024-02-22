#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

//Provide the token generation process info.
#include <addons/TokenHelper.h>

//Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>
#include <WiFiManager.h>

#include <Adafruit_SSD1306.h>
#define OLED_Address 0x3C
Adafruit_SSD1306 oled(128, 64);
 
int a=0;
int lasta=0;
int lastb=0;
int LastTime=0;
int ThisTime;
bool BPMTiming=false;
bool BeatComplete=false;
int BPM=0;

#define UpperThreshold 560
#define LowerThreshold 530
#define API_KEY "FIREBASE_API_KEY"
#define DATABASE_URL "FIREBASE_DATABASE_URL"
#define DEVICE_ID "DEVICE_ID"
#define USER_EMAIL "FIREBASE_USER_EMAIL"
#define USER_PASSWORD "FIREBASE_USER_PASSWORD"
#define TRIGGER_PIN 0

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int timeout = 120; // seconds to run for

void setup() {
  Serial.begin(115200);
  oled.begin(SSD1306_SWITCHCAPVCC, OLED_Address);
  oled.clearDisplay();
  oled.setTextSize(2);
  pinMode(A0, INPUT); // declare ecg sensor as input

  WiFi.mode(WIFI_STA); // explicitly set mode, esp defaults to STA+AP  
  pinMode(TRIGGER_PIN, INPUT_PULLUP);

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h

  Firebase.begin(&config, &auth);

  //Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  Firebase.setDoubleDigits(5);
}
 
void loop()
{
  int temp = digitalRead(TRIGGER_PIN); // read button value
  
  if (temp == HIGH) { // if button pressed 
    WiFiManager wm;    
    wm.setConfigPortalTimeout(timeout);

    if (!wm.startConfigPortal(DEVICE_ID)) {
      Serial.println("failed to connect and hit timeout");
      delay(3000);
      //reset and try again, or maybe put it to deep sleep
      ESP.restart();
      delay(5000);
    }

    //if you get here you have connected to the WiFi
    Serial.println("connected...)");

    oled.writeFillRect(0,50,128,16,BLACK);
    oled.setCursor(0,50);
    oled.print("WIFI MODE");
    
  }else {
    // read ecg sensor value and calculate BPM
    if(a>127)
      {
        oled.clearDisplay();
        a=0;
        lasta=a;
      }
    
      ThisTime=millis();
      // read sensor value
      int value=analogRead(A0);
      oled.setTextColor(WHITE);
      int b=60-(value/16); 
      oled.writeLine(lasta,lastb,a,b,WHITE);
      lastb=b;
      lasta=a;
    
      // calculate BPM
      if(value>UpperThreshold)
      {
        if(BeatComplete)
        {
          BPM=ThisTime-LastTime;
          BPMTiming=false;
          BeatComplete=false;
          tone(8,1000,250);
        }
        if(BPMTiming==false)
        {
          LastTime=millis();
          BPMTiming=true;
        }
      }
      // check if BPM is complete
      if((value<LowerThreshold)&(BPMTiming)){
        BeatComplete=true;
      }
      
      // print value in display
      oled.writeFillRect(0,50,128,16,BLACK);
      oled.setCursor(0,50);
      oled.print("BPM:");
      oled.print(BPM);

     // send data to firebase
      if (Firebase.ready() && (a % 100==0) && (millis() - sendDataPrevMillis > 5000 || sendDataPrevMillis == 0))
      {
        // save data in firebase realtime database
        Serial.printf("Set bpm... %s\n", Firebase.setFloat(fbdo, F("/Heart_Rate_007/bpm"), BPM) ? "ok" : fbdo.errorReason().c_str());
        Serial.printf("Get bpm... %s\n", Firebase.getFloat(fbdo, F("/Heart_Rate_007/bpm")) ? String(fbdo.to<float>()).c_str() : fbdo.errorReason().c_str());

      }

      oled.display();
      a++;
      delay(50);
  }
}
