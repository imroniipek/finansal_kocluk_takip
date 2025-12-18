import 'package:flutter/material.dart';

class NoteTextfield extends StatefulWidget {

  final void Function(String note) onTap;
  final Color textfieldColor;
  final String? initalText;
  const NoteTextfield({super.key,required this.onTap,required this.textfieldColor,required this.initalText});

  @override
  State<NoteTextfield> createState() => _NoteTextfieldState();
}

class _NoteTextfieldState extends State<NoteTextfield> {

  late TextEditingController _controller;
  double fontSize = 20;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initalText?.trim().isEmpty == true ? null : widget.initalText,);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller:_controller,
          style: TextStyle(fontSize: fontSize, color: Colors.black),
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 25,),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.textfieldColor, width: 3)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.textfieldColor, width: 3)),
            hintText: "Not Ekle",
            prefixIcon: Icon(Icons.note_alt, color: widget.textfieldColor, size: 70),),
          onChanged: (value) {
            setState(() {
              widget.onTap(value);
              fontSize = 25;
            });
          },
        ),
      );
  }
}