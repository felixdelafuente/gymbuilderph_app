import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_builder_app/data/repositories/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState()) {
    Repository repository = Repository();
    print("outside LoadUserEvent working");

    on<LoadAllUserEvent>((event, emit) async {
      print("inside LoadUserEvent working");
      emit(UserLoadingState());
      try {
        print("inside try UserLoadingState working");
        final user = await repository.getAllUser();
        print("UserBloc UserLoadedState: $user");
        emit(AllUserLoadedState(user));
      } catch (e) {
        print("UserBloc UserErrorState: ${e.toString()}");
        emit(UserErrorState(e.toString()));
      }
    });

    on<LoadUserEvent>((event, emit) async {
      print("inside LoadUserEvent working");
      emit(UserLoadingState());
      try {
        print("inside try UserLoadingState working");
        final user = await repository.getUser();
        print("UserBloc UserLoadedState: $user");
        emit(UserLoadedState(user));
      } catch (e) {
        print("UserBloc UserErrorState: ${e.toString()}");
        emit(UserErrorState(e.toString()));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      try {
        print("inside try update UserBloc working");
        final response = await repository.updateUser(
          event.userId,
          event.firstName,
          event.lastName,
          event.email,
        );
        final user = await repository.getUser();
        emit(UserLoadedState(user));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        print("inside try delete MembersBloc working");
        final response = await repository.deleteUser(event.userId);
        final user = await repository.getUser();
        emit(UserLoadedState(user));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}