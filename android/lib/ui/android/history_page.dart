import 'package:air_quality/controller/history_ctl.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HistoryPage extends StatelessWidget {
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
      child: GetBuilder<HistoryCtl>(
          init: HistoryCtl(),
          builder: (snapshot) {
            return Container(
              width: Pixel.x * 90,
              height: Pixel.y * 40,
              child: snapshot.history == null || snapshot.history.length == 0
                  ? Center(
                      child: MyText(
                        text: 'Tidak ada data',
                        color: Colors.orange,
                        fontSize: Pixel.x * 7,
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.history.length,
                      itemBuilder: (context, index) {
                        return _item(
                          snapshot.history[index].status,
                          snapshot.history[index].detail,
                          snapshot.history[index].timestamp,
                        );
                      },
                    ),
            );
          }),
    );
  }

  Widget _item(String status, String detail, int timestamp) {
    return Container(
      width: Pixel.x * 90,
      height: Pixel.y * 15,
      padding: EdgeInsets.all(
        Pixel.x * 2,
      ),
      margin: EdgeInsets.all(
        Pixel.x * 2,
      ),
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(
            Pixel.x * 3,
          )),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.warning,
                size: Pixel.x * 10,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: status,
                    fontSize: Pixel.x * 5,
                  ),
                  MyText(
                    text: detail,
                    fontSize: Pixel.x * 4,
                  ),
                  MyText(
                    text: DateTime.fromMillisecondsSinceEpoch(timestamp)
                        .toString()
                        .split('.')[0],
                    fontSize: Pixel.x * 4,
                  ),
                ],
              ),
            ),
          ),
        ],
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
