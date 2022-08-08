import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../uiScreen/themas.dart';

class phoneScreenW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var widgetList = {
      'SERENAZGO': '942886685',
      'BOBMEROS': '116',
      'S.A.M.U': '106',
      'DEFENSA CIVIL': '115',
      'POLICÍA': '105',
      'POLICÍA TURISMO': '066315892',
      'POLICÍA CARRETERAS': '110'
    };
    return GridView(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List<Widget>.generate(
        widgetList.length,
        (int index) {
          var entryList = widgetList.entries.toList();
          return ElevatedButton(
            onPressed: () {
              launch('tel://${widgetList[entryList[index].key]}');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.27,
                color: Color(0xff14DAE2),
              ),
              primary: Colors.grey[600],
            ),
            child: Text(
              '${entryList[index].key}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.27,
                color: Color(0xff14DAE2),
              ),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 50.0,
        childAspectRatio: 2,
      ),
    );
  }
}
