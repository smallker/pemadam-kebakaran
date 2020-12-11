#include "firebase.h"
#define WIFI_SSID "bolt"
#define WIFI_PASSWORD "11111111"

void setup()
{
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("\nSTART");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nConnected, IP : " + WiFi.localIP().toString());
}

void loop()
{
  timeClient.update();
  StaticJsonDocument<200> realtime;
  StaticJsonDocument<200> history;
  char realtimeBuffer[200];
  char historyBuffer[200];

  /*
    Data dummy
  */
  int suhu = 30 + (rand() % 10);
  int gas = 95 + (rand() % 10);
  /*
    ganti false dengan digitalRead(nomor pin),
    setting juga pinMode di setup
  */
  bool fire = false;
  String status = "Aman";
  String detail = "Tidak terjadi kebakaran";

  if (gas > 100)
  {
    status = "Waspada";
    detail = "Gas melebihi 100 ppm";
    sendMessage(status, detail);
    delay(5000);
  }
  if (suhu > 35)
  {
    status = "Bahaya";
    detail = "Ada api dan suhu meningkat";
    sendMessage(status, detail);
    delay(5000);
  }

  /*
    Data realtime
    - Jika gas > 100 maka sensor hidup
    - Jika sensor api == HIGH maka sensor hidup
  */
  realtime["temperature"] = suhu;
  realtime["smoke"] = gas > 100 ? "Hidup" : "Mati";
  realtime["fire"] = fire ? "Hidup" : "Mati";
  realtime["status"] = status;

  /*
    Data histori
  */
  history["status"] = status;
  history["detail"] = detail;
  history["timestamp"] = (String)timeClient.getEpochTime();

  serializeJson(realtime, realtimeBuffer);
  serializeJson(history, historyBuffer);
  sendRealtimeData(realtimeBuffer);
  sendHistoryData(historyBuffer);
  delay(5000);
}