// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceExclTaxMeta = const VerificationMeta(
    'unitPriceExclTax',
  );
  @override
  late final GeneratedColumn<int> unitPriceExclTax = GeneratedColumn<int>(
    'unit_price_excl_tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<int> taxRate = GeneratedColumn<int>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    unitPriceExclTax,
    taxRate,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit_price_excl_tax')) {
      context.handle(
        _unitPriceExclTaxMeta,
        unitPriceExclTax.isAcceptableOrUnknown(
          data['unit_price_excl_tax']!,
          _unitPriceExclTaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceExclTaxMeta);
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    } else if (isInserting) {
      context.missing(_taxRateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unitPriceExclTax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_excl_tax'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_rate'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final int id;
  final String name;
  final int unitPriceExclTax;
  final int taxRate;
  final String category;
  const ProductRow({
    required this.id,
    required this.name,
    required this.unitPriceExclTax,
    required this.taxRate,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['unit_price_excl_tax'] = Variable<int>(unitPriceExclTax);
    map['tax_rate'] = Variable<int>(taxRate);
    map['category'] = Variable<String>(category);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      unitPriceExclTax: Value(unitPriceExclTax),
      taxRate: Value(taxRate),
      category: Value(category),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unitPriceExclTax: serializer.fromJson<int>(json['unitPriceExclTax']),
      taxRate: serializer.fromJson<int>(json['taxRate']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unitPriceExclTax': serializer.toJson<int>(unitPriceExclTax),
      'taxRate': serializer.toJson<int>(taxRate),
      'category': serializer.toJson<String>(category),
    };
  }

  ProductRow copyWith({
    int? id,
    String? name,
    int? unitPriceExclTax,
    int? taxRate,
    String? category,
  }) => ProductRow(
    id: id ?? this.id,
    name: name ?? this.name,
    unitPriceExclTax: unitPriceExclTax ?? this.unitPriceExclTax,
    taxRate: taxRate ?? this.taxRate,
    category: category ?? this.category,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unitPriceExclTax: data.unitPriceExclTax.present
          ? data.unitPriceExclTax.value
          : this.unitPriceExclTax,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitPriceExclTax: $unitPriceExclTax, ')
          ..write('taxRate: $taxRate, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, unitPriceExclTax, taxRate, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.unitPriceExclTax == this.unitPriceExclTax &&
          other.taxRate == this.taxRate &&
          other.category == this.category);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> unitPriceExclTax;
  final Value<int> taxRate;
  final Value<String> category;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unitPriceExclTax = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.category = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int unitPriceExclTax,
    required int taxRate,
    required String category,
  }) : name = Value(name),
       unitPriceExclTax = Value(unitPriceExclTax),
       taxRate = Value(taxRate),
       category = Value(category);
  static Insertable<ProductRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? unitPriceExclTax,
    Expression<int>? taxRate,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unitPriceExclTax != null) 'unit_price_excl_tax': unitPriceExclTax,
      if (taxRate != null) 'tax_rate': taxRate,
      if (category != null) 'category': category,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? unitPriceExclTax,
    Value<int>? taxRate,
    Value<String>? category,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unitPriceExclTax: unitPriceExclTax ?? this.unitPriceExclTax,
      taxRate: taxRate ?? this.taxRate,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unitPriceExclTax.present) {
      map['unit_price_excl_tax'] = Variable<int>(unitPriceExclTax.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<int>(taxRate.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unitPriceExclTax: $unitPriceExclTax, ')
          ..write('taxRate: $taxRate, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, SaleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountTotalMeta = const VerificationMeta(
    'discountTotal',
  );
  @override
  late final GeneratedColumn<int> discountTotal = GeneratedColumn<int>(
    'discount_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grandTotalMeta = const VerificationMeta(
    'grandTotal',
  );
  @override
  late final GeneratedColumn<int> grandTotal = GeneratedColumn<int>(
    'grand_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenderedMeta = const VerificationMeta(
    'tendered',
  );
  @override
  late final GeneratedColumn<int> tendered = GeneratedColumn<int>(
    'tendered',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changeMeta = const VerificationMeta('change');
  @override
  late final GeneratedColumn<int> change = GeneratedColumn<int>(
    'change',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    discountTotal,
    grandTotal,
    tendered,
    change,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('discount_total')) {
      context.handle(
        _discountTotalMeta,
        discountTotal.isAcceptableOrUnknown(
          data['discount_total']!,
          _discountTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountTotalMeta);
    }
    if (data.containsKey('grand_total')) {
      context.handle(
        _grandTotalMeta,
        grandTotal.isAcceptableOrUnknown(data['grand_total']!, _grandTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grandTotalMeta);
    }
    if (data.containsKey('tendered')) {
      context.handle(
        _tenderedMeta,
        tendered.isAcceptableOrUnknown(data['tendered']!, _tenderedMeta),
      );
    } else if (isInserting) {
      context.missing(_tenderedMeta);
    }
    if (data.containsKey('change')) {
      context.handle(
        _changeMeta,
        change.isAcceptableOrUnknown(data['change']!, _changeMeta),
      );
    } else if (isInserting) {
      context.missing(_changeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      discountTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_total'],
      )!,
      grandTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grand_total'],
      )!,
      tendered: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tendered'],
      )!,
      change: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}change'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class SaleRow extends DataClass implements Insertable<SaleRow> {
  final int id;
  final int createdAt;
  final int discountTotal;
  final int grandTotal;
  final int tendered;
  final int change;
  const SaleRow({
    required this.id,
    required this.createdAt,
    required this.discountTotal,
    required this.grandTotal,
    required this.tendered,
    required this.change,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<int>(createdAt);
    map['discount_total'] = Variable<int>(discountTotal);
    map['grand_total'] = Variable<int>(grandTotal);
    map['tendered'] = Variable<int>(tendered);
    map['change'] = Variable<int>(change);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      discountTotal: Value(discountTotal),
      grandTotal: Value(grandTotal),
      tendered: Value(tendered),
      change: Value(change),
    );
  }

  factory SaleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleRow(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      discountTotal: serializer.fromJson<int>(json['discountTotal']),
      grandTotal: serializer.fromJson<int>(json['grandTotal']),
      tendered: serializer.fromJson<int>(json['tendered']),
      change: serializer.fromJson<int>(json['change']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'discountTotal': serializer.toJson<int>(discountTotal),
      'grandTotal': serializer.toJson<int>(grandTotal),
      'tendered': serializer.toJson<int>(tendered),
      'change': serializer.toJson<int>(change),
    };
  }

  SaleRow copyWith({
    int? id,
    int? createdAt,
    int? discountTotal,
    int? grandTotal,
    int? tendered,
    int? change,
  }) => SaleRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    discountTotal: discountTotal ?? this.discountTotal,
    grandTotal: grandTotal ?? this.grandTotal,
    tendered: tendered ?? this.tendered,
    change: change ?? this.change,
  );
  SaleRow copyWithCompanion(SalesCompanion data) {
    return SaleRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      discountTotal: data.discountTotal.present
          ? data.discountTotal.value
          : this.discountTotal,
      grandTotal: data.grandTotal.present
          ? data.grandTotal.value
          : this.grandTotal,
      tendered: data.tendered.present ? data.tendered.value : this.tendered,
      change: data.change.present ? data.change.value : this.change,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('tendered: $tendered, ')
          ..write('change: $change')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, discountTotal, grandTotal, tendered, change);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.discountTotal == this.discountTotal &&
          other.grandTotal == this.grandTotal &&
          other.tendered == this.tendered &&
          other.change == this.change);
}

class SalesCompanion extends UpdateCompanion<SaleRow> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> discountTotal;
  final Value<int> grandTotal;
  final Value<int> tendered;
  final Value<int> change;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.discountTotal = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.tendered = const Value.absent(),
    this.change = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required int createdAt,
    required int discountTotal,
    required int grandTotal,
    required int tendered,
    required int change,
  }) : createdAt = Value(createdAt),
       discountTotal = Value(discountTotal),
       grandTotal = Value(grandTotal),
       tendered = Value(tendered),
       change = Value(change);
  static Insertable<SaleRow> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? discountTotal,
    Expression<int>? grandTotal,
    Expression<int>? tendered,
    Expression<int>? change,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (discountTotal != null) 'discount_total': discountTotal,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (tendered != null) 'tendered': tendered,
      if (change != null) 'change': change,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<int>? createdAt,
    Value<int>? discountTotal,
    Value<int>? grandTotal,
    Value<int>? tendered,
    Value<int>? change,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      discountTotal: discountTotal ?? this.discountTotal,
      grandTotal: grandTotal ?? this.grandTotal,
      tendered: tendered ?? this.tendered,
      change: change ?? this.change,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (discountTotal.present) {
      map['discount_total'] = Variable<int>(discountTotal.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<int>(grandTotal.value);
    }
    if (tendered.present) {
      map['tendered'] = Variable<int>(tendered.value);
    }
    if (change.present) {
      map['change'] = Variable<int>(change.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('tendered: $tendered, ')
          ..write('change: $change')
          ..write(')'))
        .toString();
  }
}

