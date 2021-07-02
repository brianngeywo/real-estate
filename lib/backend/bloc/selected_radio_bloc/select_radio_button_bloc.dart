import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_radio_button_event.dart';
part 'select_radio_button_state.dart';

class SelectRadioButtonBloc extends Bloc<SelectRadioButtonEvent, SelectRadioButtonState> {
  SelectRadioButtonBloc() : super(SelectRadioButtonInitial());

  @override
  Stream<SelectRadioButtonState> mapEventToState(
    SelectRadioButtonEvent event,
  ) async* {
       if (event is SelectRadioButtonBlocEvent) {
      yield RadioButtonSelectedBlocState(index: event.index, title: event.title);
    }
  }
}
