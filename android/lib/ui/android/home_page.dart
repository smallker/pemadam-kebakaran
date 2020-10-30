import 'package:air_quality/controller/page_ctl.dart';
import 'package:air_quality/services/init.dart';
import 'package:air_quality/ui/android/history_page.dart';
import 'package:air_quality/ui/android/notification_page.dart';
import 'package:air_quality/ui/android/status_page.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar _appBar(String title) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      title: MyText(
        text: title,
        fontSize: Pixel.x * 4.5,
      ),
    );
  }

  Widget _navigationDrawer() {
    return GetBuilder<PageCtl>(
      init: PageCtl(),
      builder: (snapshot) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        size: Pixel.x * 7,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: Pixel.x * 5,
                        ),
                        child: MyText(
                          text: 'Menu',
                          fontSize: Pixel.x * 7,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                ),
                title: MyText(
                  text: 'Status',
                  color: Colors.grey,
                  fontSize: Pixel.x * 5,
                ),
                onTap: () => snapshot.updatePage(0),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: MyText(
                  text: 'Notifikasi',
                  color: Colors.grey,
                  fontSize: Pixel.x * 5,
                ),
                onTap: () => snapshot.updatePage(1),
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: MyText(
                  text: 'Histori',
                  color: Colors.grey,
                  fontSize: Pixel.x * 5,
                ),
                onTap: () => snapshot.updatePage(2),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> body = [
    StatusPage(),
    NotificationPage(),
    HistoryPage(),
  ];
  List<String> title = [
    'Status sensor',
    'Notifikasi',
    'Histori',
  ];
  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return GetBuilder<PageCtl>(
      init: PageCtl(),
      initState: Init.init(),
      builder: (snapshot) {
        return Container(
          color: Colors.orange,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: _appBar(
                title[snapshot.page],
              ),
              drawer: _navigationDrawer(),
              body: Center(child: body[snapshot.page]),
            ),
          ),
        );
      },
    );
  }
}
