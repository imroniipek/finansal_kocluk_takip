import 'package:finansal_kocluk_takip/core/sabitler.dart';
import 'package:finansal_kocluk_takip/income_expense_page/view/income_expanse_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finansal_kocluk_takip/analysis/view/analysis_view.dart';
import 'package:finansal_kocluk_takip/staticts/view/staticts_view.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  bool _isFabOpen = false;

  final List<Widget> _pages = const [
    AnalysisView(),
    StatictsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildExpandableFab(context),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
  Widget _buildExpandableFab(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isFabOpen ? Column(
            children: [
              _miniActionButton(icon: Icons.add, label: "Gelir", color: Colors.green, onTap: () {setState(() => _isFabOpen = false);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>
                    IncomeExpansePage(isitIncomepage: true,)
                ));
              },),
              const SizedBox(height: 10),
              _miniActionButton(icon: Icons.remove, label: "Gider", color: Colors.red.shade900, onTap: () {setState(() => _isFabOpen = false);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>IncomeExpansePage(isitIncomepage: false)));
                },),
              const SizedBox(height: 10),
            ],
          ) : const SizedBox()
        ),

        FloatingActionButton(
          backgroundColor: const Color(0xFF00C853),
          elevation: 8,
          onPressed: () {
            setState(() => _isFabOpen = !_isFabOpen);
          },
          child: AnimatedRotation(
            turns: _isFabOpen ? 0.125 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: const Icon(Icons.add, size: 32,color:Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _miniActionButton({required IconData icon, required String label, required Color color, required VoidCallback onTap,})
  {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600,),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5),),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _isFabOpen = false;
            });
          },
          selectedItemColor: const Color(0xFF00C853),
          unselectedItemColor: Colors.grey.shade600,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics, size: 30),
              label: 'Analiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart_rounded, size: 30),
              label: 'İstatistik',
            ),
          ],
        ),
      ),
    );
  }
}
