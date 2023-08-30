import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess<T> extends DataState {
  final T data;

  const DataSuccess({required this.data});

  @override
  List<Object> get props => [];
}

class DataError extends DataState {
  final String message;

  const DataError({required this.message});

  @override
  List<Object> get props => [message];
}
