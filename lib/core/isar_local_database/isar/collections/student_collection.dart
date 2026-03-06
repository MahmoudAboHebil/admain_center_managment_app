import 'package:isar/isar.dart';

part 'student_collection.g.dart';

@collection
class StudentCollection {
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
  late String studyLevelId;
  @Index()
  late String name;
  @Index()
  late String? phone;
  @Index()
  late String? homePhone;
  @Index()
  late String? whatsAppPhone;
  @Index()
  late String schoolName;
  late String gender;
  late DateTime birthDate;
  @Index()
  late DateTime joinDate;
  @Index()
  late String studentStatus;
}