class $SaleLinesTable extends SaleLines
    with TableInfo<$SaleLinesTable, SaleLineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceExclTaxMeta = const VerificationMeta(
    'unitPriceExclTax',
  );
  @override
  late final GeneratedColumn<int> unitPriceExclTax = GeneratedColumn<int>(
    'unit_price_excl_tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<int> taxRate = GeneratedColumn<int>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineDiscountTypeMeta = const VerificationMeta(
    'lineDiscountType',
  );
  @override
  late final GeneratedColumn<String> lineDiscountType = GeneratedColumn<String>(
    'line_discount_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lineDiscountValueMeta = const VerificationMeta(
    'lineDiscountValue',
  );
  @override
  late final GeneratedColumn<int> lineDiscountValue = GeneratedColumn<int>(
    'line_discount_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lineExclAfterMeta = const VerificationMeta(
    'lineExclAfter',
  );
  @override
  late final GeneratedColumn<int> lineExclAfter = GeneratedColumn<int>(
    'line_excl_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    productName,
    unitPriceExclTax,
    taxRate,
    quantity,
    lineDiscountType,
    lineDiscountValue,
    lineExclAfter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleLineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit_price_excl_tax')) {
      context.handle(
        _unitPriceExclTaxMeta,
        unitPriceExclTax.isAcceptableOrUnknown(
          data['unit_price_excl_tax']!,
          _unitPriceExclTaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceExclTaxMeta);
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    } else if (isInserting) {
      context.missing(_taxRateMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('line_discount_type')) {
      context.handle(
        _lineDiscountTypeMeta,
        lineDiscountType.isAcceptableOrUnknown(
          data['line_discount_type']!,
          _lineDiscountTypeMeta,
        ),
      );
    }
    if (data.containsKey('line_discount_value')) {
      context.handle(
        _lineDiscountValueMeta,
        lineDiscountValue.isAcceptableOrUnknown(
          data['line_discount_value']!,
          _lineDiscountValueMeta,
        ),
      );
    }
    if (data.containsKey('line_excl_after')) {
      context.handle(
        _lineExclAfterMeta,
        lineExclAfter.isAcceptableOrUnknown(
          data['line_excl_after']!,
          _lineExclAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineExclAfterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleLineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleLineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      unitPriceExclTax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_excl_tax'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_rate'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      lineDiscountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_discount_type'],
      ),
      lineDiscountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_discount_value'],
      ),
      lineExclAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_excl_after'],
      )!,
    );
  }

  @override
  $SaleLinesTable createAlias(String alias) {
    return $SaleLinesTable(attachedDatabase, alias);
  }
}

class SaleLineRow extends DataClass implements Insertable<SaleLineRow> {
  final int id;
  final int saleId;
  final String productName;
  final int unitPriceExclTax;
  final int taxRate;
  final int quantity;
  final String? lineDiscountType;
  final int? lineDiscountValue;
  final int lineExclAfter;
  const SaleLineRow({
    required this.id,
    required this.saleId,
    required this.productName,
    required this.unitPriceExclTax,
    required this.taxRate,
    required this.quantity,
    this.lineDiscountType,
    this.lineDiscountValue,
    required this.lineExclAfter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['product_name'] = Variable<String>(productName);
    map['unit_price_excl_tax'] = Variable<int>(unitPriceExclTax);
    map['tax_rate'] = Variable<int>(taxRate);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || lineDiscountType != null) {
      map['line_discount_type'] = Variable<String>(lineDiscountType);
    }
    if (!nullToAbsent || lineDiscountValue != null) {
      map['line_discount_value'] = Variable<int>(lineDiscountValue);
    }
    map['line_excl_after'] = Variable<int>(lineExclAfter);
    return map;
  }

