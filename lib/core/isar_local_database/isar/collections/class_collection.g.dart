// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClassCollectionCollection on Isar {
  IsarCollection<ClassCollection> get classCollections => this.collection();
}

const ClassCollectionSchema = CollectionSchema(
  name: r'ClassCollection',
  id: -8425545352391415740,
  properties: {
    r'byDevice': PropertySchema(
      id: 0,
      name: r'byDevice',
      type: IsarType.string,
    ),
    r'byUser': PropertySchema(
      id: 1,
      name: r'byUser',
      type: IsarType.string,
    ),
    r'centerId': PropertySchema(
      id: 2,
      name: r'centerId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'divisionEnum': PropertySchema(
      id: 4,
      name: r'divisionEnum',
      type: IsarType.string,
    ),
    r'entityId': PropertySchema(
      id: 5,
      name: r'entityId',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 6,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'room': PropertySchema(
      id: 8,
      name: r'room',
      type: IsarType.string,
    ),
    r'semester': PropertySchema(
      id: 9,
      name: r'semester',
      type: IsarType.long,
    ),
    r'studyLevelId': PropertySchema(
      id: 10,
      name: r'studyLevelId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'version': PropertySchema(
      id: 12,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _classCollectionEstimateSize,
  serialize: _classCollectionSerialize,
  deserialize: _classCollectionDeserialize,
  deserializeProp: _classCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'entityId': IndexSchema(
      id: 745355021660786263,
      name: r'entityId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entityId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'centerId': IndexSchema(
      id: 2705570276676374202,
      name: r'centerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'centerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isDeleted': IndexSchema(
      id: -786475870904832312,
      name: r'isDeleted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDeleted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'version': IndexSchema(
      id: -3425991338577364869,
      name: r'version',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'version',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'studyLevelId': IndexSchema(
      id: 802936186870061260,
      name: r'studyLevelId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'studyLevelId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'divisionEnum': IndexSchema(
      id: -3153794577520989423,
      name: r'divisionEnum',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'divisionEnum',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'semester': IndexSchema(
      id: 2655078537473598341,
      name: r'semester',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'semester',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _classCollectionGetId,
  getLinks: _classCollectionGetLinks,
  attach: _classCollectionAttach,
  version: '3.1.0',
);

int _classCollectionEstimateSize(
  ClassCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.byDevice.length * 3;
  bytesCount += 3 + object.byUser.length * 3;
  bytesCount += 3 + object.centerId.length * 3;
  bytesCount += 3 + object.divisionEnum.length * 3;
  bytesCount += 3 + object.entityId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.room.length * 3;
  bytesCount += 3 + object.studyLevelId.length * 3;
  return bytesCount;
}

void _classCollectionSerialize(
  ClassCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.byDevice);
  writer.writeString(offsets[1], object.byUser);
  writer.writeString(offsets[2], object.centerId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.divisionEnum);
  writer.writeString(offsets[5], object.entityId);
  writer.writeBool(offsets[6], object.isDeleted);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.room);
  writer.writeLong(offsets[9], object.semester);
  writer.writeString(offsets[10], object.studyLevelId);
  writer.writeDateTime(offsets[11], object.updatedAt);
  writer.writeLong(offsets[12], object.version);
}

ClassCollection _classCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ClassCollection();
  object.byDevice = reader.readString(offsets[0]);
  object.byUser = reader.readString(offsets[1]);
  object.centerId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.divisionEnum = reader.readString(offsets[4]);
  object.entityId = reader.readString(offsets[5]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[6]);
  object.name = reader.readString(offsets[7]);
  object.room = reader.readString(offsets[8]);
  object.semester = reader.readLong(offsets[9]);
  object.studyLevelId = reader.readString(offsets[10]);
  object.updatedAt = reader.readDateTime(offsets[11]);
  object.version = reader.readLong(offsets[12]);
  return object;
}

P _classCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _classCollectionGetId(ClassCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _classCollectionGetLinks(ClassCollection object) {
  return [];
}

void _classCollectionAttach(
    IsarCollection<dynamic> col, Id id, ClassCollection object) {
  object.id = id;
}

extension ClassCollectionByIndex on IsarCollection<ClassCollection> {
  Future<ClassCollection?> getByEntityId(String entityId) {
    return getByIndex(r'entityId', [entityId]);
  }

  ClassCollection? getByEntityIdSync(String entityId) {
    return getByIndexSync(r'entityId', [entityId]);
  }

  Future<bool> deleteByEntityId(String entityId) {
    return deleteByIndex(r'entityId', [entityId]);
  }

  bool deleteByEntityIdSync(String entityId) {
    return deleteByIndexSync(r'entityId', [entityId]);
  }

  Future<List<ClassCollection?>> getAllByEntityId(List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'entityId', values);
  }

  List<ClassCollection?> getAllByEntityIdSync(List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'entityId', values);
  }

  Future<int> deleteAllByEntityId(List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'entityId', values);
  }

  int deleteAllByEntityIdSync(List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'entityId', values);
  }

  Future<Id> putByEntityId(ClassCollection object) {
    return putByIndex(r'entityId', object);
  }

  Id putByEntityIdSync(ClassCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'entityId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEntityId(List<ClassCollection> objects) {
    return putAllByIndex(r'entityId', objects);
  }

  List<Id> putAllByEntityIdSync(List<ClassCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'entityId', objects, saveLinks: saveLinks);
  }
}

extension ClassCollectionQueryWhereSort
    on QueryBuilder<ClassCollection, ClassCollection, QWhere> {
  QueryBuilder<ClassCollection, ClassCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhere> anyIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeleted'),
      );
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhere> anyVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'version'),
      );
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhere> anySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'semester'),
      );
    });
  }
}

