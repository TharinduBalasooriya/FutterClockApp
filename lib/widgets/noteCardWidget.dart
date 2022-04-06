import 'package:flutter/material.dart';

class NoteCardWidget extends StatefulWidget {
  const NoteCardWidget({Key? key}) : super(key: key);
  // final String title;
  // final String description;

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              "description - Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent mattis, ligula ac vehicula pulvinar, lorem nunc bibendum est, ut faucibus ex nisi id tellus. Vestibulum porta orci a aliquet cursus.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
