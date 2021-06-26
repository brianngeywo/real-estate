import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'report_property_event.dart';
part 'report_property_state.dart';

class ReportPropertyBloc extends Bloc<ReportPropertyEvent, ReportPropertyState> {
  ReportPropertyBloc() : super(ReportPropertyInitial());

  @override
  Stream<ReportPropertyState> mapEventToState(
    ReportPropertyEvent event,
  ) async* {
    if (event is SelectRadioButtonEvent) {
      yield ReportRadioButtonSelectedState(index: event.index, title: event.title);
    }
  }
}
