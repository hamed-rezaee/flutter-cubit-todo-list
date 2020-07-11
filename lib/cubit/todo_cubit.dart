import 'package:cubit/cubit.dart';
import 'package:flutter_cubit_todo/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  @override
  void onTransition(Transition<TodoState> transition) {
    print(transition);

    super.onTransition(transition);
  }

  void getTodoList() async {
    try {
      emit(TodoLoading());

      List<TodoModel> result = await Future<List<TodoModel>>.delayed(
        Duration(seconds: 2),
        () => <TodoModel>[
          TodoModel(title: 'Todo 01', detail: 'Todo 01 detail.'),
          TodoModel(title: 'Todo 02', detail: 'Todo 02 detail.'),
          TodoModel(title: 'Todo 03', detail: 'Todo 03 detail.'),
          TodoModel(title: 'Todo 04', detail: 'Todo 04 detail.'),
          TodoModel(title: 'Todo 05', detail: 'Todo 05 detail.'),
          TodoModel(title: 'Todo 06', detail: 'Todo 06 detail.'),
          TodoModel(title: 'Todo 07', detail: 'Todo 07 detail.'),
          TodoModel(title: 'Todo 08', detail: 'Todo 08 detail.'),
          TodoModel(title: 'Todo 09', detail: 'Todo 09 detail.'),
          TodoModel(title: 'Todo 10', detail: 'Todo 10 detail.'),
          TodoModel(title: 'Todo 11', detail: 'Todo 11 detail.'),
        ],
      );

      emit(TodoLoaded(result));
    } on Exception {
      emit(TodoError('Todo Cubit Error!'));
    }
  }

  Future<void> addNewItem(TodoModel item) async {
    try {
      if (state is TodoLoaded) {
        List<TodoModel> result = (state as TodoLoaded).models;

        await Future.delayed(Duration(seconds: 2), () {
          result.add(item);
        });

        emit(TodoLoaded(result));
      }
    } on Exception {
      emit(TodoError('Todo Cubit Error!'));
    }
  }
}