extension ClassCollectionQueryWhere
    on QueryBuilder<ClassCollection, ClassCollection, QWhereClause> {
  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      entityIdEqualTo(String entityId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityId',
        value: [entityId],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      entityIdNotEqualTo(String entityId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityId',
              lower: [],
              upper: [entityId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityId',
              lower: [entityId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityId',
              lower: [entityId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entityId',
              lower: [],
              upper: [entityId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      centerIdEqualTo(String centerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'centerId',
        value: [centerId],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      centerIdNotEqualTo(String centerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'centerId',
              lower: [],
              upper: [centerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'centerId',
              lower: [centerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'centerId',
              lower: [centerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'centerId',
              lower: [],
              upper: [centerId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      isDeletedEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDeleted',
        value: [isDeleted],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      isDeletedNotEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [isDeleted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isDeleted',
              lower: [],
              upper: [isDeleted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      versionEqualTo(int version) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'version',
        value: [version],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      versionNotEqualTo(int version) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'version',
              lower: [],
              upper: [version],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'version',
              lower: [version],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'version',
              lower: [version],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'version',
              lower: [],
              upper: [version],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      versionGreaterThan(
    int version, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'version',
        lower: [version],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      versionLessThan(
    int version, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'version',
        lower: [],
        upper: [version],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      versionBetween(
    int lowerVersion,
    int upperVersion, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'version',
        lower: [lowerVersion],
        includeLower: includeLower,
        upper: [upperVersion],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      studyLevelIdEqualTo(String studyLevelId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'studyLevelId',
        value: [studyLevelId],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      studyLevelIdNotEqualTo(String studyLevelId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studyLevelId',
              lower: [],
              upper: [studyLevelId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studyLevelId',
              lower: [studyLevelId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studyLevelId',
              lower: [studyLevelId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studyLevelId',
              lower: [],
              upper: [studyLevelId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      divisionEnumEqualTo(String divisionEnum) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'divisionEnum',
        value: [divisionEnum],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      divisionEnumNotEqualTo(String divisionEnum) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'divisionEnum',
              lower: [],
              upper: [divisionEnum],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'divisionEnum',
              lower: [divisionEnum],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'divisionEnum',
              lower: [divisionEnum],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'divisionEnum',
              lower: [],
              upper: [divisionEnum],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      semesterEqualTo(int semester) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'semester',
        value: [semester],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      semesterNotEqualTo(int semester) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semester',
              lower: [],
              upper: [semester],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semester',
              lower: [semester],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semester',
              lower: [semester],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semester',
              lower: [],
              upper: [semester],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      semesterGreaterThan(
    int semester, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'semester',
        lower: [semester],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      semesterLessThan(
    int semester, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'semester',
        lower: [],
        upper: [semester],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterWhereClause>
      semesterBetween(
    int lowerSemester,
    int upperSemester, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'semester',
        lower: [lowerSemester],
        includeLower: includeLower,
        upper: [upperSemester],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClassCollectionQueryFilter
    on QueryBuilder<ClassCollection, ClassCollection, QFilterCondition> {
  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'byDevice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'byDevice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byDeviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'byUser',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'byUser',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      byUserIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'centerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'centerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      centerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'divisionEnum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divisionEnum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divisionEnum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionEnum',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      divisionEnumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divisionEnum',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entityId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      entityIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'room',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'room',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'room',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      roomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'room',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      semesterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'semester',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      semesterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'semester',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      semesterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'semester',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      semesterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'semester',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studyLevelId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'studyLevelId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'studyLevelId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studyLevelId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      studyLevelIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'studyLevelId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterFilterCondition>
      versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClassCollectionQueryObject
    on QueryBuilder<ClassCollection, ClassCollection, QFilterCondition> {}

extension ClassCollectionQueryLinks
    on QueryBuilder<ClassCollection, ClassCollection, QFilterCondition> {}

extension ClassCollectionQuerySortBy
    on QueryBuilder<ClassCollection, ClassCollection, QSortBy> {
  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> sortByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByDivisionEnum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionEnum', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByDivisionEnumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionEnum', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> sortByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortBySemesterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByStudyLevelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyLevelId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByStudyLevelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyLevelId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension ClassCollectionQuerySortThenBy
    on QueryBuilder<ClassCollection, ClassCollection, QSortThenBy> {
  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByDivisionEnum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionEnum', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByDivisionEnumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionEnum', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenByRoom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByRoomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'room', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenBySemesterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semester', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByStudyLevelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyLevelId', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByStudyLevelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyLevelId', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QAfterSortBy>
      thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension ClassCollectionQueryWhereDistinct
    on QueryBuilder<ClassCollection, ClassCollection, QDistinct> {
  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByByDevice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byDevice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByByUser(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byUser', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByCenterId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'centerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByDivisionEnum({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divisionEnum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByEntityId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct> distinctByRoom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'room', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctBySemester() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'semester');
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByStudyLevelId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studyLevelId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ClassCollection, ClassCollection, QDistinct>
      distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension ClassCollectionQueryProperty
    on QueryBuilder<ClassCollection, ClassCollection, QQueryProperty> {
  QueryBuilder<ClassCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> byDeviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byDevice');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> byUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byUser');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> centerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'centerId');
    });
  }

  QueryBuilder<ClassCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations>
      divisionEnumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divisionEnum');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> entityIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityId');
    });
  }

  QueryBuilder<ClassCollection, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations> roomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'room');
    });
  }

  QueryBuilder<ClassCollection, int, QQueryOperations> semesterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'semester');
    });
  }

  QueryBuilder<ClassCollection, String, QQueryOperations>
      studyLevelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studyLevelId');
    });
  }

  QueryBuilder<ClassCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ClassCollection, int, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
