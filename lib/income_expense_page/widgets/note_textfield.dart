import 'package:flutter/material.dart';

class NoteTextfield extends StatefulWidget {

  final void Function(String note) onTap;

  final Color textfieldColor;


  const NoteTextfield({super.key,required this.onTap,required this.textfieldColor});

  @override
  State<NoteTextfield> createState() => _NoteTextfieldState();
}

class _NoteTextfieldState extends State<NoteTextfield> {

  double fontSize = 20;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(fontSize: fontSize, color: Colors.black),
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 25,),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.textfieldColor, width: 3)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.textfieldColor, width: 3)
            ),
            hintText: "Not Ekle",
            prefixIcon: Icon(
                Icons.note_alt, color: widget.textfieldColor, size: 70),
          ),

          onSubmitted: (value) {
            print(value.toString());
            widget.onTap(value);
          },
          onChanged: (value) {
            setState(() {
              fontSize = 25;
            });
          },
        ),
      );
  }
}