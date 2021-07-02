part of 'select_radio_button_bloc.dart';

@immutable
abstract class SelectRadioButtonEvent {}
class SelectRadioButtonBlocEvent extends SelectRadioButtonEvent {
  final int index;
  final String title;
  SelectRadioButtonBlocEvent({
    this.index = 0,
    this.title = '',
  });
}