  SaleLinesCompanion toCompanion(bool nullToAbsent) {
    return SaleLinesCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productName: Value(productName),
      unitPriceExclTax: Value(unitPriceExclTax),
      taxRate: Value(taxRate),
      quantity: Value(quantity),
      lineDiscountType: lineDiscountType == null && nullToAbsent
          ? const Value.absent()
          : Value(lineDiscountType),
      lineDiscountValue: lineDiscountValue == null && nullToAbsent
          ? const Value.absent()
          : Value(lineDiscountValue),
      lineExclAfter: Value(lineExclAfter),
    );
  }

  factory SaleLineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleLineRow(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      productName: serializer.fromJson<String>(json['productName']),
      unitPriceExclTax: serializer.fromJson<int>(json['unitPriceExclTax']),
      taxRate: serializer.fromJson<int>(json['taxRate']),
      quantity: serializer.fromJson<int>(json['quantity']),
      lineDiscountType: serializer.fromJson<String?>(json['lineDiscountType']),
      lineDiscountValue: serializer.fromJson<int?>(json['lineDiscountValue']),
      lineExclAfter: serializer.fromJson<int>(json['lineExclAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'productName': serializer.toJson<String>(productName),
      'unitPriceExclTax': serializer.toJson<int>(unitPriceExclTax),
      'taxRate': serializer.toJson<int>(taxRate),
      'quantity': serializer.toJson<int>(quantity),
      'lineDiscountType': serializer.toJson<String?>(lineDiscountType),
      'lineDiscountValue': serializer.toJson<int?>(lineDiscountValue),
      'lineExclAfter': serializer.toJson<int>(lineExclAfter),
    };
  }

  SaleLineRow copyWith({
    int? id,
    int? saleId,
    String? productName,
    int? unitPriceExclTax,
    int? taxRate,
    int? quantity,
    Value<String?> lineDiscountType = const Value.absent(),
    Value<int?> lineDiscountValue = const Value.absent(),
    int? lineExclAfter,
  }) => SaleLineRow(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    productName: productName ?? this.productName,
    unitPriceExclTax: unitPriceExclTax ?? this.unitPriceExclTax,
    taxRate: taxRate ?? this.taxRate,
    quantity: quantity ?? this.quantity,
    lineDiscountType: lineDiscountType.present
        ? lineDiscountType.value
        : this.lineDiscountType,
    lineDiscountValue: lineDiscountValue.present
        ? lineDiscountValue.value
        : this.lineDiscountValue,
    lineExclAfter: lineExclAfter ?? this.lineExclAfter,
  );
  SaleLineRow copyWithCompanion(SaleLinesCompanion data) {
    return SaleLineRow(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      unitPriceExclTax: data.unitPriceExclTax.present
          ? data.unitPriceExclTax.value
          : this.unitPriceExclTax,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      lineDiscountType: data.lineDiscountType.present
          ? data.lineDiscountType.value
          : this.lineDiscountType,
      lineDiscountValue: data.lineDiscountValue.present
          ? data.lineDiscountValue.value
          : this.lineDiscountValue,
      lineExclAfter: data.lineExclAfter.present
          ? data.lineExclAfter.value
          : this.lineExclAfter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleLineRow(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productName: $productName, ')
          ..write('unitPriceExclTax: $unitPriceExclTax, ')
          ..write('taxRate: $taxRate, ')
          ..write('quantity: $quantity, ')
          ..write('lineDiscountType: $lineDiscountType, ')
          ..write('lineDiscountValue: $lineDiscountValue, ')
          ..write('lineExclAfter: $lineExclAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    productName,
    unitPriceExclTax,
    taxRate,
    quantity,
    lineDiscountType,
    lineDiscountValue,
    lineExclAfter,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleLineRow &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productName == this.productName &&
          other.unitPriceExclTax == this.unitPriceExclTax &&
          other.taxRate == this.taxRate &&
          other.quantity == this.quantity &&
          other.lineDiscountType == this.lineDiscountType &&
          other.lineDiscountValue == this.lineDiscountValue &&
          other.lineExclAfter == this.lineExclAfter);
}

class SaleLinesCompanion extends UpdateCompanion<SaleLineRow> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<String> productName;
  final Value<int> unitPriceExclTax;
  final Value<int> taxRate;
  final Value<int> quantity;
  final Value<String?> lineDiscountType;
  final Value<int?> lineDiscountValue;
  final Value<int> lineExclAfter;
  const SaleLinesCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPriceExclTax = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.lineDiscountType = const Value.absent(),
    this.lineDiscountValue = const Value.absent(),
    this.lineExclAfter = const Value.absent(),
  });
  SaleLinesCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required String productName,
    required int unitPriceExclTax,
    required int taxRate,
    required int quantity,
    this.lineDiscountType = const Value.absent(),
    this.lineDiscountValue = const Value.absent(),
    required int lineExclAfter,
  }) : saleId = Value(saleId),
       productName = Value(productName),
       unitPriceExclTax = Value(unitPriceExclTax),
       taxRate = Value(taxRate),
       quantity = Value(quantity),
       lineExclAfter = Value(lineExclAfter);
  static Insertable<SaleLineRow> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<String>? productName,
    Expression<int>? unitPriceExclTax,
    Expression<int>? taxRate,
    Expression<int>? quantity,
    Expression<String>? lineDiscountType,
    Expression<int>? lineDiscountValue,
    Expression<int>? lineExclAfter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productName != null) 'product_name': productName,
      if (unitPriceExclTax != null) 'unit_price_excl_tax': unitPriceExclTax,
      if (taxRate != null) 'tax_rate': taxRate,
      if (quantity != null) 'quantity': quantity,
      if (lineDiscountType != null) 'line_discount_type': lineDiscountType,
      if (lineDiscountValue != null) 'line_discount_value': lineDiscountValue,
      if (lineExclAfter != null) 'line_excl_after': lineExclAfter,
    });
  }

  SaleLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<String>? productName,
    Value<int>? unitPriceExclTax,
    Value<int>? taxRate,
    Value<int>? quantity,
    Value<String?>? lineDiscountType,
    Value<int?>? lineDiscountValue,
    Value<int>? lineExclAfter,
  }) {
    return SaleLinesCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productName: productName ?? this.productName,
      unitPriceExclTax: unitPriceExclTax ?? this.unitPriceExclTax,
      taxRate: taxRate ?? this.taxRate,
      quantity: quantity ?? this.quantity,
      lineDiscountType: lineDiscountType ?? this.lineDiscountType,
      lineDiscountValue: lineDiscountValue ?? this.lineDiscountValue,
      lineExclAfter: lineExclAfter ?? this.lineExclAfter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPriceExclTax.present) {
      map['unit_price_excl_tax'] = Variable<int>(unitPriceExclTax.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<int>(taxRate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (lineDiscountType.present) {
      map['line_discount_type'] = Variable<String>(lineDiscountType.value);
    }
    if (lineDiscountValue.present) {
      map['line_discount_value'] = Variable<int>(lineDiscountValue.value);
    }
    if (lineExclAfter.present) {
      map['line_excl_after'] = Variable<int>(lineExclAfter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleLinesCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productName: $productName, ')
          ..write('unitPriceExclTax: $unitPriceExclTax, ')
          ..write('taxRate: $taxRate, ')
          ..write('quantity: $quantity, ')
          ..write('lineDiscountType: $lineDiscountType, ')
          ..write('lineDiscountValue: $lineDiscountValue, ')
          ..write('lineExclAfter: $lineExclAfter')
          ..write(')'))
        .toString();
  }
}

class $SaleTaxGroupsTable extends SaleTaxGroups
    with TableInfo<$SaleTaxGroupsTable, SaleTaxGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleTaxGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id)',
    ),
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<int> rate = GeneratedColumn<int>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxableExclTaxMeta = const VerificationMeta(
    'taxableExclTax',
  );
  @override
  late final GeneratedColumn<int> taxableExclTax = GeneratedColumn<int>(
    'taxable_excl_tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<int> tax = GeneratedColumn<int>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, saleId, rate, taxableExclTax, tax];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_tax_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleTaxGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('taxable_excl_tax')) {
      context.handle(
        _taxableExclTaxMeta,
        taxableExclTax.isAcceptableOrUnknown(
          data['taxable_excl_tax']!,
          _taxableExclTaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taxableExclTaxMeta);
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleTaxGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleTaxGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate'],
      )!,
      taxableExclTax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}taxable_excl_tax'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax'],
      )!,
    );
  }

  @override
  $SaleTaxGroupsTable createAlias(String alias) {
    return $SaleTaxGroupsTable(attachedDatabase, alias);
  }
}

