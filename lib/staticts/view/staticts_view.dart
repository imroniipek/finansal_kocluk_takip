import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../core/helpers/home_page_helpers/home_page_helper.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../../date/date_event/date_event.dart';
import '../../date/date_status/date_status.dart';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart';
import '../../home_page/bloc/home_page_status/home_page_status.dart';
import '../../home_page/widgets/drawer.dart';
import '../widget/expenses_donut_chart.dart';
import '../../income_expense_page/view/income_expanse_page.dart';
import '../widget/expenseListItem.dart';

class StatictsView extends StatefulWidget {
  const StatictsView({super.key});

  @override
  State<StatictsView> createState() => _HomePageState();
}

class _HomePageState extends State<StatictsView> {

  @override
  void initState() {
    context.read<DateBloc>().add(DateEvent(date: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Cüzdanım360", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dateHeader(),
              const SizedBox(height: 24),
              _dashboard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(18),),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white70),
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(2024),
                lastDate: DateTime(2030),
                initialDate: DateTime.now(),
              );
              if (selectedDate != null && mounted) {
                context.read<DateBloc>().add(DateEvent(date: selectedDate));
              }
            },
          ),
          BlocBuilder<DateBloc, DateState>(
            builder: (context, dateState) {
              return BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (p, c) => p.displayDate != c.displayDate,
                builder: (context, homeState) {
                  return Text(
                    homeState.displayDate ?? dateState.date,
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500,),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _dashboard() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (p, c) => p.expenses != c.expenses,
      builder: (context, state) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpensesDonutChart(
              expenses: state.expenses,
              incomes: state.incomes,
            ),

            const SizedBox(height: 28),

            Text("Harcama Dağılımı", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white,),),

            const SizedBox(height: 12),


            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Sabitler.expensesSelections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final entry = Sabitler.expensesSelections.entries.elementAt(index);

                final color = Sabitler.colorsForExpensesButtons[index];

                final percent = HomePageHelper.calculatethePercentbyExpenses(state.expenses, entry.value,);

                if (percent < 0) return const SizedBox.shrink();

                return ExpenseListItem(
                  icon: entry.key,
                  title: entry.value,
                  percent: percent,
                  color: color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IncomeExpansePage(
                          isitIncomepage: false,
                          buttonName: entry.value,
                          primaryColor: color,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}




