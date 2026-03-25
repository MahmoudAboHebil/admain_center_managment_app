// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_guardian_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudentGuardianCollectionCollection on Isar {
  IsarCollection<StudentGuardianCollection> get studentGuardianCollections =>
      this.collection();
}

const StudentGuardianCollectionSchema = CollectionSchema(
  name: r'StudentGuardianCollection',
  id: -7215970641222884248,
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
    r'entityId': PropertySchema(
      id: 4,
      name: r'entityId',
      type: IsarType.string,
    ),
    r'guardianId': PropertySchema(
      id: 5,
      name: r'guardianId',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 6,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'studentId': PropertySchema(
      id: 7,
      name: r'studentId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'version': PropertySchema(
      id: 9,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _studentGuardianCollectionEstimateSize,
  serialize: _studentGuardianCollectionSerialize,
  deserialize: _studentGuardianCollectionDeserialize,
  deserializeProp: _studentGuardianCollectionDeserializeProp,
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
    r'studentId': IndexSchema(
      id: -6791323312898281473,
      name: r'studentId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'studentId',
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
    r'guardianId': IndexSchema(
      id: 9165637927923597999,
      name: r'guardianId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'guardianId',
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _studentGuardianCollectionGetId,
  getLinks: _studentGuardianCollectionGetLinks,
  attach: _studentGuardianCollectionAttach,
  version: '3.1.0',
);

int _studentGuardianCollectionEstimateSize(
  StudentGuardianCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.byDevice.length * 3;
  bytesCount += 3 + object.byUser.length * 3;
  bytesCount += 3 + object.centerId.length * 3;
  bytesCount += 3 + object.entityId.length * 3;
  bytesCount += 3 + object.guardianId.length * 3;
  bytesCount += 3 + object.studentId.length * 3;
  return bytesCount;
}

void _studentGuardianCollectionSerialize(
  StudentGuardianCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.byDevice);
  writer.writeString(offsets[1], object.byUser);
  writer.writeString(offsets[2], object.centerId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.entityId);
  writer.writeString(offsets[5], object.guardianId);
  writer.writeBool(offsets[6], object.isDeleted);
  writer.writeString(offsets[7], object.studentId);
  writer.writeDateTime(offsets[8], object.updatedAt);
  writer.writeLong(offsets[9], object.version);
}

StudentGuardianCollection _studentGuardianCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudentGuardianCollection();
  object.byDevice = reader.readString(offsets[0]);
  object.byUser = reader.readString(offsets[1]);
  object.centerId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.entityId = reader.readString(offsets[4]);
  object.guardianId = reader.readString(offsets[5]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[6]);
  object.studentId = reader.readString(offsets[7]);
  object.updatedAt = reader.readDateTime(offsets[8]);
  object.version = reader.readLong(offsets[9]);
  return object;
}

P _studentGuardianCollectionDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _studentGuardianCollectionGetId(StudentGuardianCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studentGuardianCollectionGetLinks(
    StudentGuardianCollection object) {
  return [];
}

void _studentGuardianCollectionAttach(
    IsarCollection<dynamic> col, Id id, StudentGuardianCollection object) {
  object.id = id;
}

extension StudentGuardianCollectionByIndex
    on IsarCollection<StudentGuardianCollection> {
  Future<StudentGuardianCollection?> getByEntityId(String entityId) {
    return getByIndex(r'entityId', [entityId]);
  }

  StudentGuardianCollection? getByEntityIdSync(String entityId) {
    return getByIndexSync(r'entityId', [entityId]);
  }

  Future<bool> deleteByEntityId(String entityId) {
    return deleteByIndex(r'entityId', [entityId]);
  }

  bool deleteByEntityIdSync(String entityId) {
    return deleteByIndexSync(r'entityId', [entityId]);
  }

  Future<List<StudentGuardianCollection?>> getAllByEntityId(
      List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'entityId', values);
  }

  List<StudentGuardianCollection?> getAllByEntityIdSync(
      List<String> entityIdValues) {
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

  Future<Id> putByEntityId(StudentGuardianCollection object) {
    return putByIndex(r'entityId', object);
  }

  Id putByEntityIdSync(StudentGuardianCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'entityId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEntityId(List<StudentGuardianCollection> objects) {
    return putAllByIndex(r'entityId', objects);
  }

  List<Id> putAllByEntityIdSync(List<StudentGuardianCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'entityId', objects, saveLinks: saveLinks);
  }
}

extension StudentGuardianCollectionQueryWhereSort on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QWhere> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhere> anyIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeleted'),
      );
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhere> anyVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'version'),
      );
    });
  }
}

