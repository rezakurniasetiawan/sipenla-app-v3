// ignore_for_file: avoid_unnecessary_containers, unnecessary_const

import 'package:flutter/material.dart';

class ItemBiodata extends StatelessWidget {
  const ItemBiodata({Key? key, required this.text1, required this.text2})
      : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            text1,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xff4B556B),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Text(
              ": $text2",
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: const Color(0xff4B556B),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }
}
