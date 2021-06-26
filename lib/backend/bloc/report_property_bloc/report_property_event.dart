part of 'report_property_bloc.dart';

@immutable
abstract class ReportPropertyEvent {}

class SelectRadioButtonEvent extends ReportPropertyEvent {
  final int index;
  final String title;
  SelectRadioButtonEvent({
    this.index = 0,
    this.title = '',
  });
}
