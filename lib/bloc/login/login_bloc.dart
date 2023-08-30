import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym_builder_app/bloc/data_state.dart';
import 'package:gym_builder_app/bloc/login/login_event.dart';
import 'package:gym_builder_app/data/models/user_model.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';

class LoginBloc extends Bloc<LoginEvent, DataState> {
  LoginBloc() : super(DataInitial()) {
    Repository repository = Repository();
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoginUserEvent>((event, emit) async {
      try {
        emit(DataInitial());
        final response =
            await repository.loginResponse(event.email, event.password);
        emit(DataSuccess<UserModel>(data: response));
      } catch (e) {
        debugPrint("login bloc data error");
        emit(DataError(message: e.toString()));
      }
    });
  }
}
