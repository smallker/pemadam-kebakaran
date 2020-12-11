#include <Arduino.h>
#include <NTPClient.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <WiFiClientSecure.h>
#include "certificate.h"
#define WIFI_SSID "bolt"
#define WIFI_PASSWORD "11111111"

static const String REALTIME_HOST = "https://pemadam-kebakaran-b1d1f.firebaseio.com/realtime.json";
static const String HISTORY_HOST = "https://pemadam-kebakaran-b1d1f.firebaseio.com/history.json";
static const String FCM_HOST = "https://fcm.googleapis.com/fcm/send";
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", 0);

void sendMessage(String title, String body)
{
  char data[100];
  StaticJsonDocument<100> message;
  StaticJsonDocument<100> notification;

  notification["title"] = title;
  notification["body"] = body;
  message["to"] = "/topics/notification";
  message["notification"] = notification;
  serializeJson(message, data);
  Serial.println(data);
  HTTPClient http;
  WiFiClientSecure client;
  const char *server = "fcm.googleapis.com";
  client.connect(server, 443);
  client.setCertificate(fcm_ca);
  if (client.connected() > 0)
  {
    http.begin(client, FCM_HOST);
    http.addHeader("Authorization", fcm_key);
    http.addHeader("Content-Type", "application/json");
    int httpcode = http.POST(data);
    if (httpcode == HTTP_CODE_OK)
    {
      Serial.println("pesan terkirim : " + http.getString());
    }
    else
    {
      Serial.println("gagal, httpcode : " + (String)httpcode + " data : " + http.getString());
    }
    client.stop();
  }
}

void sendRealtimeData(String data)
{
  HTTPClient http;
  http.begin(REALTIME_HOST, root_ca);
  http.addHeader("content-type", "application/json");
  int httpcode = http.PATCH(data);
  if (httpcode == HTTP_CODE_OK)
  {
    Serial.println("Berhasil terkirim\n" + data);
  }
  http.end();
}
void sendHistoryData(String data)
{
  HTTPClient http;
  http.begin(HISTORY_HOST, root_ca);
  http.addHeader("content-type", "application/json");
  int httpcode = http.POST(data);
  if (httpcode == HTTP_CODE_OK)
  {
    Serial.println("Berhasil terkirim\n" + data);
  }
  http.end();
}
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