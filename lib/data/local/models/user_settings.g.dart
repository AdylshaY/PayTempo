// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingsCollection on Isar {
  IsarCollection<UserSettings> get userSettings => this.collection();
}

const UserSettingsSchema = CollectionSchema(
  name: r'UserSettings',
  id: 4939698790990493221,
  properties: {
    r'baseCurrency': PropertySchema(
      id: 0,
      name: r'baseCurrency',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 1,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'email': PropertySchema(
      id: 2,
      name: r'email',
      type: IsarType.string,
    ),
    r'isPro': PropertySchema(
      id: 3,
      name: r'isPro',
      type: IsarType.bool,
    ),
    r'lastSyncTime': PropertySchema(
      id: 4,
      name: r'lastSyncTime',
      type: IsarType.dateTime,
    ),
    r'proExpiryDate': PropertySchema(
      id: 5,
      name: r'proExpiryDate',
      type: IsarType.dateTime,
    ),
    r'proPlanType': PropertySchema(
      id: 6,
      name: r'proPlanType',
      type: IsarType.string,
    ),
    r'proPriceDisplay': PropertySchema(
      id: 7,
      name: r'proPriceDisplay',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 8,
      name: r'themeMode',
      type: IsarType.byte,
      enumMap: _UserSettingsthemeModeEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _userSettingsEstimateSize,
  serialize: _userSettingsSerialize,
  deserialize: _userSettingsDeserialize,
  deserializeProp: _userSettingsDeserializeProp,
  idName: r'id',
  indexes: {
    r'baseCurrency': IndexSchema(
      id: -862513801833578591,
      name: r'baseCurrency',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'baseCurrency',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userSettingsGetId,
  getLinks: _userSettingsGetLinks,
  attach: _userSettingsAttach,
  version: '3.1.0+1',
);

int _userSettingsEstimateSize(
  UserSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.baseCurrency.length * 3;
  {
    final value = object.displayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.proPlanType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.proPriceDisplay;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userSettingsSerialize(
  UserSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.baseCurrency);
  writer.writeString(offsets[1], object.displayName);
  writer.writeString(offsets[2], object.email);
  writer.writeBool(offsets[3], object.isPro);
  writer.writeDateTime(offsets[4], object.lastSyncTime);
  writer.writeDateTime(offsets[5], object.proExpiryDate);
  writer.writeString(offsets[6], object.proPlanType);
  writer.writeString(offsets[7], object.proPriceDisplay);
  writer.writeByte(offsets[8], object.themeMode.index);
  writer.writeString(offsets[9], object.userId);
}

UserSettings _userSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettings(
    baseCurrency: reader.readString(offsets[0]),
    displayName: reader.readStringOrNull(offsets[1]),
    email: reader.readStringOrNull(offsets[2]),
    id: id,
    isPro: reader.readBoolOrNull(offsets[3]) ?? false,
    lastSyncTime: reader.readDateTimeOrNull(offsets[4]),
    proExpiryDate: reader.readDateTimeOrNull(offsets[5]),
    proPlanType: reader.readStringOrNull(offsets[6]),
    proPriceDisplay: reader.readStringOrNull(offsets[7]),
    themeMode:
        _UserSettingsthemeModeValueEnumMap[reader.readByteOrNull(offsets[8])] ??
            AppThemeMode.system,
    userId: reader.readStringOrNull(offsets[9]),
  );
  return object;
}

P _userSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_UserSettingsthemeModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          AppThemeMode.system) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserSettingsthemeModeEnumValueMap = {
  'system': 0,
  'light': 1,
  'dark': 2,
};
const _UserSettingsthemeModeValueEnumMap = {
  0: AppThemeMode.system,
  1: AppThemeMode.light,
  2: AppThemeMode.dark,
};

Id _userSettingsGetId(UserSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSettingsGetLinks(UserSettings object) {
  return [];
}

void _userSettingsAttach(
    IsarCollection<dynamic> col, Id id, UserSettings object) {
  object.id = id;
}

extension UserSettingsQueryWhereSort
    on QueryBuilder<UserSettings, UserSettings, QWhere> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSettingsQueryWhere
    on QueryBuilder<UserSettings, UserSettings, QWhereClause> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idBetween(
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

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause>
      baseCurrencyEqualTo(String baseCurrency) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'baseCurrency',
        value: [baseCurrency],
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause>
      baseCurrencyNotEqualTo(String baseCurrency) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'baseCurrency',
              lower: [],
              upper: [baseCurrency],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'baseCurrency',
              lower: [baseCurrency],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'baseCurrency',
              lower: [baseCurrency],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'baseCurrency',
              lower: [],
              upper: [baseCurrency],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserSettingsQueryFilter
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {
  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'baseCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'baseCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'baseCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      baseCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'baseCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayName',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> isProEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPro',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSyncTime',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSyncTime',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSyncTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      lastSyncTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSyncTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proExpiryDate',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proExpiryDate',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proExpiryDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proExpiryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proPlanType',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proPlanType',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proPlanType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proPlanType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proPlanType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proPlanType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPlanTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proPlanType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proPriceDisplay',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proPriceDisplay',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proPriceDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proPriceDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proPriceDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proPriceDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      proPriceDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proPriceDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      themeModeEqualTo(AppThemeMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      themeModeGreaterThan(
    AppThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      themeModeLessThan(
    AppThemeMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      themeModeBetween(
    AppThemeMode lower,
    AppThemeMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> userIdEqualTo(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> userIdBetween(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UserSettingsQueryObject
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQueryLinks
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQuerySortBy
    on QueryBuilder<UserSettings, UserSettings, QSortBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByBaseCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseCurrency', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByBaseCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseCurrency', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByIsProDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByProExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proExpiryDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByProExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proExpiryDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByProPlanType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPlanType', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByProPlanTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPlanType', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByProPriceDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPriceDisplay', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByProPriceDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPriceDisplay', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSettingsQuerySortThenBy
    on QueryBuilder<UserSettings, UserSettings, QSortThenBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByBaseCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseCurrency', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByBaseCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseCurrency', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIsProDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPro', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByLastSyncTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByProExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proExpiryDate', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByProExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proExpiryDate', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByProPlanType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPlanType', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByProPlanTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPlanType', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByProPriceDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPriceDisplay', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByProPriceDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proPriceDisplay', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSettingsQueryWhereDistinct
    on QueryBuilder<UserSettings, UserSettings, QDistinct> {
  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByBaseCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'baseCurrency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByIsPro() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPro');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByLastSyncTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncTime');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByProExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proExpiryDate');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByProPlanType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proPlanType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByProPriceDisplay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proPriceDisplay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserSettingsQueryProperty
    on QueryBuilder<UserSettings, UserSettings, QQueryProperty> {
  QueryBuilder<UserSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations> baseCurrencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseCurrency');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> isProProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPro');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
      lastSyncTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncTime');
    });
  }

  QueryBuilder<UserSettings, DateTime?, QQueryOperations>
      proExpiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proExpiryDate');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> proPlanTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proPlanType');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations>
      proPriceDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proPriceDisplay');
    });
  }

  QueryBuilder<UserSettings, AppThemeMode, QQueryOperations>
      themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
