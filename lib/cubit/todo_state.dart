part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> models;

  TodoLoaded(this.models);
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}
