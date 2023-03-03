import 'package:bloc/bloc.dart';
import 'package:calulator/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubit extends Cubit<CalculatorStates> {
  CalculatorCubit() : super(CalculatorInitState());
  static CalculatorCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }
}
