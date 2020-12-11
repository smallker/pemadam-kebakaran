#include <Arduino.h>
#include <NTPClient.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <WiFiClientSecure.h>
#include "certificate.h"
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
