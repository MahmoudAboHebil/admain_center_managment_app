import 'package:isar/isar.dart';

part 'class_section_collection.g.dart';

@collection
class ClassSectionCollection {
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
  late DateTime startOn;
  @Index()
  late DateTime endOn;
  @Index()
  late int day;
  @Index()
  late String classId;
}
