// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubscriptionRecordCollection on Isar {
  IsarCollection<SubscriptionRecord> get subscriptionRecords =>
      this.collection();
}

const SubscriptionRecordSchema = CollectionSchema(
  name: r'SubscriptionRecord',
  id: -5833343487921943930,
  properties: {
    r'anchorDay': PropertySchema(
      id: 0,
      name: r'anchorDay',
      type: IsarType.long,
    ),
    r'avatarColorValue': PropertySchema(
      id: 1,
      name: r'avatarColorValue',
      type: IsarType.long,
    ),
    r'avatarEmoji': PropertySchema(
      id: 2,
      name: r'avatarEmoji',
      type: IsarType.string,
    ),
    r'avatarIconCodePoint': PropertySchema(
      id: 3,
      name: r'avatarIconCodePoint',
      type: IsarType.long,
    ),
    r'avatarIconFontFamily': PropertySchema(
      id: 4,
      name: r'avatarIconFontFamily',
      type: IsarType.string,
    ),
    r'avatarIconFontPackage': PropertySchema(
      id: 5,
      name: r'avatarIconFontPackage',
      type: IsarType.string,
    ),
    r'avatarType': PropertySchema(
      id: 6,
      name: r'avatarType',
      type: IsarType.string,
    ),
    r'billingCycle': PropertySchema(
      id: 7,
      name: r'billingCycle',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 8,
      name: r'category',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 9,
      name: r'currency',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 10,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'nextPaymentDate': PropertySchema(
      id: 12,
      name: r'nextPaymentDate',
      type: IsarType.dateTime,
    ),
    r'price': PropertySchema(
      id: 13,
      name: r'price',
      type: IsarType.double,
    ),
    r'uid': PropertySchema(
      id: 14,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 16,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _subscriptionRecordEstimateSize,
  serialize: _subscriptionRecordSerialize,
  deserialize: _subscriptionRecordDeserialize,
  deserializeProp: _subscriptionRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'category': IndexSchema(
      id: -7560358558326323820,
      name: r'category',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'category',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'avatarType': IndexSchema(
      id: 5717303880886970803,
      name: r'avatarType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'avatarType',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'currency': IndexSchema(
      id: 152811329157106879,
      name: r'currency',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'currency',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'billingCycle': IndexSchema(
      id: -3453462884969111697,
      name: r'billingCycle',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'billingCycle',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'nextPaymentDate': IndexSchema(
      id: 5346579929464532693,
      name: r'nextPaymentDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nextPaymentDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _subscriptionRecordGetId,
  getLinks: _subscriptionRecordGetLinks,
  attach: _subscriptionRecordAttach,
  version: '3.1.0+1',
);

int _subscriptionRecordEstimateSize(
  SubscriptionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.avatarEmoji;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarIconFontFamily;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarIconFontPackage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatarType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.billingCycle.length * 3;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _subscriptionRecordSerialize(
  SubscriptionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.anchorDay);
  writer.writeLong(offsets[1], object.avatarColorValue);
  writer.writeString(offsets[2], object.avatarEmoji);
  writer.writeLong(offsets[3], object.avatarIconCodePoint);
  writer.writeString(offsets[4], object.avatarIconFontFamily);
  writer.writeString(offsets[5], object.avatarIconFontPackage);
  writer.writeString(offsets[6], object.avatarType);
  writer.writeString(offsets[7], object.billingCycle);
  writer.writeString(offsets[8], object.category);
  writer.writeString(offsets[9], object.currency);
  writer.writeBool(offsets[10], object.isDeleted);
  writer.writeString(offsets[11], object.name);
  writer.writeDateTime(offsets[12], object.nextPaymentDate);
  writer.writeDouble(offsets[13], object.price);
  writer.writeString(offsets[14], object.uid);
  writer.writeDateTime(offsets[15], object.updatedAt);
  writer.writeString(offsets[16], object.userId);
}

SubscriptionRecord _subscriptionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubscriptionRecord(
    anchorDay: reader.readLong(offsets[0]),
    avatarColorValue: reader.readLongOrNull(offsets[1]),
    avatarEmoji: reader.readStringOrNull(offsets[2]),
    avatarIconCodePoint: reader.readLongOrNull(offsets[3]),
    avatarIconFontFamily: reader.readStringOrNull(offsets[4]),
    avatarIconFontPackage: reader.readStringOrNull(offsets[5]),
    avatarType: reader.readStringOrNull(offsets[6]),
    billingCycle: reader.readString(offsets[7]),
    category: reader.readString(offsets[8]),
    currency: reader.readString(offsets[9]),
    id: id,
    isDeleted: reader.readBoolOrNull(offsets[10]) ?? false,
    name: reader.readString(offsets[11]),
    nextPaymentDate: reader.readDateTime(offsets[12]),
    price: reader.readDouble(offsets[13]),
    uid: reader.readString(offsets[14]),
    updatedAt: reader.readDateTime(offsets[15]),
    userId: reader.readStringOrNull(offsets[16]),
  );
  return object;
}

P _subscriptionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subscriptionRecordGetId(SubscriptionRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subscriptionRecordGetLinks(
    SubscriptionRecord object) {
  return [];
}

void _subscriptionRecordAttach(
    IsarCollection<dynamic> col, Id id, SubscriptionRecord object) {
  object.id = id;
}

extension SubscriptionRecordQueryWhereSort
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QWhere> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhere>
      anyNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nextPaymentDate'),
      );
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension SubscriptionRecordQueryWhere
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QWhereClause> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      categoryEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'category',
        value: [category],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      categoryNotEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      avatarTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarType',
        value: [null],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      avatarTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'avatarType',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      avatarTypeEqualTo(String? avatarType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarType',
        value: [avatarType],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      avatarTypeNotEqualTo(String? avatarType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarType',
              lower: [],
              upper: [avatarType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarType',
              lower: [avatarType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarType',
              lower: [avatarType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarType',
              lower: [],
              upper: [avatarType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      currencyEqualTo(String currency) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'currency',
        value: [currency],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      currencyNotEqualTo(String currency) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'currency',
              lower: [],
              upper: [currency],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'currency',
              lower: [currency],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'currency',
              lower: [currency],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'currency',
              lower: [],
              upper: [currency],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      billingCycleEqualTo(String billingCycle) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'billingCycle',
        value: [billingCycle],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      billingCycleNotEqualTo(String billingCycle) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'billingCycle',
              lower: [],
              upper: [billingCycle],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'billingCycle',
              lower: [billingCycle],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'billingCycle',
              lower: [billingCycle],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'billingCycle',
              lower: [],
              upper: [billingCycle],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      nextPaymentDateEqualTo(DateTime nextPaymentDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nextPaymentDate',
        value: [nextPaymentDate],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      nextPaymentDateNotEqualTo(DateTime nextPaymentDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextPaymentDate',
              lower: [],
              upper: [nextPaymentDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextPaymentDate',
              lower: [nextPaymentDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextPaymentDate',
              lower: [nextPaymentDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nextPaymentDate',
              lower: [],
              upper: [nextPaymentDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      nextPaymentDateGreaterThan(
    DateTime nextPaymentDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextPaymentDate',
        lower: [nextPaymentDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      nextPaymentDateLessThan(
    DateTime nextPaymentDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextPaymentDate',
        lower: [],
        upper: [nextPaymentDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      nextPaymentDateBetween(
    DateTime lowerNextPaymentDate,
    DateTime upperNextPaymentDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nextPaymentDate',
        lower: [lowerNextPaymentDate],
        includeLower: includeLower,
        upper: [upperNextPaymentDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      updatedAtEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      updatedAtNotEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      updatedAtGreaterThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      updatedAtLessThan(
    DateTime updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterWhereClause>
      updatedAtBetween(
    DateTime lowerUpdatedAt,
    DateTime upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SubscriptionRecordQueryFilter
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QFilterCondition> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      anchorDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      anchorDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      anchorDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      anchorDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'anchorDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarColorValue',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarColorValue',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarColorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarColorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarColorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarEmoji',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarEmoji',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarEmoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarEmoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarEmojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarIconCodePoint',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarIconCodePoint',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarIconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarIconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarIconCodePoint',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconCodePointBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarIconCodePoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarIconFontFamily',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarIconFontFamily',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarIconFontFamily',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarIconFontFamily',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarIconFontFamily',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarIconFontFamily',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontFamilyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarIconFontFamily',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarIconFontPackage',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarIconFontPackage',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarIconFontPackage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarIconFontPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarIconFontPackage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarIconFontPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarIconFontPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarIconFontPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarType',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarType',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarType',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      avatarTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarType',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'billingCycle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'billingCycle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'billingCycle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'billingCycle',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      billingCycleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'billingCycle',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nextPaymentDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nextPaymentDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nextPaymentDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      nextPaymentDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextPaymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidEqualTo(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidGreaterThan(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidLessThan(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidBetween(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidStartsWith(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidEndsWith(
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
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

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension SubscriptionRecordQueryObject
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QFilterCondition> {}

extension SubscriptionRecordQueryLinks
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QFilterCondition> {}

extension SubscriptionRecordQuerySortBy
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QSortBy> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAnchorDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarColorValue', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarColorValue', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarEmoji', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarEmoji', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontFamily', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontFamily', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconFontPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontPackage', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarIconFontPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontPackage', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarType', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByAvatarTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarType', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByBillingCycle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycle', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByBillingCycleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycle', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByNextPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SubscriptionRecordQuerySortThenBy
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QSortThenBy> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAnchorDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarColorValue', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarColorValue', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarEmoji', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarEmoji', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconCodePoint', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconCodePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconCodePoint', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconFontFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontFamily', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconFontFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontFamily', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconFontPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontPackage', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarIconFontPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarIconFontPackage', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarType', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByAvatarTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarType', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByBillingCycle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycle', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByBillingCycleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'billingCycle', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByNextPaymentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPaymentDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension SubscriptionRecordQueryWhereDistinct
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct> {
  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anchorDay');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarColorValue');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarEmoji({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarEmoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarIconCodePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarIconCodePoint');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarIconFontFamily({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarIconFontFamily',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarIconFontPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarIconFontPackage',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByAvatarType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByBillingCycle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'billingCycle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByNextPaymentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextPaymentDate');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<SubscriptionRecord, SubscriptionRecord, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension SubscriptionRecordQueryProperty
    on QueryBuilder<SubscriptionRecord, SubscriptionRecord, QQueryProperty> {
  QueryBuilder<SubscriptionRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubscriptionRecord, int, QQueryOperations> anchorDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anchorDay');
    });
  }

  QueryBuilder<SubscriptionRecord, int?, QQueryOperations>
      avatarColorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarColorValue');
    });
  }

  QueryBuilder<SubscriptionRecord, String?, QQueryOperations>
      avatarEmojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarEmoji');
    });
  }

  QueryBuilder<SubscriptionRecord, int?, QQueryOperations>
      avatarIconCodePointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarIconCodePoint');
    });
  }

  QueryBuilder<SubscriptionRecord, String?, QQueryOperations>
      avatarIconFontFamilyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarIconFontFamily');
    });
  }

  QueryBuilder<SubscriptionRecord, String?, QQueryOperations>
      avatarIconFontPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarIconFontPackage');
    });
  }

  QueryBuilder<SubscriptionRecord, String?, QQueryOperations>
      avatarTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarType');
    });
  }

  QueryBuilder<SubscriptionRecord, String, QQueryOperations>
      billingCycleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'billingCycle');
    });
  }

  QueryBuilder<SubscriptionRecord, String, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<SubscriptionRecord, String, QQueryOperations>
      currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<SubscriptionRecord, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<SubscriptionRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SubscriptionRecord, DateTime, QQueryOperations>
      nextPaymentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextPaymentDate');
    });
  }

  QueryBuilder<SubscriptionRecord, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<SubscriptionRecord, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<SubscriptionRecord, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<SubscriptionRecord, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
