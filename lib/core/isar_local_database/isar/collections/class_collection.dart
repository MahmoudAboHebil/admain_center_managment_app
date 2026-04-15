import 'package:isar/isar.dart';

part 'class_collection.g.dart';

@collection
class ClassCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String entityId;
  @Index()
  late String centerId;
  late String byUser;
  late String byDevice;
  @Index()
  late bool isDeleted;
  @Index()
  late int version;
  late DateTime createdAt;
  late DateTime updatedAt;
  @Index()
  late String name;
  late String room;
  @Index()
  late String studyLevelId;
  @Index()
  late String divisionEnum;
  @Index()
  late int semester;
}
