import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/number_multiplier_cubit/nuber_multiplayer_state.dart';
import 'package:flutter/material.dart';

class NuberMultiplayerCubit extends Cubit<NumberState> {
  NuberMultiplayerCubit() : super(InitialState());
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();

  void calculateResult() {
    BigInt a = BigInt.tryParse(aController.text) ?? BigInt.zero;
    BigInt b = BigInt.tryParse(bController.text) ?? BigInt.zero;
    powerUpNumber(a: a.toInt(), b: b.toInt());
  }

  powerUpNumber({a, b}) {
    if (a == 0 || b == 0) {
      emit(InitialState());
    } else {
      emit(ResultState(result: pow(a, b).toInt()));
    }
  }

  String formatResult(int result) {
    String resultString = result.toString();
    String formattedResult = '';

    int groupCount = 0;
    for (int i = resultString.length - 1; i >= 0; i--) {
      formattedResult = resultString[i] + formattedResult;
      groupCount++;

      if (groupCount == 3 && i != 0) {
        formattedResult = ' $formattedResult';
        groupCount = 0;
      }
    }

    return formattedResult;
  }
}
