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
import '../../home_page/widgets/current_balance.dart';
import '../../home_page/widgets/drawer.dart';
import '../../staticts/widget/expenses_donut_chart.dart';
import '../../home_page/widgets/income_expenses_listtile.dart';
import '../../income_expense_page/view/income_expanse_page.dart';
import '../widgets/expenses_and_income_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DateBloc>().add(DateEvent(date: DateTime.now()));
    super.initState();
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        backgroundColor: Colors.transparent,
        title: Text("Cüzdanım360", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(context),
              const SizedBox(height: 20),
              _buildMainChartSection(),
              const SizedBox(height: 25),
              _buildActionRow(),
              const SizedBox(height: 10),
              _buildTransactionList(),
              const SizedBox(height: 30),
              _buildBottomButtons(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15),),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030), initialDate: DateTime.now(),);
              if (selectedDate != null && mounted) {
                context.read<DateBloc>().add(DateEvent(date: selectedDate));
              }
            },
            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white70),
          ),
          BlocBuilder<DateBloc, DateState>(
            builder: (context, dateState) {
              return BlocBuilder<HomePageBloc, HomePageState>(
                buildWhen: (prev, curr) => prev.displayDate != curr.displayDate,
                builder: (context, homeState) {
                  return Text(
                    homeState.displayDate ?? dateState.date,
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainChartSection() {
    if (isOpen) return const SizedBox.shrink();

    return
      BlocBuilder<HomePageBloc,HomePageState>(
          buildWhen:(previous,current)
          {
            return (previous.expenses!=current.expenses);
          },
          builder:(context,state)
          {
            final expensesList = _getExpensesButtons(context, state);
            return SizedBox(
              height:500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: expensesList.sublist(0, 4),
                  ),
                  const SizedBox(width:30),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        expensesList[4],
                        ExpensesDonutChart(expenses: state.expenses,incomes:state.incomes),
                        expensesList[5],
                      ],

                    ),
                  ),
                  const SizedBox(width:10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: expensesList.sublist(6, 10),
                  ),

                ],
              ),
            );
          }
      );
  }

  Widget _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _expandButton(),
        const Expanded(child: Center(child: CurrentBalance())),
        _expandButton(),
      ],
    );
  }
  Widget _expandButton() {
    return GestureDetector(
      onTap: () => setState(() => isOpen = !isOpen),
      child: AnimatedRotation(
        duration: const Duration(milliseconds: 200),
        turns: isOpen ? 0.50 : 0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: const Icon(Icons.keyboard_arrow_down, size: 25, color: Colors.white),
        ),
      ),
    );
  }
  Widget _buildTransactionList() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IncomeExpensesListtile(
              model: HomePageHelper.theMapSelectedByCategory(state.incomes, state.expenses),
            ),
          ),
          crossFadeState: isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ExpensesandIncomeButtons(
          icon: Icon(Icons.add_rounded, size: 32, color: Sabitler.incomeColor),
          color: Sabitler.incomeColor,
          isitIncome: true,
        ),
        const SizedBox(width: 40),
        ExpensesandIncomeButtons(
          icon: Icon(Icons.remove_rounded, size: 32, color: Sabitler.expensesColor),
          color: Sabitler.expensesColor,
          isitIncome: false,
        ),
      ],
    );
  }
  List<Widget> _getExpensesButtons(BuildContext context, HomePageState state) {
    return Sabitler.expensesSelections.entries.toList().asMap().entries.map((indexedEntry) {
      final i = indexedEntry.key;
      final entry = indexedEntry.value;
      final percent = HomePageHelper.calculatethePercentbyExpenses(state.expenses, entry.value);
      final color = Sabitler.colorsForExpensesButtons[i];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => IncomeExpansePage(isitIncomepage: false, buttonName: entry.value, primaryColor: color,),),),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(14),),
                child: Icon(entry.key, size: 35,color: color,),
              ),
            ),

            const SizedBox(height: 6),

            if (percent > 0)
              Text("%${percent.toStringAsFixed(1)}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: color,),),

            const SizedBox(height: 2),

            Text(entry.value, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center,),
          ],
        ),
      );
    }).toList();
  }
}