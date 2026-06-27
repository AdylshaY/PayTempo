// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_reminder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationReminderCollection on Isar {
  IsarCollection<NotificationReminder> get notificationReminders =>
      this.collection();
}

const NotificationReminderSchema = CollectionSchema(
  name: r'NotificationReminder',
  id: 1320660086775261077,
  properties: {
    r'customHour': PropertySchema(
      id: 0,
      name: r'customHour',
      type: IsarType.long,
    ),
    r'customMinute': PropertySchema(
      id: 1,
      name: r'customMinute',
      type: IsarType.long,
    ),
    r'daysBefore': PropertySchema(
      id: 2,
      name: r'daysBefore',
      type: IsarType.long,
    ),
    r'subscriptionUid': PropertySchema(
      id: 3,
      name: r'subscriptionUid',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 4,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _notificationReminderEstimateSize,
  serialize: _notificationReminderSerialize,
  deserialize: _notificationReminderDeserialize,
  deserializeProp: _notificationReminderDeserializeProp,
  idName: r'id',
  indexes: {
    r'uid': IndexSchema(
      id: 8193695471701937315,
      name: r'uid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'subscriptionUid': IndexSchema(
      id: 94379846701514230,
      name: r'subscriptionUid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subscriptionUid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _notificationReminderGetId,
  getLinks: _notificationReminderGetLinks,
  attach: _notificationReminderAttach,
  version: '3.1.0+1',
);

int _notificationReminderEstimateSize(
  NotificationReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.subscriptionUid.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _notificationReminderSerialize(
  NotificationReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.customHour);
  writer.writeLong(offsets[1], object.customMinute);
  writer.writeLong(offsets[2], object.daysBefore);
  writer.writeString(offsets[3], object.subscriptionUid);
  writer.writeString(offsets[4], object.uid);
  writer.writeDateTime(offsets[5], object.updatedAt);
}

NotificationReminder _notificationReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationReminder(
    customHour: reader.readLongOrNull(offsets[0]),
    customMinute: reader.readLongOrNull(offsets[1]),
    daysBefore: reader.readLong(offsets[2]),
    id: id,
    subscriptionUid: reader.readString(offsets[3]),
    uid: reader.readString(offsets[4]),
    updatedAt: reader.readDateTime(offsets[5]),
  );
  return object;
}

P _notificationReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _notificationReminderGetId(NotificationReminder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationReminderGetLinks(
    NotificationReminder object) {
  return [];
}

void _notificationReminderAttach(
    IsarCollection<dynamic> col, Id id, NotificationReminder object) {
  object.id = id;
}

extension NotificationReminderByIndex on IsarCollection<NotificationReminder> {
  Future<NotificationReminder?> getByUid(String uid) {
    return getByIndex(r'uid', [uid]);
  }

  NotificationReminder? getByUidSync(String uid) {
    return getByIndexSync(r'uid', [uid]);
  }

  Future<bool> deleteByUid(String uid) {
    return deleteByIndex(r'uid', [uid]);
  }

  bool deleteByUidSync(String uid) {
    return deleteByIndexSync(r'uid', [uid]);
  }

  Future<List<NotificationReminder?>> getAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uid', values);
  }

  List<NotificationReminder?> getAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uid', values);
  }

  Future<int> deleteAllByUid(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uid', values);
  }

  int deleteAllByUidSync(List<String> uidValues) {
    final values = uidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uid', values);
  }

  Future<Id> putByUid(NotificationReminder object) {
    return putByIndex(r'uid', object);
  }

  Id putByUidSync(NotificationReminder object, {bool saveLinks = true}) {
    return putByIndexSync(r'uid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUid(List<NotificationReminder> objects) {
    return putAllByIndex(r'uid', objects);
  }

  List<Id> putAllByUidSync(List<NotificationReminder> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uid', objects, saveLinks: saveLinks);
  }
}

extension NotificationReminderQueryWhereSort
    on QueryBuilder<NotificationReminder, NotificationReminder, QWhere> {
  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationReminderQueryWhere
    on QueryBuilder<NotificationReminder, NotificationReminder, QWhereClause> {
  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
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

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      uidEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uid',
        value: [uid],
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      uidNotEqualTo(String uid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [uid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uid',
              lower: [],
              upper: [uid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      subscriptionUidEqualTo(String subscriptionUid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subscriptionUid',
        value: [subscriptionUid],
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterWhereClause>
      subscriptionUidNotEqualTo(String subscriptionUid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subscriptionUid',
              lower: [],
              upper: [subscriptionUid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subscriptionUid',
              lower: [subscriptionUid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subscriptionUid',
              lower: [subscriptionUid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subscriptionUid',
              lower: [],
              upper: [subscriptionUid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension NotificationReminderQueryFilter on QueryBuilder<NotificationReminder,
    NotificationReminder, QFilterCondition> {
  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customHour',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customHour',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customHour',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customHour',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customHour',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customHourBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customMinute',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customMinute',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> customMinuteBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> daysBeforeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> daysBeforeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> daysBeforeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysBefore',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> daysBeforeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysBefore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
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

  QueryBuilder<NotificationReminder, NotificationReminder,
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

  QueryBuilder<NotificationReminder, NotificationReminder,
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

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subscriptionUid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
          QAfterFilterCondition>
      subscriptionUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
          QAfterFilterCondition>
      subscriptionUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subscriptionUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscriptionUid',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> subscriptionUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subscriptionUid',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
          QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
          QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder,
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

  QueryBuilder<NotificationReminder, NotificationReminder,
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

  QueryBuilder<NotificationReminder, NotificationReminder,
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
}

extension NotificationReminderQueryObject on QueryBuilder<NotificationReminder,
    NotificationReminder, QFilterCondition> {}

extension NotificationReminderQueryLinks on QueryBuilder<NotificationReminder,
    NotificationReminder, QFilterCondition> {}

extension NotificationReminderQuerySortBy
    on QueryBuilder<NotificationReminder, NotificationReminder, QSortBy> {
  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByCustomHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customHour', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByCustomHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customHour', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByCustomMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMinute', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByCustomMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMinute', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByDaysBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysBefore', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByDaysBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysBefore', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortBySubscriptionUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortBySubscriptionUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension NotificationReminderQuerySortThenBy
    on QueryBuilder<NotificationReminder, NotificationReminder, QSortThenBy> {
  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByCustomHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customHour', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByCustomHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customHour', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByCustomMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMinute', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByCustomMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customMinute', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByDaysBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysBefore', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByDaysBeforeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysBefore', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenBySubscriptionUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenBySubscriptionUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension NotificationReminderQueryWhereDistinct
    on QueryBuilder<NotificationReminder, NotificationReminder, QDistinct> {
  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctByCustomHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customHour');
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctByCustomMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customMinute');
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctByDaysBefore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysBefore');
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctBySubscriptionUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscriptionUid',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctByUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationReminder, NotificationReminder, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension NotificationReminderQueryProperty on QueryBuilder<
    NotificationReminder, NotificationReminder, QQueryProperty> {
  QueryBuilder<NotificationReminder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationReminder, int?, QQueryOperations>
      customHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customHour');
    });
  }

  QueryBuilder<NotificationReminder, int?, QQueryOperations>
      customMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customMinute');
    });
  }

  QueryBuilder<NotificationReminder, int, QQueryOperations>
      daysBeforeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysBefore');
    });
  }

  QueryBuilder<NotificationReminder, String, QQueryOperations>
      subscriptionUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscriptionUid');
    });
  }

  QueryBuilder<NotificationReminder, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<NotificationReminder, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
