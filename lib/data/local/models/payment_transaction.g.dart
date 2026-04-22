// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPaymentTransactionCollection on Isar {
  IsarCollection<PaymentTransaction> get paymentTransactions =>
      this.collection();
}

const PaymentTransactionSchema = CollectionSchema(
  name: r'PaymentTransaction',
  id: 8269186181179648877,
  properties: {
    r'isDeleted': PropertySchema(
      id: 0,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'paidAmount': PropertySchema(
      id: 1,
      name: r'paidAmount',
      type: IsarType.double,
    ),
    r'paidAt': PropertySchema(
      id: 2,
      name: r'paidAt',
      type: IsarType.dateTime,
    ),
    r'paidCurrency': PropertySchema(
      id: 3,
      name: r'paidCurrency',
      type: IsarType.string,
    ),
    r'snapshotBaseAmount': PropertySchema(
      id: 4,
      name: r'snapshotBaseAmount',
      type: IsarType.double,
    ),
    r'snapshotBaseCurrency': PropertySchema(
      id: 5,
      name: r'snapshotBaseCurrency',
      type: IsarType.string,
    ),
    r'subscriptionUid': PropertySchema(
      id: 6,
      name: r'subscriptionUid',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 7,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _paymentTransactionEstimateSize,
  serialize: _paymentTransactionSerialize,
  deserialize: _paymentTransactionDeserialize,
  deserializeProp: _paymentTransactionDeserializeProp,
  idName: r'id',
  indexes: {
    r'subscriptionUid': IndexSchema(
      id: 94379846701514230,
      name: r'subscriptionUid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subscriptionUid',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'paidCurrency': IndexSchema(
      id: -6223736244945739838,
      name: r'paidCurrency',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'paidCurrency',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'snapshotBaseCurrency': IndexSchema(
      id: 7213241562151231422,
      name: r'snapshotBaseCurrency',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'snapshotBaseCurrency',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'paidAt': IndexSchema(
      id: -701685063105958775,
      name: r'paidAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'paidAt',
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
  getId: _paymentTransactionGetId,
  getLinks: _paymentTransactionGetLinks,
  attach: _paymentTransactionAttach,
  version: '3.1.0+1',
);

int _paymentTransactionEstimateSize(
  PaymentTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.paidCurrency.length * 3;
  bytesCount += 3 + object.snapshotBaseCurrency.length * 3;
  bytesCount += 3 + object.subscriptionUid.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _paymentTransactionSerialize(
  PaymentTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isDeleted);
  writer.writeDouble(offsets[1], object.paidAmount);
  writer.writeDateTime(offsets[2], object.paidAt);
  writer.writeString(offsets[3], object.paidCurrency);
  writer.writeDouble(offsets[4], object.snapshotBaseAmount);
  writer.writeString(offsets[5], object.snapshotBaseCurrency);
  writer.writeString(offsets[6], object.subscriptionUid);
  writer.writeString(offsets[7], object.uid);
  writer.writeDateTime(offsets[8], object.updatedAt);
  writer.writeString(offsets[9], object.userId);
}

PaymentTransaction _paymentTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PaymentTransaction(
    id: id,
    isDeleted: reader.readBoolOrNull(offsets[0]) ?? false,
    paidAmount: reader.readDouble(offsets[1]),
    paidAt: reader.readDateTime(offsets[2]),
    paidCurrency: reader.readString(offsets[3]),
    snapshotBaseAmount: reader.readDouble(offsets[4]),
    snapshotBaseCurrency: reader.readString(offsets[5]),
    subscriptionUid: reader.readString(offsets[6]),
    uid: reader.readString(offsets[7]),
    updatedAt: reader.readDateTime(offsets[8]),
    userId: reader.readStringOrNull(offsets[9]),
  );
  return object;
}

P _paymentTransactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _paymentTransactionGetId(PaymentTransaction object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _paymentTransactionGetLinks(
    PaymentTransaction object) {
  return [];
}

void _paymentTransactionAttach(
    IsarCollection<dynamic> col, Id id, PaymentTransaction object) {
  object.id = id;
}

extension PaymentTransactionQueryWhereSort
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QWhere> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhere>
      anyPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'paidAt'),
      );
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhere>
      anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }
}

extension PaymentTransactionQueryWhere
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QWhereClause> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      subscriptionUidEqualTo(String subscriptionUid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subscriptionUid',
        value: [subscriptionUid],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidCurrencyEqualTo(String paidCurrency) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'paidCurrency',
        value: [paidCurrency],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidCurrencyNotEqualTo(String paidCurrency) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidCurrency',
              lower: [],
              upper: [paidCurrency],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidCurrency',
              lower: [paidCurrency],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidCurrency',
              lower: [paidCurrency],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidCurrency',
              lower: [],
              upper: [paidCurrency],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      snapshotBaseCurrencyEqualTo(String snapshotBaseCurrency) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'snapshotBaseCurrency',
        value: [snapshotBaseCurrency],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      snapshotBaseCurrencyNotEqualTo(String snapshotBaseCurrency) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotBaseCurrency',
              lower: [],
              upper: [snapshotBaseCurrency],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotBaseCurrency',
              lower: [snapshotBaseCurrency],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotBaseCurrency',
              lower: [snapshotBaseCurrency],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'snapshotBaseCurrency',
              lower: [],
              upper: [snapshotBaseCurrency],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidAtEqualTo(DateTime paidAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'paidAt',
        value: [paidAt],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidAtNotEqualTo(DateTime paidAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidAt',
              lower: [],
              upper: [paidAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidAt',
              lower: [paidAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidAt',
              lower: [paidAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'paidAt',
              lower: [],
              upper: [paidAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidAtGreaterThan(
    DateTime paidAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'paidAt',
        lower: [paidAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidAtLessThan(
    DateTime paidAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'paidAt',
        lower: [],
        upper: [paidAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      paidAtBetween(
    DateTime lowerPaidAt,
    DateTime upperPaidAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'paidAt',
        lower: [lowerPaidAt],
        includeLower: includeLower,
        upper: [upperPaidAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
      updatedAtEqualTo(DateTime updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterWhereClause>
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

extension PaymentTransactionQueryFilter
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QFilterCondition> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      isDeletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paidCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paidCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      paidCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paidCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snapshotBaseAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snapshotBaseAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snapshotBaseAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snapshotBaseAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snapshotBaseCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'snapshotBaseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'snapshotBaseCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snapshotBaseCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      snapshotBaseCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'snapshotBaseCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidEqualTo(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidGreaterThan(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidLessThan(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidBetween(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidStartsWith(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidEndsWith(
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subscriptionUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subscriptionUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscriptionUid',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      subscriptionUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subscriptionUid',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
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

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension PaymentTransactionQueryObject
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QFilterCondition> {}

extension PaymentTransactionQueryLinks
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QFilterCondition> {}

extension PaymentTransactionQuerySortBy
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QSortBy> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidCurrency', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByPaidCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidCurrency', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySnapshotBaseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySnapshotBaseAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySnapshotBaseCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseCurrency', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySnapshotBaseCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseCurrency', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySubscriptionUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortBySubscriptionUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PaymentTransactionQuerySortThenBy
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QSortThenBy> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidCurrency', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByPaidCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paidCurrency', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySnapshotBaseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseAmount', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySnapshotBaseAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseAmount', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySnapshotBaseCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseCurrency', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySnapshotBaseCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'snapshotBaseCurrency', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySubscriptionUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenBySubscriptionUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUid', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PaymentTransactionQueryWhereDistinct
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct> {
  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByPaidAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidAmount');
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidAt');
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByPaidCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paidCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctBySnapshotBaseAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snapshotBaseAmount');
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctBySnapshotBaseCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'snapshotBaseCurrency',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctBySubscriptionUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscriptionUid',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<PaymentTransaction, PaymentTransaction, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension PaymentTransactionQueryProperty
    on QueryBuilder<PaymentTransaction, PaymentTransaction, QQueryProperty> {
  QueryBuilder<PaymentTransaction, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PaymentTransaction, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<PaymentTransaction, double, QQueryOperations>
      paidAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidAmount');
    });
  }

  QueryBuilder<PaymentTransaction, DateTime, QQueryOperations>
      paidAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidAt');
    });
  }

  QueryBuilder<PaymentTransaction, String, QQueryOperations>
      paidCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paidCurrency');
    });
  }

  QueryBuilder<PaymentTransaction, double, QQueryOperations>
      snapshotBaseAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snapshotBaseAmount');
    });
  }

  QueryBuilder<PaymentTransaction, String, QQueryOperations>
      snapshotBaseCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'snapshotBaseCurrency');
    });
  }

  QueryBuilder<PaymentTransaction, String, QQueryOperations>
      subscriptionUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscriptionUid');
    });
  }

  QueryBuilder<PaymentTransaction, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }

  QueryBuilder<PaymentTransaction, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<PaymentTransaction, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