class SaleTaxGroupRow extends DataClass implements Insertable<SaleTaxGroupRow> {
  final int id;
  final int saleId;
  final int rate;
  final int taxableExclTax;
  final int tax;
  const SaleTaxGroupRow({
    required this.id,
    required this.saleId,
    required this.rate,
    required this.taxableExclTax,
    required this.tax,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['rate'] = Variable<int>(rate);
    map['taxable_excl_tax'] = Variable<int>(taxableExclTax);
    map['tax'] = Variable<int>(tax);
    return map;
  }

  SaleTaxGroupsCompanion toCompanion(bool nullToAbsent) {
    return SaleTaxGroupsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      rate: Value(rate),
      taxableExclTax: Value(taxableExclTax),
      tax: Value(tax),
    );
  }

  factory SaleTaxGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleTaxGroupRow(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      rate: serializer.fromJson<int>(json['rate']),
      taxableExclTax: serializer.fromJson<int>(json['taxableExclTax']),
      tax: serializer.fromJson<int>(json['tax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'rate': serializer.toJson<int>(rate),
      'taxableExclTax': serializer.toJson<int>(taxableExclTax),
      'tax': serializer.toJson<int>(tax),
    };
  }

  SaleTaxGroupRow copyWith({
    int? id,
    int? saleId,
    int? rate,
    int? taxableExclTax,
    int? tax,
  }) => SaleTaxGroupRow(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    rate: rate ?? this.rate,
    taxableExclTax: taxableExclTax ?? this.taxableExclTax,
    tax: tax ?? this.tax,
  );
  SaleTaxGroupRow copyWithCompanion(SaleTaxGroupsCompanion data) {
    return SaleTaxGroupRow(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      rate: data.rate.present ? data.rate.value : this.rate,
      taxableExclTax: data.taxableExclTax.present
          ? data.taxableExclTax.value
          : this.taxableExclTax,
      tax: data.tax.present ? data.tax.value : this.tax,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleTaxGroupRow(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('rate: $rate, ')
          ..write('taxableExclTax: $taxableExclTax, ')
          ..write('tax: $tax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, saleId, rate, taxableExclTax, tax);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleTaxGroupRow &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.rate == this.rate &&
          other.taxableExclTax == this.taxableExclTax &&
          other.tax == this.tax);
}

class SaleTaxGroupsCompanion extends UpdateCompanion<SaleTaxGroupRow> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int> rate;
  final Value<int> taxableExclTax;
  final Value<int> tax;
  const SaleTaxGroupsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.rate = const Value.absent(),
    this.taxableExclTax = const Value.absent(),
    this.tax = const Value.absent(),
  });
  SaleTaxGroupsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required int rate,
    required int taxableExclTax,
    required int tax,
  }) : saleId = Value(saleId),
       rate = Value(rate),
       taxableExclTax = Value(taxableExclTax),
       tax = Value(tax);
  static Insertable<SaleTaxGroupRow> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? rate,
    Expression<int>? taxableExclTax,
    Expression<int>? tax,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (rate != null) 'rate': rate,
      if (taxableExclTax != null) 'taxable_excl_tax': taxableExclTax,
      if (tax != null) 'tax': tax,
    });
  }

  SaleTaxGroupsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<int>? rate,
    Value<int>? taxableExclTax,
    Value<int>? tax,
  }) {
    return SaleTaxGroupsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      rate: rate ?? this.rate,
      taxableExclTax: taxableExclTax ?? this.taxableExclTax,
      tax: tax ?? this.tax,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (rate.present) {
      map['rate'] = Variable<int>(rate.value);
    }
    if (taxableExclTax.present) {
      map['taxable_excl_tax'] = Variable<int>(taxableExclTax.value);
    }
    if (tax.present) {
      map['tax'] = Variable<int>(tax.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleTaxGroupsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('rate: $rate, ')
          ..write('taxableExclTax: $taxableExclTax, ')
          ..write('tax: $tax')
          ..write(')'))
        .toString();
  }
}

class $DraftCartLinesTable extends DraftCartLines
    with TableInfo<$DraftCartLinesTable, DraftCartLineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftCartLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineDiscountTypeMeta = const VerificationMeta(
    'lineDiscountType',
  );
  @override
  late final GeneratedColumn<String> lineDiscountType = GeneratedColumn<String>(
    'line_discount_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lineDiscountValueMeta = const VerificationMeta(
    'lineDiscountValue',
  );
  @override
  late final GeneratedColumn<int> lineDiscountValue = GeneratedColumn<int>(
    'line_discount_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    quantity,
    lineDiscountType,
    lineDiscountValue,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_cart_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftCartLineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('line_discount_type')) {
      context.handle(
        _lineDiscountTypeMeta,
        lineDiscountType.isAcceptableOrUnknown(
          data['line_discount_type']!,
          _lineDiscountTypeMeta,
        ),
      );
    }
    if (data.containsKey('line_discount_value')) {
      context.handle(
        _lineDiscountValueMeta,
        lineDiscountValue.isAcceptableOrUnknown(
          data['line_discount_value']!,
          _lineDiscountValueMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftCartLineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftCartLineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      lineDiscountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_discount_type'],
      ),
      lineDiscountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_discount_value'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $DraftCartLinesTable createAlias(String alias) {
    return $DraftCartLinesTable(attachedDatabase, alias);
  }
}

