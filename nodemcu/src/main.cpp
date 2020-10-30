#include <Arduino.h>
#include <NTPClient.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include "FirebaseESP8266.h"
#define WIFI_SSID               "yai"
#define WIFI_PASSWORD           "11111111"
#define FIREBASE_HOST           "pemadam-kebakaran-b1d1f.firebaseio.com"
#define FIREBASE_AUTH           "15KNXoZNcL8FUaeebJmlt4TTovZmepeyCHNJLjoZ"
#define FIREBASE_FCM_SERVER_KEY "AAAAQpp2zDQ:APA91bEM11gwpXJNursnmxVVBj2aaL_JJzj2SrgPqyD4yB6JgRsxqswilDIZNz4keB12_xMzfYSYBoMcBHVCZURDsho_jKVy4PNftewcwp9PZt1-xxf_B0dh5W322enrWdEJKCfcfOxW"
FirebaseData firebaseData;
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 0);
void sendMessage(String title, String body)
{
  Serial.println("------------------------------------");
  Serial.println(title + " : " + body);
  Serial.println("------------------------------------");
  firebaseData.fcm.setNotifyMessage(title, body);
  if (Firebase.sendTopic(firebaseData))
  {
    Serial.println(firebaseData.fcm.getSendResult());
  }
  else
  {
    Serial.println(firebaseData.errorReason());
  }
}

void setup()
{
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseData.setBSSLBufferSize(1024, 1024);
  firebaseData.setResponseSize(1024);
  firebaseData.fcm.begin(FIREBASE_FCM_SERVER_KEY);
  firebaseData.fcm.setPriority("high");
  firebaseData.fcm.setTimeToLive(1000);
  firebaseData.fcm.setTopic("notification");
}
void loop()
{
  timeClient.update();
  /*
    Data dummy
  */
  int suhu = 30 + (rand() % 10);
  int gas = 95 + (rand() % 10);
  String status = "Aman";
  String detail = "Tidak terjadi kebakaran";
  FirebaseJson realtime;
  FirebaseJson history;
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
  realtime.add("temperature", suhu);
  realtime.add("smoke", gas > 100 ? "Hidup" : "Mati");
  realtime.add("status", status);

  history.add("status", status);
  history.add("detail", detail);
  history.add("timestamp", (String)timeClient.getEpochTime());
  // history.add("timestamp",)
  Firebase.setJSON(firebaseData, "/realtime", realtime);
  Firebase.pushJSON(firebaseData, "/history",history);
  delay(5000);
}
