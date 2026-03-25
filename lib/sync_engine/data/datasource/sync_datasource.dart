import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../core/isar_local_database/isar/collections/configration_collection.dart';
import '../../../core/isar_local_database/isar/isar_service.dart';

class SyncDatasource {
  Future<DateTime> getLastSyncTime() async {
    final collection = await IsarService.isar.configrationCollections
        .filter()
        .recordIdEqualTo(1)
        .findFirst();

    if (collection == null) {
      final uuid = Uuid();
      final datatime = DateTime.now().copyWith(year: 2020).toUtc();
      final newCollection = ConfigrationCollection()
        ..lastSyncTime = datatime
        ..recordId = 1
        ..deviceId = uuid.v4();
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.configrationCollections.put(newCollection);
      });
      return datatime;
    }
    return collection.lastSyncTime.toUtc();
  }

  Future<void> updateLastTimeSync(DateTime timeAsUTC) async {
    final collection = await IsarService.isar.configrationCollections
        .filter()
        .recordIdEqualTo(1)
        .findFirst();
    if (collection == null) return;
    collection.lastSyncTime = timeAsUTC;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.configrationCollections.put(collection);
    });
  }

  Future<String> getDeviceId() async {
    final collection = await IsarService.isar.configrationCollections
        .filter()
        .recordIdEqualTo(1)
        .findFirst();

    if (collection == null) {
      final uuid = Uuid();
      final code = uuid.v4();
      final datatime = DateTime.now().copyWith(year: 2020).toUtc();
      final newCollection = ConfigrationCollection()
        ..lastSyncTime = datatime
        ..recordId = 1
        ..deviceId = code;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.configrationCollections.put(newCollection);
      });
      return code;
    }
    return collection.deviceId;
  }
}
