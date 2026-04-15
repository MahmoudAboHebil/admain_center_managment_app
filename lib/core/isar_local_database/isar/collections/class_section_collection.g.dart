// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_section_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClassSectionCollectionCollection on Isar {
  IsarCollection<ClassSectionCollection> get classSectionCollections =>
      this.collection();
}

const ClassSectionCollectionSchema = CollectionSchema(
  name: r'ClassSectionCollection',
  id: -8199707789713099422,
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
    r'classId': PropertySchema(
      id: 3,
      name: r'classId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'day': PropertySchema(
      id: 5,
      name: r'day',
      type: IsarType.long,
    ),
    r'endOn': PropertySchema(
      id: 6,
      name: r'endOn',
      type: IsarType.dateTime,
    ),
    r'entityId': PropertySchema(
      id: 7,
      name: r'entityId',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 8,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'startOn': PropertySchema(
      id: 9,
      name: r'startOn',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'version': PropertySchema(
      id: 11,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _classSectionCollectionEstimateSize,
  serialize: _classSectionCollectionSerialize,
  deserialize: _classSectionCollectionDeserialize,
  deserializeProp: _classSectionCollectionDeserializeProp,
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
    r'startOn': IndexSchema(
      id: -6077630173208928988,
      name: r'startOn',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'startOn',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'endOn': IndexSchema(
      id: 743097328187035339,
      name: r'endOn',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'endOn',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'day': IndexSchema(
      id: 3809350088207220763,
      name: r'day',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'day',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'classId': IndexSchema(
      id: 5352960816261817663,
      name: r'classId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'classId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _classSectionCollectionGetId,
  getLinks: _classSectionCollectionGetLinks,
  attach: _classSectionCollectionAttach,
  version: '3.1.0',
);

int _classSectionCollectionEstimateSize(
  ClassSectionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.byDevice.length * 3;
  bytesCount += 3 + object.byUser.length * 3;
  bytesCount += 3 + object.centerId.length * 3;
  bytesCount += 3 + object.classId.length * 3;
  bytesCount += 3 + object.entityId.length * 3;
  return bytesCount;
}

void _classSectionCollectionSerialize(
  ClassSectionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.byDevice);
  writer.writeString(offsets[1], object.byUser);
  writer.writeString(offsets[2], object.centerId);
  writer.writeString(offsets[3], object.classId);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeLong(offsets[5], object.day);
  writer.writeDateTime(offsets[6], object.endOn);
  writer.writeString(offsets[7], object.entityId);
  writer.writeBool(offsets[8], object.isDeleted);
  writer.writeDateTime(offsets[9], object.startOn);
  writer.writeDateTime(offsets[10], object.updatedAt);
  writer.writeLong(offsets[11], object.version);
}

ClassSectionCollection _classSectionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ClassSectionCollection();
  object.byDevice = reader.readString(offsets[0]);
  object.byUser = reader.readString(offsets[1]);
  object.centerId = reader.readString(offsets[2]);
  object.classId = reader.readString(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.day = reader.readLong(offsets[5]);
  object.endOn = reader.readDateTime(offsets[6]);
  object.entityId = reader.readString(offsets[7]);
  object.id = id;
  object.isDeleted = reader.readBool(offsets[8]);
  object.startOn = reader.readDateTime(offsets[9]);
  object.updatedAt = reader.readDateTime(offsets[10]);
  object.version = reader.readLong(offsets[11]);
  return object;
}

P _classSectionCollectionDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _classSectionCollectionGetId(ClassSectionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _classSectionCollectionGetLinks(
    ClassSectionCollection object) {
  return [];
}

void _classSectionCollectionAttach(
    IsarCollection<dynamic> col, Id id, ClassSectionCollection object) {
  object.id = id;
}

extension ClassSectionCollectionByIndex
    on IsarCollection<ClassSectionCollection> {
  Future<ClassSectionCollection?> getByEntityId(String entityId) {
    return getByIndex(r'entityId', [entityId]);
  }

  ClassSectionCollection? getByEntityIdSync(String entityId) {
    return getByIndexSync(r'entityId', [entityId]);
  }

  Future<bool> deleteByEntityId(String entityId) {
    return deleteByIndex(r'entityId', [entityId]);
  }

  bool deleteByEntityIdSync(String entityId) {
    return deleteByIndexSync(r'entityId', [entityId]);
  }

  Future<List<ClassSectionCollection?>> getAllByEntityId(
      List<String> entityIdValues) {
    final values = entityIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'entityId', values);
  }

  List<ClassSectionCollection?> getAllByEntityIdSync(
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

  Future<Id> putByEntityId(ClassSectionCollection object) {
    return putByIndex(r'entityId', object);
  }

  Id putByEntityIdSync(ClassSectionCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'entityId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEntityId(List<ClassSectionCollection> objects) {
    return putAllByIndex(r'entityId', objects);
  }

  List<Id> putAllByEntityIdSync(List<ClassSectionCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'entityId', objects, saveLinks: saveLinks);
  }
}

extension ClassSectionCollectionQueryWhereSort
    on QueryBuilder<ClassSectionCollection, ClassSectionCollection, QWhere> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeleted'),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'version'),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyStartOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startOn'),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyEndOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'endOn'),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterWhere>
      anyDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'day'),
      );
    });
  }
}

