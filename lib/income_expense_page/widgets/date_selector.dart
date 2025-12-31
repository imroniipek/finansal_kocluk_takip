import 'package:finansal_kocluk_takip/date/date_bloc/date_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../date/date_event/date_event.dart';
import '../../date/date_status/date_status.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.calendar_month, color: Colors.white),
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              initialDate: DateTime.now(),
            );
            if (date != null) {
              context.read<DateBloc>().add(DateEvent(date: date));
            }
          },
        ),
        BlocBuilder<DateBloc, DateState>(
          builder: (context, state) {
            return Text(state.date, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white,),
            );
          },
        ),
      ],
    );
  }
}