extension StudentGuardianCollectionQueryWhere on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QWhereClause> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> entityIdEqualTo(String entityId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityId',
        value: [entityId],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> entityIdNotEqualTo(String entityId) {
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> studentIdEqualTo(String studentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'studentId',
        value: [studentId],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> studentIdNotEqualTo(String studentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studentId',
              lower: [],
              upper: [studentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studentId',
              lower: [studentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studentId',
              lower: [studentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'studentId',
              lower: [],
              upper: [studentId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> centerIdEqualTo(String centerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'centerId',
        value: [centerId],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> centerIdNotEqualTo(String centerId) {
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> guardianIdEqualTo(String guardianId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'guardianId',
        value: [guardianId],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> guardianIdNotEqualTo(String guardianId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'guardianId',
              lower: [],
              upper: [guardianId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'guardianId',
              lower: [guardianId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'guardianId',
              lower: [guardianId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'guardianId',
              lower: [],
              upper: [guardianId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> isDeletedEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDeleted',
        value: [isDeleted],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> isDeletedNotEqualTo(bool isDeleted) {
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> versionEqualTo(int version) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'version',
        value: [version],
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> versionNotEqualTo(int version) {
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> versionGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> versionLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterWhereClause> versionBetween(
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
}

extension StudentGuardianCollectionQueryFilter on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QFilterCondition> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceEqualTo(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceStartsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceEndsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      byDeviceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'byDevice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      byDeviceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'byDevice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byDeviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserEqualTo(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserStartsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserEndsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      byUserContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'byUser',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      byUserMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'byUser',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> byUserIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdEqualTo(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdStartsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdEndsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      centerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'centerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      centerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'centerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> centerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdEqualTo(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdStartsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdEndsWith(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      entityIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      entityIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> entityIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'guardianId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      guardianIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'guardianId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      guardianIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'guardianId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'guardianId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> guardianIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'guardianId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      studentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'studentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
          QAfterFilterCondition>
      studentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'studentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> studentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'studentId',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> versionGreaterThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> versionLessThan(
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

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterFilterCondition> versionBetween(
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

extension StudentGuardianCollectionQueryObject on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QFilterCondition> {}

extension StudentGuardianCollectionQueryLinks on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QFilterCondition> {}

extension StudentGuardianCollectionQuerySortBy on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QSortBy> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByGuardianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guardianId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByGuardianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guardianId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension StudentGuardianCollectionQuerySortThenBy on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QSortThenBy> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByGuardianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guardianId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByGuardianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'guardianId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection,
      QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension StudentGuardianCollectionQueryWhereDistinct on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QDistinct> {
  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByByDevice({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byDevice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByByUser({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byUser', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByCenterId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'centerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByEntityId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByGuardianId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'guardianId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByStudentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<StudentGuardianCollection, StudentGuardianCollection, QDistinct>
      distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension StudentGuardianCollectionQueryProperty on QueryBuilder<
    StudentGuardianCollection, StudentGuardianCollection, QQueryProperty> {
  QueryBuilder<StudentGuardianCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      byDeviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byDevice');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      byUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byUser');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      centerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'centerId');
    });
  }

  QueryBuilder<StudentGuardianCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      entityIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityId');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      guardianIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'guardianId');
    });
  }

  QueryBuilder<StudentGuardianCollection, bool, QQueryOperations>
      isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<StudentGuardianCollection, String, QQueryOperations>
      studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studentId');
    });
  }

  QueryBuilder<StudentGuardianCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<StudentGuardianCollection, int, QQueryOperations>
      versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
