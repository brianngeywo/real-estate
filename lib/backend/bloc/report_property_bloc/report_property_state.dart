part of 'report_property_bloc.dart';

@immutable
abstract class ReportPropertyState {}

class ReportPropertyInitial extends ReportPropertyState {}

class ReportRadioButtonSelectedState extends ReportPropertyState {
  final int index;
  final String title;
  ReportRadioButtonSelectedState({
    this.index = 0,
    this.title = '',
  });
}
