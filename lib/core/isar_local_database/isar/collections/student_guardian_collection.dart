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
  late String guardianId;
  late DateTime createdAt;
}
