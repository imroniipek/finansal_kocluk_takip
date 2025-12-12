abstract class EventsForDate{}

class DateEvent extends EventsForDate
{
  final DateTime date;
  DateEvent({required this.date});
}
class DateEventForDb extends EventsForDate
{
  //Bu eventi kurmamdaki amac
  //kulanıcının gunluk haftalık aylık veya yıllık kazanclarının database'in ay kısmına  su sekilde yazmak ay ise kasım,haftalık olarak ise 10.07.2025-17.07.2025 gibi buna gore sorgularımı yapacaö

  final String dateeventfordb;
  DateEventForDb({required this.dateeventfordb});

}