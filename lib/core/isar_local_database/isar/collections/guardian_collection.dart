import 'package:isar/isar.dart';

part 'guardian_collection.g.dart';

@collection
class GuardianCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String entityId;
  @Index()
  late String centerId;
  @Index()
  late String name;
  @Index()
  late String relation;
  @Index()
  late String phone;

  @Index()
  late String whatsAppPhone;
  late String? email;
  late String addressLine1;
  late String? addressLine2;

  late String byUser;
  late String byDevice;
  @Index()
  late bool isDeleted;
  @Index()
  late int version;
  late DateTime createdAt;
  late DateTime updatedAt;
}
