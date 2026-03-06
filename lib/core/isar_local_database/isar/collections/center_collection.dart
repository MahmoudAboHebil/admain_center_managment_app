import 'package:isar/isar.dart';

part 'center_collection.g.dart';

@collection
class CenterCollection {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String entityId;
  @Index()
  late String name;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String byUser;
  late String byDevice;
  late int version;
}
