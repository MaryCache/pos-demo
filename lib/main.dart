import 'package:flutter/material.dart';
import 'data/cart_repository.dart';
import 'data/connection_web.dart';
import 'data/database.dart';
import 'data/product_repository.dart';
import 'data/sales_repository.dart';
import 'data/seed.dart';
import 'state/register_model.dart';
import 'ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase(await openWebExecutor());
  final productRepo = ProductRepository(db);
  final salesRepo = SalesRepository(db);
  final cartRepo = CartRepository(db);

  await seedIfEmpty(productRepo); // 初回のみサンプル投入

  final register = RegisterModel(cartRepo, salesRepo);
  await register.init(); // 退避カート復元

  runApp(PosApp(
    productRepo: productRepo,
    salesRepo: salesRepo,
    register: register,
  ));
}
