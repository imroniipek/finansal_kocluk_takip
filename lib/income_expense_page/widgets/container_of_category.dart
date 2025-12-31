import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerOfCategory extends StatelessWidget {
  final IconData icondata;
  final String value;
  final Color primaryColor;
  final bool isitIncomepage;
  final int? modelId;

  const ContainerOfCategory({
    super.key,
    required this.icondata,
    required this.value,
    required this.primaryColor,
    required this.isitIncomepage,
    this.modelId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(.2),
              child: Icon(icondata, color: primaryColor),
            ),
            const SizedBox(height: 10),
            Text(value, style: GoogleFonts.poppins(fontSize: 14, color: Colors.white,),),
          ],
        ),
      ),
    );
  }
}
