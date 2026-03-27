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

  @Index(caseSensitive: false)
  late String name;
  late String studyLevelId;
  late String gender;
  late String studentCode;

  late String? phone;
  late String? homePhone;
  late String? parentPhone;
  late List<String>? studentClasses;
  late double? bookingDeposit;
  late List<String>? notes;
  late String? paymentTypeEnum;

  late String? address;
  late String? schoolName;
  late String? parentJob;
  late String? divisionEnum;
  late DateTime? birthDate;
  late String? email;
  late String studentStatus;
}
