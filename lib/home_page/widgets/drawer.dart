import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/sabitler.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../../date/date_event/date_event.dart';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart';
import '../../home_page/bloc/home_page_event/home_page_event.dart';

enum DrawerFilter { day, week, month, year }

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F0F14),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 30),

              _sectionTitle("ZAMAN FİLTRELERİ"),
              const SizedBox(height: 14),

              _drawerButton(context, label: "Gün", icon: Icons.today, filter: DrawerFilter.day, onTap: () => _selectDate(context),),
              _drawerButton(context, label: "Hafta", icon: Icons.date_range, filter: DrawerFilter.week, onTap: () => _calculateForWeek(context),),
              _drawerButton(context, label: "Ay", icon: Icons.calendar_month, filter: DrawerFilter.month, onTap: () => _openMonthSelector(context),),
              _drawerButton(context, label: "Yıl", icon: Icons.timeline, filter: DrawerFilter.year, onTap: () => _calculateForYear(context),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Cüzdanım360", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),),
        SizedBox(height: 6),
        Text("Finansal özet & zaman analizi", style: TextStyle(fontSize: 14, color: Colors.grey,),
        ),
      ],
    );
  }


  Widget _sectionTitle(String title)
  {
    return Text(title, style: TextStyle(fontSize: 13, color: Colors.grey.shade500, fontWeight: FontWeight.w600,),);
  }

  Widget _drawerButton(BuildContext context, {
    required String label,
    required IconData icon,
    required DrawerFilter filter,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withOpacity(0.06),
          ),
          child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 15),
              Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white,),),
              const SizedBox(width: 15),
              const Icon(Icons.chevron_right, color: Colors.white, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _openMonthSelector(BuildContext context) {
    Navigator.pop(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A23),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ay Seç",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.builder(
                  itemCount: Sabitler.months.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        Sabitler.months[index],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        context.read<HomePageBloc>().add(
                          CalculateTheValuesForTheMonth(
                            monthName: Sabitler.months[index],
                          ),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateForWeek(BuildContext context) {
    context.read<HomePageBloc>().add(CalculateTheValuesFor7Days());
    Navigator.pop(context);
  }

  void _calculateForYear(BuildContext context) {
    context.read<HomePageBloc>().add(CalculateTheValuesForTheYear());
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (selectedDate == null) return;

    context.read<DateBloc>().add(DateEvent(date: selectedDate));
    Navigator.pop(context);
  }

}