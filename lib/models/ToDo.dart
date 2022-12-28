import 'package:hive/hive.dart';
part 'ToDo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? text;
  @HiveField(2)
  bool isDone = false;

  ToDo({
    required this.id,
    required this.text,
    required this.isDone,
  });
}
