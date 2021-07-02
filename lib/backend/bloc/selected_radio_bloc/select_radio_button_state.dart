part of 'select_radio_button_bloc.dart';

@immutable
abstract class SelectRadioButtonState {}

class SelectRadioButtonInitial extends SelectRadioButtonState {}
class RadioButtonSelectedBlocState extends SelectRadioButtonState {
  final int index;
  final String title;
  RadioButtonSelectedBlocState({
    this.index = 0,
    this.title = '',
  });
}
