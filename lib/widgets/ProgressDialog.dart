import 'package:flutter/material.dart';
import 'package:uber_clone/brand_colors.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.transparent,
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                const SizedBox(width: 5),
                const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(BrandColors.colorAccent)),
                const SizedBox(width: 25),
                Text(status, style: const TextStyle(fontSize: 15))
              ]),
            )));
  }
}
