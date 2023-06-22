// ignore_for_file: unused_local_variable

import 'package:proto/proto.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    final id = request.id;
    final todo = Todo()
      ..id = id
      ..completed = true
      ..title =
          'this is number $id'; // <- cannot access Todo required parameters id, title and completed
    return todo;
  }

  @override
  Stream<Todo> getTodoStream(
      ServiceCall call, GetTodoByIdRequest request) async* {
    final id = request.id;
    final todo =
        Todo(); // <- cannot access Todo required parameters id, title and completed
    while (true) {
      yield todo;
    }
  }
}
