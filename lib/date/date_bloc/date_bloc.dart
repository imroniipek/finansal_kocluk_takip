import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/sabitler.dart';
import '../date_event/date_event.dart';
import '../date_status/date_status.dart';

class DateBloc extends Bloc<EventsForDate, DateState> {
  DateBloc() : super(DateState(
      date: Sabitler.converttoDate(DateTime.now()),
      dbdate: DateFormat("dd.MM.yyyy").format(DateTime.now()),
    ),)
  {
    on<DateEvent>((event, emit) {
      emit(DateState(
        date: Sabitler.converttoDate(event.date),
        dbdate: DateFormat("dd.MM.yyyy").format(event.date),
      ));
    });

    on<DateEventForDb>(
        (event,emit)
        {
          emit(DateState(date: state.date, dbdate: event.dateeventfordb));
        }
    );
  }
}