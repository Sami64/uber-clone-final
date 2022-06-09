import 'package:flutter/material.dart';

import '../brand_colors.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  const TaxiButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
            height: 50,
            child: Center(
                child: Text(title,
                    style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold')))),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            textStyle:
                MaterialStateProperty.all(TextStyle(color: Colors.white)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)))));
  }
}
