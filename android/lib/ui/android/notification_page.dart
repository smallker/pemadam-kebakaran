import 'package:air_quality/controller/history_ctl.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Widget _header() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(
          Pixel.x * 2,
        ),
        padding: EdgeInsets.all(Pixel.x * 10),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Image.asset('assets/icon.png'),
            ),
            Flexible(
              flex: 1,
              child: MyText(
                text: 'Pemadam Kebakaran',
                color: Colors.orange,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      flex: 4,
      child: Container(
        width: Pixel.x * 85,
        height: Pixel.y * 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Pixel.x * 3,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                child: GetBuilder<HistoryCtl>(
                  init: HistoryCtl(),
                  builder: (snapshot) {
                    print(snapshot.history.length);
                    if (snapshot.history == null ||
                        snapshot.history.length == 0) {
                      return Container(
                        child: Center(
                          child: MyText(
                            text: 'Kosong',
                            fontSize: Pixel.x * 7,
                            color: Colors.orange,
                          ),
                        ),
                      );
                    } else
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(
                            Pixel.x * 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: Pixel.x * 15,
                                color: Colors.white,
                              ),
                              MyText(
                                text: snapshot.history == null
                                    ? 'N/A'
                                    : snapshot.history.last.status,
                                fontSize: Pixel.x * 7,
                              ),
                              MyText(
                                text: snapshot.history == null
                                    ? 'N/A'
                                    : snapshot.history.last.detail,
                                fontSize: Pixel.x * 5,
                              ),
                              MyText(
                                text: snapshot.history == null
                                    ? 'N/A'
                                    : DateTime.fromMillisecondsSinceEpoch(
                                            snapshot.history.last.timestamp)
                                        .toString()
                                        .split('.')[0],
                                fontSize: Pixel.x * 5,
                              ),
                            ],
                          ),
                        ),
                      );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Column(
      children: [
        _header(),
        _body(),
      ],
    );
  }
}