class DraftCartLineRow extends DataClass
    implements Insertable<DraftCartLineRow> {
  final int id;
  final int productId;
  final int quantity;
  final String? lineDiscountType;
  final int? lineDiscountValue;
  final int sortOrder;
  const DraftCartLineRow({
    required this.id,
    required this.productId,
    required this.quantity,
    this.lineDiscountType,
    this.lineDiscountValue,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || lineDiscountType != null) {
      map['line_discount_type'] = Variable<String>(lineDiscountType);
    }
    if (!nullToAbsent || lineDiscountValue != null) {
      map['line_discount_value'] = Variable<int>(lineDiscountValue);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  DraftCartLinesCompanion toCompanion(bool nullToAbsent) {
    return DraftCartLinesCompanion(
      id: Value(id),
      productId: Value(productId),
      quantity: Value(quantity),
      lineDiscountType: lineDiscountType == null && nullToAbsent
          ? const Value.absent()
          : Value(lineDiscountType),
      lineDiscountValue: lineDiscountValue == null && nullToAbsent
          ? const Value.absent()
          : Value(lineDiscountValue),
      sortOrder: Value(sortOrder),
    );
  }

  factory DraftCartLineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftCartLineRow(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      lineDiscountType: serializer.fromJson<String?>(json['lineDiscountType']),
      lineDiscountValue: serializer.fromJson<int?>(json['lineDiscountValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'lineDiscountType': serializer.toJson<String?>(lineDiscountType),
      'lineDiscountValue': serializer.toJson<int?>(lineDiscountValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  DraftCartLineRow copyWith({
    int? id,
    int? productId,
    int? quantity,
    Value<String?> lineDiscountType = const Value.absent(),
    Value<int?> lineDiscountValue = const Value.absent(),
    int? sortOrder,
  }) => DraftCartLineRow(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    lineDiscountType: lineDiscountType.present
        ? lineDiscountType.value
        : this.lineDiscountType,
    lineDiscountValue: lineDiscountValue.present
        ? lineDiscountValue.value
        : this.lineDiscountValue,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  DraftCartLineRow copyWithCompanion(DraftCartLinesCompanion data) {
    return DraftCartLineRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      lineDiscountType: data.lineDiscountType.present
          ? data.lineDiscountType.value
          : this.lineDiscountType,
      lineDiscountValue: data.lineDiscountValue.present
          ? data.lineDiscountValue.value
          : this.lineDiscountValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftCartLineRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('lineDiscountType: $lineDiscountType, ')
          ..write('lineDiscountValue: $lineDiscountValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    quantity,
    lineDiscountType,
    lineDiscountValue,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftCartLineRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.lineDiscountType == this.lineDiscountType &&
          other.lineDiscountValue == this.lineDiscountValue &&
          other.sortOrder == this.sortOrder);
}

class DraftCartLinesCompanion extends UpdateCompanion<DraftCartLineRow> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<String?> lineDiscountType;
  final Value<int?> lineDiscountValue;
  final Value<int> sortOrder;
  const DraftCartLinesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.lineDiscountType = const Value.absent(),
    this.lineDiscountValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  DraftCartLinesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int quantity,
    this.lineDiscountType = const Value.absent(),
    this.lineDiscountValue = const Value.absent(),
    required int sortOrder,
  }) : productId = Value(productId),
       quantity = Value(quantity),
       sortOrder = Value(sortOrder);
  static Insertable<DraftCartLineRow> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<String>? lineDiscountType,
    Expression<int>? lineDiscountValue,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (lineDiscountType != null) 'line_discount_type': lineDiscountType,
      if (lineDiscountValue != null) 'line_discount_value': lineDiscountValue,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  DraftCartLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? quantity,
    Value<String?>? lineDiscountType,
    Value<int?>? lineDiscountValue,
    Value<int>? sortOrder,
  }) {
    return DraftCartLinesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      lineDiscountType: lineDiscountType ?? this.lineDiscountType,
      lineDiscountValue: lineDiscountValue ?? this.lineDiscountValue,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (lineDiscountType.present) {
      map['line_discount_type'] = Variable<String>(lineDiscountType.value);
    }
    if (lineDiscountValue.present) {
      map['line_discount_value'] = Variable<int>(lineDiscountValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftCartLinesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('lineDiscountType: $lineDiscountType, ')
          ..write('lineDiscountValue: $lineDiscountValue, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $DraftMetaTable extends DraftMeta
    with TableInfo<$DraftMetaTable, DraftMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderDiscountTypeMeta = const VerificationMeta(
    'orderDiscountType',
  );
  @override
  late final GeneratedColumn<String> orderDiscountType =
      GeneratedColumn<String>(
        'order_discount_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _orderDiscountValueMeta =
      const VerificationMeta('orderDiscountValue');
  @override
  late final GeneratedColumn<int> orderDiscountValue = GeneratedColumn<int>(
    'order_discount_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderDiscountType,
    orderDiscountValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<DraftMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_discount_type')) {
      context.handle(
        _orderDiscountTypeMeta,
        orderDiscountType.isAcceptableOrUnknown(
          data['order_discount_type']!,
          _orderDiscountTypeMeta,
        ),
      );
    }
    if (data.containsKey('order_discount_value')) {
      context.handle(
        _orderDiscountValueMeta,
        orderDiscountValue.isAcceptableOrUnknown(
          data['order_discount_value']!,
          _orderDiscountValueMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftMetaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderDiscountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_discount_type'],
      ),
      orderDiscountValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_discount_value'],
      ),
    );
  }

  @override
  $DraftMetaTable createAlias(String alias) {
    return $DraftMetaTable(attachedDatabase, alias);
  }
}

class DraftMetaRow extends DataClass implements Insertable<DraftMetaRow> {
  final int id;
  final String? orderDiscountType;
  final int? orderDiscountValue;
  const DraftMetaRow({
    required this.id,
    this.orderDiscountType,
    this.orderDiscountValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || orderDiscountType != null) {
      map['order_discount_type'] = Variable<String>(orderDiscountType);
    }
    if (!nullToAbsent || orderDiscountValue != null) {
      map['order_discount_value'] = Variable<int>(orderDiscountValue);
    }
    return map;
  }

  DraftMetaCompanion toCompanion(bool nullToAbsent) {
    return DraftMetaCompanion(
      id: Value(id),
      orderDiscountType: orderDiscountType == null && nullToAbsent
          ? const Value.absent()
          : Value(orderDiscountType),
      orderDiscountValue: orderDiscountValue == null && nullToAbsent
          ? const Value.absent()
          : Value(orderDiscountValue),
    );
  }

  factory DraftMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftMetaRow(
      id: serializer.fromJson<int>(json['id']),
      orderDiscountType: serializer.fromJson<String?>(
        json['orderDiscountType'],
      ),
      orderDiscountValue: serializer.fromJson<int?>(json['orderDiscountValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderDiscountType': serializer.toJson<String?>(orderDiscountType),
      'orderDiscountValue': serializer.toJson<int?>(orderDiscountValue),
    };
  }

  DraftMetaRow copyWith({
    int? id,
    Value<String?> orderDiscountType = const Value.absent(),
    Value<int?> orderDiscountValue = const Value.absent(),
  }) => DraftMetaRow(
    id: id ?? this.id,
    orderDiscountType: orderDiscountType.present
        ? orderDiscountType.value
        : this.orderDiscountType,
    orderDiscountValue: orderDiscountValue.present
        ? orderDiscountValue.value
        : this.orderDiscountValue,
  );
  DraftMetaRow copyWithCompanion(DraftMetaCompanion data) {
    return DraftMetaRow(
      id: data.id.present ? data.id.value : this.id,
      orderDiscountType: data.orderDiscountType.present
          ? data.orderDiscountType.value
          : this.orderDiscountType,
      orderDiscountValue: data.orderDiscountValue.present
          ? data.orderDiscountValue.value
          : this.orderDiscountValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DraftMetaRow(')
          ..write('id: $id, ')
          ..write('orderDiscountType: $orderDiscountType, ')
          ..write('orderDiscountValue: $orderDiscountValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderDiscountType, orderDiscountValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftMetaRow &&
          other.id == this.id &&
          other.orderDiscountType == this.orderDiscountType &&
          other.orderDiscountValue == this.orderDiscountValue);
}

class DraftMetaCompanion extends UpdateCompanion<DraftMetaRow> {
  final Value<int> id;
  final Value<String?> orderDiscountType;
  final Value<int?> orderDiscountValue;
  const DraftMetaCompanion({
    this.id = const Value.absent(),
    this.orderDiscountType = const Value.absent(),
    this.orderDiscountValue = const Value.absent(),
  });
  DraftMetaCompanion.insert({
    this.id = const Value.absent(),
    this.orderDiscountType = const Value.absent(),
    this.orderDiscountValue = const Value.absent(),
  });
  static Insertable<DraftMetaRow> custom({
    Expression<int>? id,
    Expression<String>? orderDiscountType,
    Expression<int>? orderDiscountValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderDiscountType != null) 'order_discount_type': orderDiscountType,
      if (orderDiscountValue != null)
        'order_discount_value': orderDiscountValue,
    });
  }

  DraftMetaCompanion copyWith({
    Value<int>? id,
    Value<String?>? orderDiscountType,
    Value<int?>? orderDiscountValue,
  }) {
    return DraftMetaCompanion(
      id: id ?? this.id,
      orderDiscountType: orderDiscountType ?? this.orderDiscountType,
      orderDiscountValue: orderDiscountValue ?? this.orderDiscountValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderDiscountType.present) {
      map['order_discount_type'] = Variable<String>(orderDiscountType.value);
    }
    if (orderDiscountValue.present) {
      map['order_discount_value'] = Variable<int>(orderDiscountValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftMetaCompanion(')
          ..write('id: $id, ')
          ..write('orderDiscountType: $orderDiscountType, ')
          ..write('orderDiscountValue: $orderDiscountValue')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleLinesTable saleLines = $SaleLinesTable(this);
  late final $SaleTaxGroupsTable saleTaxGroups = $SaleTaxGroupsTable(this);
  late final $DraftCartLinesTable draftCartLines = $DraftCartLinesTable(this);
  late final $DraftMetaTable draftMeta = $DraftMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    sales,
    saleLines,
    saleTaxGroups,
    draftCartLines,
    draftMeta,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      required int unitPriceExclTax,
      required int taxRate,
      required String category,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> unitPriceExclTax,
      Value<int> taxRate,
      Value<String> category,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> unitPriceExclTax = const Value.absent(),
                Value<int> taxRate = const Value.absent(),
                Value<String> category = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                unitPriceExclTax: unitPriceExclTax,
                taxRate: taxRate,
                category: category,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int unitPriceExclTax,
                required int taxRate,
                required String category,
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                unitPriceExclTax: unitPriceExclTax,
                taxRate: taxRate,
                category: category,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required int createdAt,
      required int discountTotal,
      required int grandTotal,
      required int tendered,
      required int change,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<int> createdAt,
      Value<int> discountTotal,
      Value<int> grandTotal,
      Value<int> tendered,
      Value<int> change,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, SaleRow> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SaleLinesTable, List<SaleLineRow>>
  _saleLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleLines,
    aliasName: $_aliasNameGenerator(db.sales.id, db.saleLines.saleId),
  );

  $$SaleLinesTableProcessedTableManager get saleLinesRefs {
    final manager = $$SaleLinesTableTableManager(
      $_db,
      $_db.saleLines,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleTaxGroupsTable, List<SaleTaxGroupRow>>
  _saleTaxGroupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleTaxGroups,
    aliasName: $_aliasNameGenerator(db.sales.id, db.saleTaxGroups.saleId),
  );

  $$SaleTaxGroupsTableProcessedTableManager get saleTaxGroupsRefs {
    final manager = $$SaleTaxGroupsTableTableManager(
      $_db,
      $_db.saleTaxGroups,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleTaxGroupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tendered => $composableBuilder(
    column: $table.tendered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> saleLinesRefs(
    Expression<bool> Function($$SaleLinesTableFilterComposer f) f,
  ) {
    final $$SaleLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleLines,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleLinesTableFilterComposer(
            $db: $db,
            $table: $db.saleLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleTaxGroupsRefs(
    Expression<bool> Function($$SaleTaxGroupsTableFilterComposer f) f,
  ) {
    final $$SaleTaxGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleTaxGroups,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleTaxGroupsTableFilterComposer(
            $db: $db,
            $table: $db.saleTaxGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tendered => $composableBuilder(
    column: $table.tendered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get change => $composableBuilder(
    column: $table.change,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tendered =>
      $composableBuilder(column: $table.tendered, builder: (column) => column);

  GeneratedColumn<int> get change =>
      $composableBuilder(column: $table.change, builder: (column) => column);

  Expression<T> saleLinesRefs<T extends Object>(
    Expression<T> Function($$SaleLinesTableAnnotationComposer a) f,
  ) {
    final $$SaleLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleLines,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.saleLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleTaxGroupsRefs<T extends Object>(
    Expression<T> Function($$SaleTaxGroupsTableAnnotationComposer a) f,
  ) {
    final $$SaleTaxGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleTaxGroups,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleTaxGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleTaxGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          SaleRow,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (SaleRow, $$SalesTableReferences),
          SaleRow,
          PrefetchHooks Function({bool saleLinesRefs, bool saleTaxGroupsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> discountTotal = const Value.absent(),
                Value<int> grandTotal = const Value.absent(),
                Value<int> tendered = const Value.absent(),
                Value<int> change = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                createdAt: createdAt,
                discountTotal: discountTotal,
                grandTotal: grandTotal,
                tendered: tendered,
                change: change,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int createdAt,
                required int discountTotal,
                required int grandTotal,
                required int tendered,
                required int change,
              }) => SalesCompanion.insert(
                id: id,
                createdAt: createdAt,
                discountTotal: discountTotal,
                grandTotal: grandTotal,
                tendered: tendered,
                change: change,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({saleLinesRefs = false, saleTaxGroupsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (saleLinesRefs) db.saleLines,
                    if (saleTaxGroupsRefs) db.saleTaxGroups,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (saleLinesRefs)
                        await $_getPrefetchedData<
                          SaleRow,
                          $SalesTable,
                          SaleLineRow
                        >(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences
                              ._saleLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SalesTableReferences(
                                db,
                                table,
                                p0,
                              ).saleLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleTaxGroupsRefs)
                        await $_getPrefetchedData<
                          SaleRow,
                          $SalesTable,
                          SaleTaxGroupRow
                        >(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences
                              ._saleTaxGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SalesTableReferences(
                                db,
                                table,
                                p0,
                              ).saleTaxGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      SaleRow,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (SaleRow, $$SalesTableReferences),
      SaleRow,
      PrefetchHooks Function({bool saleLinesRefs, bool saleTaxGroupsRefs})
    >;
typedef $$SaleLinesTableCreateCompanionBuilder =
    SaleLinesCompanion Function({
      Value<int> id,
      required int saleId,
      required String productName,
      required int unitPriceExclTax,
      required int taxRate,
      required int quantity,
      Value<String?> lineDiscountType,
      Value<int?> lineDiscountValue,
      required int lineExclAfter,
    });
typedef $$SaleLinesTableUpdateCompanionBuilder =
    SaleLinesCompanion Function({
      Value<int> id,
      Value<int> saleId,
      Value<String> productName,
      Value<int> unitPriceExclTax,
      Value<int> taxRate,
      Value<int> quantity,
      Value<String?> lineDiscountType,
      Value<int?> lineDiscountValue,
      Value<int> lineExclAfter,
    });

final class $$SaleLinesTableReferences
    extends BaseReferences<_$AppDatabase, $SaleLinesTable, SaleLineRow> {
  $$SaleLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias(
    $_aliasNameGenerator(db.saleLines.saleId, db.sales.id),
  );

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleLinesTableFilterComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineExclAfter => $composableBuilder(
    column: $table.lineExclAfter,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineExclAfter => $composableBuilder(
    column: $table.lineExclAfter,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleLinesTable> {
  $$SaleLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitPriceExclTax => $composableBuilder(
    column: $table.unitPriceExclTax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineExclAfter => $composableBuilder(
    column: $table.lineExclAfter,
    builder: (column) => column,
  );

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleLinesTable,
          SaleLineRow,
          $$SaleLinesTableFilterComposer,
          $$SaleLinesTableOrderingComposer,
          $$SaleLinesTableAnnotationComposer,
          $$SaleLinesTableCreateCompanionBuilder,
          $$SaleLinesTableUpdateCompanionBuilder,
          (SaleLineRow, $$SaleLinesTableReferences),
          SaleLineRow,
          PrefetchHooks Function({bool saleId})
        > {
  $$SaleLinesTableTableManager(_$AppDatabase db, $SaleLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> unitPriceExclTax = const Value.absent(),
                Value<int> taxRate = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> lineDiscountType = const Value.absent(),
                Value<int?> lineDiscountValue = const Value.absent(),
                Value<int> lineExclAfter = const Value.absent(),
              }) => SaleLinesCompanion(
                id: id,
                saleId: saleId,
                productName: productName,
                unitPriceExclTax: unitPriceExclTax,
                taxRate: taxRate,
                quantity: quantity,
                lineDiscountType: lineDiscountType,
                lineDiscountValue: lineDiscountValue,
                lineExclAfter: lineExclAfter,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required String productName,
                required int unitPriceExclTax,
                required int taxRate,
                required int quantity,
                Value<String?> lineDiscountType = const Value.absent(),
                Value<int?> lineDiscountValue = const Value.absent(),
                required int lineExclAfter,
              }) => SaleLinesCompanion.insert(
                id: id,
                saleId: saleId,
                productName: productName,
                unitPriceExclTax: unitPriceExclTax,
                taxRate: taxRate,
                quantity: quantity,
                lineDiscountType: lineDiscountType,
                lineDiscountValue: lineDiscountValue,
                lineExclAfter: lineExclAfter,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SaleLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleLinesTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleLinesTableReferences
                                    ._saleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SaleLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleLinesTable,
      SaleLineRow,
      $$SaleLinesTableFilterComposer,
      $$SaleLinesTableOrderingComposer,
      $$SaleLinesTableAnnotationComposer,
      $$SaleLinesTableCreateCompanionBuilder,
      $$SaleLinesTableUpdateCompanionBuilder,
      (SaleLineRow, $$SaleLinesTableReferences),
      SaleLineRow,
      PrefetchHooks Function({bool saleId})
    >;
typedef $$SaleTaxGroupsTableCreateCompanionBuilder =
    SaleTaxGroupsCompanion Function({
      Value<int> id,
      required int saleId,
      required int rate,
      required int taxableExclTax,
      required int tax,
    });
typedef $$SaleTaxGroupsTableUpdateCompanionBuilder =
    SaleTaxGroupsCompanion Function({
      Value<int> id,
      Value<int> saleId,
      Value<int> rate,
      Value<int> taxableExclTax,
      Value<int> tax,
    });

final class $$SaleTaxGroupsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SaleTaxGroupsTable, SaleTaxGroupRow> {
  $$SaleTaxGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias(
    $_aliasNameGenerator(db.saleTaxGroups.saleId, db.sales.id),
  );

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleTaxGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleTaxGroupsTable> {
  $$SaleTaxGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxableExclTax => $composableBuilder(
    column: $table.taxableExclTax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleTaxGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleTaxGroupsTable> {
  $$SaleTaxGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxableExclTax => $composableBuilder(
    column: $table.taxableExclTax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleTaxGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleTaxGroupsTable> {
  $$SaleTaxGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<int> get taxableExclTax => $composableBuilder(
    column: $table.taxableExclTax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleTaxGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleTaxGroupsTable,
          SaleTaxGroupRow,
          $$SaleTaxGroupsTableFilterComposer,
          $$SaleTaxGroupsTableOrderingComposer,
          $$SaleTaxGroupsTableAnnotationComposer,
          $$SaleTaxGroupsTableCreateCompanionBuilder,
          $$SaleTaxGroupsTableUpdateCompanionBuilder,
          (SaleTaxGroupRow, $$SaleTaxGroupsTableReferences),
          SaleTaxGroupRow,
          PrefetchHooks Function({bool saleId})
        > {
  $$SaleTaxGroupsTableTableManager(_$AppDatabase db, $SaleTaxGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleTaxGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleTaxGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleTaxGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int> rate = const Value.absent(),
                Value<int> taxableExclTax = const Value.absent(),
                Value<int> tax = const Value.absent(),
              }) => SaleTaxGroupsCompanion(
                id: id,
                saleId: saleId,
                rate: rate,
                taxableExclTax: taxableExclTax,
                tax: tax,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required int rate,
                required int taxableExclTax,
                required int tax,
              }) => SaleTaxGroupsCompanion.insert(
                id: id,
                saleId: saleId,
                rate: rate,
                taxableExclTax: taxableExclTax,
                tax: tax,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SaleTaxGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleTaxGroupsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleTaxGroupsTableReferences
                                    ._saleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SaleTaxGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleTaxGroupsTable,
      SaleTaxGroupRow,
      $$SaleTaxGroupsTableFilterComposer,
      $$SaleTaxGroupsTableOrderingComposer,
      $$SaleTaxGroupsTableAnnotationComposer,
      $$SaleTaxGroupsTableCreateCompanionBuilder,
      $$SaleTaxGroupsTableUpdateCompanionBuilder,
      (SaleTaxGroupRow, $$SaleTaxGroupsTableReferences),
      SaleTaxGroupRow,
      PrefetchHooks Function({bool saleId})
    >;
typedef $$DraftCartLinesTableCreateCompanionBuilder =
    DraftCartLinesCompanion Function({
      Value<int> id,
      required int productId,
      required int quantity,
      Value<String?> lineDiscountType,
      Value<int?> lineDiscountValue,
      required int sortOrder,
    });
typedef $$DraftCartLinesTableUpdateCompanionBuilder =
    DraftCartLinesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> quantity,
      Value<String?> lineDiscountType,
      Value<int?> lineDiscountValue,
      Value<int> sortOrder,
    });

class $$DraftCartLinesTableFilterComposer
    extends Composer<_$AppDatabase, $DraftCartLinesTable> {
  $$DraftCartLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DraftCartLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftCartLinesTable> {
  $$DraftCartLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DraftCartLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftCartLinesTable> {
  $$DraftCartLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get lineDiscountType => $composableBuilder(
    column: $table.lineDiscountType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineDiscountValue => $composableBuilder(
    column: $table.lineDiscountValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$DraftCartLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftCartLinesTable,
          DraftCartLineRow,
          $$DraftCartLinesTableFilterComposer,
          $$DraftCartLinesTableOrderingComposer,
          $$DraftCartLinesTableAnnotationComposer,
          $$DraftCartLinesTableCreateCompanionBuilder,
          $$DraftCartLinesTableUpdateCompanionBuilder,
          (
            DraftCartLineRow,
            BaseReferences<
              _$AppDatabase,
              $DraftCartLinesTable,
              DraftCartLineRow
            >,
          ),
          DraftCartLineRow,
          PrefetchHooks Function()
        > {
  $$DraftCartLinesTableTableManager(
    _$AppDatabase db,
    $DraftCartLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftCartLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftCartLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftCartLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> lineDiscountType = const Value.absent(),
                Value<int?> lineDiscountValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => DraftCartLinesCompanion(
                id: id,
                productId: productId,
                quantity: quantity,
                lineDiscountType: lineDiscountType,
                lineDiscountValue: lineDiscountValue,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int quantity,
                Value<String?> lineDiscountType = const Value.absent(),
                Value<int?> lineDiscountValue = const Value.absent(),
                required int sortOrder,
              }) => DraftCartLinesCompanion.insert(
                id: id,
                productId: productId,
                quantity: quantity,
                lineDiscountType: lineDiscountType,
                lineDiscountValue: lineDiscountValue,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DraftCartLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftCartLinesTable,
      DraftCartLineRow,
      $$DraftCartLinesTableFilterComposer,
      $$DraftCartLinesTableOrderingComposer,
      $$DraftCartLinesTableAnnotationComposer,
      $$DraftCartLinesTableCreateCompanionBuilder,
      $$DraftCartLinesTableUpdateCompanionBuilder,
      (
        DraftCartLineRow,
        BaseReferences<_$AppDatabase, $DraftCartLinesTable, DraftCartLineRow>,
      ),
      DraftCartLineRow,
      PrefetchHooks Function()
    >;
typedef $$DraftMetaTableCreateCompanionBuilder =
    DraftMetaCompanion Function({
      Value<int> id,
      Value<String?> orderDiscountType,
      Value<int?> orderDiscountValue,
    });
typedef $$DraftMetaTableUpdateCompanionBuilder =
    DraftMetaCompanion Function({
      Value<int> id,
      Value<String?> orderDiscountType,
      Value<int?> orderDiscountValue,
    });

class $$DraftMetaTableFilterComposer
    extends Composer<_$AppDatabase, $DraftMetaTable> {
  $$DraftMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderDiscountType => $composableBuilder(
    column: $table.orderDiscountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderDiscountValue => $composableBuilder(
    column: $table.orderDiscountValue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DraftMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $DraftMetaTable> {
  $$DraftMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderDiscountType => $composableBuilder(
    column: $table.orderDiscountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderDiscountValue => $composableBuilder(
    column: $table.orderDiscountValue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DraftMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $DraftMetaTable> {
  $$DraftMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderDiscountType => $composableBuilder(
    column: $table.orderDiscountType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderDiscountValue => $composableBuilder(
    column: $table.orderDiscountValue,
    builder: (column) => column,
  );
}

class $$DraftMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DraftMetaTable,
          DraftMetaRow,
          $$DraftMetaTableFilterComposer,
          $$DraftMetaTableOrderingComposer,
          $$DraftMetaTableAnnotationComposer,
          $$DraftMetaTableCreateCompanionBuilder,
          $$DraftMetaTableUpdateCompanionBuilder,
          (
            DraftMetaRow,
            BaseReferences<_$AppDatabase, $DraftMetaTable, DraftMetaRow>,
          ),
          DraftMetaRow,
          PrefetchHooks Function()
        > {
  $$DraftMetaTableTableManager(_$AppDatabase db, $DraftMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DraftMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DraftMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DraftMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> orderDiscountType = const Value.absent(),
                Value<int?> orderDiscountValue = const Value.absent(),
              }) => DraftMetaCompanion(
                id: id,
                orderDiscountType: orderDiscountType,
                orderDiscountValue: orderDiscountValue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> orderDiscountType = const Value.absent(),
                Value<int?> orderDiscountValue = const Value.absent(),
              }) => DraftMetaCompanion.insert(
                id: id,
                orderDiscountType: orderDiscountType,
                orderDiscountValue: orderDiscountValue,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DraftMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DraftMetaTable,
      DraftMetaRow,
      $$DraftMetaTableFilterComposer,
      $$DraftMetaTableOrderingComposer,
      $$DraftMetaTableAnnotationComposer,
      $$DraftMetaTableCreateCompanionBuilder,
      $$DraftMetaTableUpdateCompanionBuilder,
      (
        DraftMetaRow,
        BaseReferences<_$AppDatabase, $DraftMetaTable, DraftMetaRow>,
      ),
      DraftMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleLinesTableTableManager get saleLines =>
      $$SaleLinesTableTableManager(_db, _db.saleLines);
  $$SaleTaxGroupsTableTableManager get saleTaxGroups =>
      $$SaleTaxGroupsTableTableManager(_db, _db.saleTaxGroups);
  $$DraftCartLinesTableTableManager get draftCartLines =>
      $$DraftCartLinesTableTableManager(_db, _db.draftCartLines);
  $$DraftMetaTableTableManager get draftMeta =>
      $$DraftMetaTableTableManager(_db, _db.draftMeta);
}
