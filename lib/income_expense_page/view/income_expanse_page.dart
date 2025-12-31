import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/sabitler.dart';
import '../../home_page/bloc/home_page_bloc/home_page_bloc.dart';
import '../../home_page/bloc/home_page_event/home_page_event.dart';
import '../bloc/income_expense_page_bloc/amount_calculator_bloc.dart';
import '../bloc/income_expense_page_bloc/db_bloc.dart';
import '../bloc/income_expense_page_bloc/income_expense_page_bloc.dart';
import '../bloc/income_expense_page_events/amount_calculator_event.dart';
import '../bloc/income_expense_page_events/db_events.dart';
import '../bloc/income_expense_page_events/events.dart';
import '../bloc/income_expense_page_states/amount_calculator_status.dart';
import '../bloc/income_expense_page_states/db_status.dart';
import '../widgets/amount_display.dart';
import '../widgets/calculator_pad.dart';
import '../widgets/categorySelectorButton.dart';
import '../widgets/container_of_category.dart';
import '../widgets/date_selector.dart';
import '../widgets/note_textfield.dart';

class IncomeExpansePage extends StatefulWidget {
  final bool isitIncomepage;
  final Color primaryColor;
  final String? buttonName;
  final int? modelId;
  final String? textValue;

  IncomeExpansePage({
    super.key,
    required this.isitIncomepage,
    this.textValue,
    this.buttonName,
    Color? primaryColor,
    this.modelId,
  }) : primaryColor =
      primaryColor ??
          (isitIncomepage ? Sabitler.incomeColor : Sabitler.expensesColor);

  @override
  State<IncomeExpansePage> createState() => _IncomeExpansePageState();
}

class _IncomeExpansePageState extends State<IncomeExpansePage> {
  @override
  void initState() {
    super.initState();
    context.read<IncomeExpenseBloc>().add(ChangeType(widget.isitIncomepage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: BlocConsumer<DbBloc, DbStatus>(
        listener: _handleDbStateListener,
        builder: (context, state) {
          if (state.status == PageStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return _buildBody();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final isEdit = widget.modelId != null;
    final title =
    isEdit ? "Düzenle" : widget.isitIncomepage ? "Yeni Gelir" : "Yeni Gider";

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          context.read<AmountCalculatorBloc>().add(ResetTheCalculator());
          Navigator.pop(context);
        },
      ),
      actions: [
        if (isEdit)
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => context.read<DbBloc>().add(
              DeleteTheModelFromDb(
                isitIncome: widget.isitIncomepage,
                modelId: widget.modelId!,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const DateSelector(),
          const SizedBox(height: 20),
          AmountDisplay(primaryColor: widget.primaryColor),
          const SizedBox(height: 20),
          NoteTextfield(
            onTap: (v) =>
                context.read<AmountCalculatorBloc>().add(AddNote(v)),
            textfieldColor: widget.primaryColor,
            initalText: widget.textValue,
          ),
          const SizedBox(height: 30),
          _buildSelectionArea(),
          const SizedBox(height: 20),
          CategorySelectorButton(
            state: context.watch<AmountCalculatorBloc>().state,
            primaryColor: widget.primaryColor,
            buttonName: widget.buttonName,
            isitIncome: widget.isitIncomepage,
            modelId: widget.modelId,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSelectionArea() {
    return BlocBuilder<AmountCalculatorBloc, AmountCalculatorStatus>(
      buildWhen: (p, c) => p.isButtonSection != c.isButtonSection,
      builder: (context, state) {
        return state.isButtonSection
            ? CalculatorPad(primaryColor: widget.primaryColor)
            : _buildCategoryGrid();
      },
    );
  }

  Widget _buildCategoryGrid() {
    final selections = widget.isitIncomepage
        ? Sabitler.incomeSelections
        : Sabitler.expensesSelections;

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
      ),
      itemCount: selections.length,
      itemBuilder: (context, index) {
        final entry = selections.entries.elementAt(index);
        return ContainerOfCategory(
          icondata: entry.key,
          value: entry.value,
          primaryColor: widget.primaryColor,
          isitIncomepage: widget.isitIncomepage,
          modelId: widget.modelId,
        );
      },
    );
  }

  void _handleDbStateListener(BuildContext context, DbStatus state) {
    if (state.status == PageStatus.success) {
      context.read<HomePageBloc>().add(GetExpensesList());
      context.read<HomePageBloc>().add(GetIncomeList());
      context.read<HomePageBloc>().add(CalculateCurrentBalance());
      context.read<AmountCalculatorBloc>().add(ResetTheCalculator());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("İşlem başarılı")),
      );
      Navigator.pop(context);
    }
  }
}
