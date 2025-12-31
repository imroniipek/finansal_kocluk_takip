import 'package:finansal_kocluk_takip/analysis/widget/total_amount_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/helpers/home_page_helpers/home_page_helper.dart';
import '../../date/date_bloc/date_bloc.dart';
import '../../date/date_event/date_event.dart';
import '../../date/date_status/date_status.dart';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart';
import '../../home_page/bloc/home_page_status/home_page_status.dart';
import '../../home_page/widgets/drawer.dart';
import '../widget/expanses_and_incomes_listtile.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
          body:
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       _dateHeader(context),
                      const SizedBox(height: 15,),
                    BlocBuilder<HomePageBloc, HomePageState>(
                      buildWhen: (p, c) => p.expenses != c.expenses||p.incomes!=c.incomes,
                      builder: (context, state) {
                        return TotalAmountCard(
                            incomes: state.incomes, expenses: state.expenses);
                      }
                     ),
                  const SizedBox(height: 15,),

                  BlocBuilder<HomePageBloc, HomePageState>(
                   builder: (context, state) {
                    return
                     ExpansesAndIncomeListTile(model:HomePageHelper.theMapSelectedByCategory(state.incomes, state.expenses));
                 },)
                ])
              ),
          ),
      );

  }
  Widget _dateHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(18),),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white70),
            onPressed: () async {
              final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime(2030), initialDate: DateTime.now(),);
              if (selectedDate != null)
              {
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
}