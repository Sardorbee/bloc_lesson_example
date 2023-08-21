import 'package:bloc_lesson_example/data/bloc/cubits/button_color_cubit/button_color_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonColorCubit extends Cubit<ButtonColorState> {
  ButtonColorCubit()
      : super(ButtonColorState(List.generate(15, (index) => Colors.blue)));
  bool isButtonPressed = false;
  update(int buttonIndex) {
    
    final updatedColors = List<Color>.from(state.buttonColors);
    updatedColors[buttonIndex] = isButtonPressed ? Colors.red : Colors.blue;
isButtonPressed = !isButtonPressed;
    emit(ButtonColorState(updatedColors));
  }
}
