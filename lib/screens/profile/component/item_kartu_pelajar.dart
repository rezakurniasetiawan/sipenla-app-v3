// ignore_for_file: sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ItemKartuPelajar extends StatelessWidget {
  const ItemKartuPelajar({Key? key, required this.text1, required this.text2})
      : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            '$text1',
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Expanded(
          child: Text(
            ': $text2',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        )
      ],
    );
  }
}
