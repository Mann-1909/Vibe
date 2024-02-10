import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final Function()? onPressed;

  const TextBox({super.key, required this.text, required this.sectionName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey[500])),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 25,
                  ),
              ),
            ],
          ),

          //text
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
