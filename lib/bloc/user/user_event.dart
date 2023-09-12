part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadAllUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;

  const UpdateUserEvent({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class DeleteUserEvent extends UserEvent {
  final int userId;

  const DeleteUserEvent({
    required this.userId,
  });
}
