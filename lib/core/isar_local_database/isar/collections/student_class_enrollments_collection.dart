import 'package:isar/isar.dart';

part 'student_class_enrollments_collection.g.dart';

@collection
class StudentClassEnrollmentsCollection {
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
  late String studentId;
  @Index()
  late String classId;
  @Index()
  late String paymentType;
}
