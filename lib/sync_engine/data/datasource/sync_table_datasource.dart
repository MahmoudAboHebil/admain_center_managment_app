import 'package:admain_center_managment_app/core/enums/DB_Table.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';

abstract class SyncTableDatasource {
  DBTable get table;
  Future<void> softDelete(String entityId);
  Future<void> softDeleteEntities(List<String> ids);
  Future<List<String>> getForeignkeyEntitiesIdsBulk(
    DBTable parentTable,
    List<String> parentsIds,
  );
  Future<void> updateEntity<T>(T model);
  Future<void> insertEntity<T>(T model);
  Future<StandardTableRecordModel?> getEntity(String entityId);
}
