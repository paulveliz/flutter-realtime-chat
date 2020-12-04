import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String subText;
  final String titleText;

  const Labels({
    Key key, 
    @required this.ruta,
    @required this.subText,
    @required this.titleText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(subText, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(
              titleText, 
              style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)
            ),
            onTap: () => Navigator.pushReplacementNamed(context, ruta),
          ),
        ],
      ),
    );
  }
}