extension ClassSectionCollectionQueryWhere on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QWhereClause> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> entityIdEqualTo(String entityId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entityId',
        value: [entityId],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> centerIdEqualTo(String centerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'centerId',
        value: [centerId],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> isDeletedEqualTo(bool isDeleted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isDeleted',
        value: [isDeleted],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> versionEqualTo(int version) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'version',
        value: [version],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> startOnEqualTo(DateTime startOn) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startOn',
        value: [startOn],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> startOnNotEqualTo(DateTime startOn) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startOn',
              lower: [],
              upper: [startOn],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startOn',
              lower: [startOn],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startOn',
              lower: [startOn],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startOn',
              lower: [],
              upper: [startOn],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> startOnGreaterThan(
    DateTime startOn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startOn',
        lower: [startOn],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> startOnLessThan(
    DateTime startOn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startOn',
        lower: [],
        upper: [startOn],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> startOnBetween(
    DateTime lowerStartOn,
    DateTime upperStartOn, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startOn',
        lower: [lowerStartOn],
        includeLower: includeLower,
        upper: [upperStartOn],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> endOnEqualTo(DateTime endOn) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'endOn',
        value: [endOn],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> endOnNotEqualTo(DateTime endOn) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endOn',
              lower: [],
              upper: [endOn],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endOn',
              lower: [endOn],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endOn',
              lower: [endOn],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endOn',
              lower: [],
              upper: [endOn],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> endOnGreaterThan(
    DateTime endOn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endOn',
        lower: [endOn],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> endOnLessThan(
    DateTime endOn, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endOn',
        lower: [],
        upper: [endOn],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> endOnBetween(
    DateTime lowerEndOn,
    DateTime upperEndOn, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endOn',
        lower: [lowerEndOn],
        includeLower: includeLower,
        upper: [upperEndOn],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> dayEqualTo(int day) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'day',
        value: [day],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> dayNotEqualTo(int day) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'day',
              lower: [],
              upper: [day],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'day',
              lower: [day],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'day',
              lower: [day],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'day',
              lower: [],
              upper: [day],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> dayGreaterThan(
    int day, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'day',
        lower: [day],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> dayLessThan(
    int day, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'day',
        lower: [],
        upper: [day],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> dayBetween(
    int lowerDay,
    int upperDay, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'day',
        lower: [lowerDay],
        includeLower: includeLower,
        upper: [upperDay],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> classIdEqualTo(String classId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'classId',
        value: [classId],
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterWhereClause> classIdNotEqualTo(String classId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [],
              upper: [classId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [classId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [classId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'classId',
              lower: [],
              upper: [classId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ClassSectionCollectionQueryFilter on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QFilterCondition> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> byDeviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> byDeviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byDevice',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> byUserIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> byUserIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'byUser',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> centerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> centerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'centerId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'classId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
          QAfterFilterCondition>
      classIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'classId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
          QAfterFilterCondition>
      classIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'classId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'classId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> classIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'classId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> dayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> dayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> dayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'day',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> dayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'day',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> endOnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> endOnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> endOnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> endOnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> entityIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> entityIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityId',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> startOnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> startOnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> startOnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startOn',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> startOnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
      QAfterFilterCondition> versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

  QueryBuilder<ClassSectionCollection, ClassSectionCollection,
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

extension ClassSectionCollectionQueryObject on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QFilterCondition> {}

extension ClassSectionCollectionQueryLinks on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QFilterCondition> {}

extension ClassSectionCollectionQuerySortBy
    on QueryBuilder<ClassSectionCollection, ClassSectionCollection, QSortBy> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByEndOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOn', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByEndOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOn', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByStartOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startOn', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByStartOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startOn', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension ClassSectionCollectionQuerySortThenBy on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QSortThenBy> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByByDevice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByByDeviceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byDevice', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByByUser() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByByUserDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'byUser', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByCenterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByCenterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'centerId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByClassId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByClassIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'classId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'day', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByEndOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOn', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByEndOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endOn', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityId', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByStartOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startOn', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByStartOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startOn', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QAfterSortBy>
      thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension ClassSectionCollectionQueryWhereDistinct
    on QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct> {
  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByByDevice({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byDevice', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByByUser({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'byUser', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByCenterId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'centerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByClassId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'classId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'day');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByEndOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endOn');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByEntityId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByStartOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startOn');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ClassSectionCollection, ClassSectionCollection, QDistinct>
      distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension ClassSectionCollectionQueryProperty on QueryBuilder<
    ClassSectionCollection, ClassSectionCollection, QQueryProperty> {
  QueryBuilder<ClassSectionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ClassSectionCollection, String, QQueryOperations>
      byDeviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byDevice');
    });
  }

  QueryBuilder<ClassSectionCollection, String, QQueryOperations>
      byUserProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'byUser');
    });
  }

  QueryBuilder<ClassSectionCollection, String, QQueryOperations>
      centerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'centerId');
    });
  }

  QueryBuilder<ClassSectionCollection, String, QQueryOperations>
      classIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classId');
    });
  }

  QueryBuilder<ClassSectionCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ClassSectionCollection, int, QQueryOperations> dayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'day');
    });
  }

  QueryBuilder<ClassSectionCollection, DateTime, QQueryOperations>
      endOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endOn');
    });
  }

  QueryBuilder<ClassSectionCollection, String, QQueryOperations>
      entityIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityId');
    });
  }

  QueryBuilder<ClassSectionCollection, bool, QQueryOperations>
      isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<ClassSectionCollection, DateTime, QQueryOperations>
      startOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startOn');
    });
  }

  QueryBuilder<ClassSectionCollection, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ClassSectionCollection, int, QQueryOperations>
      versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
