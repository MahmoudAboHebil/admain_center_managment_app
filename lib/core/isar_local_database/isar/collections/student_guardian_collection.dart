import 'package:isar/isar.dart';

part 'student_guardian_collection.g.dart';

@collection
class StudentGuardianCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String entityId;
  @Index()
  late String studentId;
  @Index()
  late String centerId;
  @Index()
  late String guardianId;
  late DateTime createdAt;

  late String byUser;
  late String byDevice;
  @Index()
  late bool isDeleted;
  @Index()
  late int version;
  late DateTime updatedAt;
}
