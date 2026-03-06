//ToDo: (0) when creating objects with datatime create them as UTC()
//ToDo: (0) to save them local and remote
//ToDo: (0) isar does not care about utc or local when putting data,but
//ToDo: (0) so when getting data from it must be UTC

//ToDo: (1) create table model
//ToDo: (2) create local table datasource impl
//ToDo: (3) create table collection
//ToDo: (4) update table enum
//ToDo: (5) update tabelRelationsNotNull variable at (this file)
//ToDo: (6) update (table_repository_impl.dart)=> ALL-FUNCTIONS
//ToDo: (7) do a test

enum DBTable {
  Center,
  Guardian,
  Student,
  StudentGuardian,
  StudentLevel;

  static DBTable getDBTableFromString(String table) {
    for (final tab in DBTable.values) {
      if (tab.name == table) return tab;
    }
    throw Exception('$table is not found');
  }

  List<DBTable> getForwardNotNull() {
    final list = tabelRelationsNotNull[this]?["forward"];
    if (list == null) throw Exception('$this forward relation not found');
    return list;
  }
}

const Map<DBTable, Map<String, List<DBTable>>> tabelRelationsNotNull = {
  DBTable.Center: {"forward": [], "backword": []},
  DBTable.StudentLevel: {"forward": [], "backword": []},
  DBTable.StudentGuardian: {"forward": [], "backword": []},
  DBTable.Student: {
    "forward": [DBTable.StudentGuardian, DBTable.Guardian],
    "backword": [],
  },

  DBTable.Guardian: {
    "forward": [DBTable.StudentGuardian],
    "backword": [],
  },
};
