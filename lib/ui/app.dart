import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_repository.dart';
import '../data/sales_repository.dart';
import '../state/catalog_model.dart';
import '../state/register_model.dart';
import 'pos_screen.dart';

/// アプリのルート。Repository/Model を Provider で配線する。
class PosApp extends StatelessWidget {
  final ProductRepository productRepo;
  final SalesRepository salesRepo;
  final RegisterModel register;

  const PosApp({
    super.key,
    required this.productRepo,
    required this.salesRepo,
    required this.register,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: salesRepo),
        ChangeNotifierProvider(create: (_) => CatalogModel(productRepo)),
        ChangeNotifierProvider.value(value: register),
      ],
      child: MaterialApp(
        title: 'POS デモ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B7F79)),
          useMaterial3: true,
        ),
        home: const PosScreen(),
      ),
    );
  }
}
