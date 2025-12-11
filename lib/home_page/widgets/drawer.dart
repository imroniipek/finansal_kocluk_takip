import 'package:finansal_kocluk_takip/home_page/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:finansal_kocluk_takip/home_page/bloc/home_page_event/home_page_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Cüzdanım360", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700,),),

              const SizedBox(height: 20),
              Divider(color: Colors.grey, thickness: 2),
              const SizedBox(height: 20),

              buildDrawerButton("Gün", Icons.calendar_today, () {}),
              buildDrawerButton("Hafta", Icons.date_range, ()=>CalculateForWeeks(context)),
              buildDrawerButton("Ay", Icons.calendar_month, () {}),
              buildDrawerButton("Yıl", Icons.timeline, () {}),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildDrawerButton(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(icon, color: Colors.deepPurple.shade400),
                const SizedBox(width: 12),
                Text(label, style: TextStyle(fontSize: 18, color: Colors.deepPurple.shade700, fontWeight: FontWeight.w500,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CalculateForWeeks(BuildContext context)=> context.read<HomePageBloc>().add(CalculateTheValuesFor7Days());


}
