import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.32,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(29, 194, 95, 1),
            minimumSize: Size.fromHeight(50),
          ),
          child: buildContent(),
          onPressed: onClicked,
        ),
      );

  Widget buildContent() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      );
}
