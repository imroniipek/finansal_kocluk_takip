import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ExpenseListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double percent;
  final Color color;
  final VoidCallback onTap;

  const ExpenseListItem({super.key, required this.icon, required this.title, required this.percent, required this.color, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14),),
              child: Icon(icon, color: color, size: 28),
            ),

            const SizedBox(width: 12),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white,),),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percent / 100,
                      minHeight: 6,
                      backgroundColor: Colors.white.withOpacity(0.08),
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text("%${percent.toStringAsFixed(0)}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: color,),),
          ],
        ),
      ),
    );
  }
}