import 'package:hive_flutter/adapters.dart';
part 'To_Do_Models.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String todo;
  @HiveField(2)
  final bool isCompleted;
  @HiveField(3)
  final bool isDeleted;

  TodoModel({
    required this.id,
    required this.todo,
    this.isCompleted = false,
    this.isDeleted = false,
  });
}
