import 'package:air_quality/controller/status_ctl.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class StatusPage extends StatelessWidget {
  Widget _header() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Image.asset(
          'assets/nav_drawer.png',
        ),
      ),
    );
  }

  Widget _sensorStatus({
    String title,
    String subtitle,
    IconData icon,
  }) {
    return Container(
      width: Pixel.x * 70,
      height: Pixel.y * 15,
      margin: EdgeInsets.all(
        Pixel.x * 2,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(
          Pixel.x * 5,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 3,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(
                Pixel.x * 3,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: Pixel.x * 15,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(
                left: Pixel.x * 5,
                top: Pixel.y * 1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: MyText(
                      text: title,
                      fontSize: Pixel.x * 6,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: MyText(
                      text: subtitle,
                      fontSize: Pixel.x * 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      flex: 4,
      child: Container(
        width: Pixel.x * 85,
        height: Pixel.y * 40,
        child: GetBuilder<StatusCtl>(
            init: StatusCtl(),
            builder: (snapshot) {
              return ListView(
                children: [
                  _sensorStatus(
                    icon: Icons.thermostat_rounded,
                    title: 'Suhu',
                    subtitle: snapshot.status == null
                        ? '00 C'
                        : '${snapshot.status.temperature}° C',
                  ),
                  _sensorStatus(
                    icon: Icons.cloud,
                    title: 'Sensor Asap',
                    subtitle: snapshot.status == null
                        ? 'Mati'
                        : snapshot.status.smoke,
                  ),
                  _sensorStatus(
                    icon: Icons.info_outline,
                    title: 'Status',
                    subtitle: snapshot.status == null
                        ? 'N/A'
                        : snapshot.status.status,
                  ),
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _body(),
      ],
    );
  }
}
