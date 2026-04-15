import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/center_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/configration_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/operation_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_class_enrollments_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Isar? _instance;

  static Future<Isar> getInstance() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [
        OperationCollectionSchema,
        ConfigrationCollectionSchema,
        CenterCollectionSchema,
        StudentCollectionSchema,
        ClassCollectionSchema,
        ClassSectionCollectionSchema,
        StudentClassEnrollmentsCollectionSchema,
      ],
      directory: dir.path,
      inspector: true,
    );

    return _instance!;
  }

  static Isar get isar {
    if (_instance == null) {
      throw Exception('Isar is not initialized');
    }
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
