import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteTextfield extends StatefulWidget {
  final void Function(String note) onTap;
  final Color textfieldColor;
  final String? initalText;

  const NoteTextfield({
    super.key,
    required this.onTap,
    required this.textfieldColor,
    required this.initalText,
  });

  @override
  State<NoteTextfield> createState() => _NoteTextfieldState();
}

class _NoteTextfieldState extends State<NoteTextfield> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initalText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _controller,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          hintText: "Not ekle",
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.edit_note, color: widget.textfieldColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: widget.onTap,
      ),
    );
  }
}
