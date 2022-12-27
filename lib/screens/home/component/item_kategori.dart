import 'package:flutter/material.dart';

class ItemKategori extends StatelessWidget {
  const ItemKategori({
    Key? key,
    required this.title,
    required this.icon,
    required this.ontaps,
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback ontaps;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontaps,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 85,
            height: 80,
            child: Image.asset(
              icon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 85,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
