import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/blocProviders.dart';
import 'package:store_app/injection.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/AdminCategoryListPage.dart';

import 'package:store_app/src/presentation/pages/admin/home/AdminHomePage.dart';
import 'package:store_app/src/presentation/pages/admin/product/list/AdminProductListPage.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterPage.dart';
import 'package:store_app/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:store_app/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:store_app/src/presentation/pages/profile/update/ProfileUpdatePage.dart';
import 'package:store_app/src/presentation/pages/roles/RolesPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: 'login',
        routes: {
          'login': (context) => const LoginPage(),
          'register': (context) => const RegisterPage(),
          'roles': (context) => const RolesPage(),
          'profile/info': (context) => const ProfileInfoPage(),
          'profile/update': (context) => const ProfileUpdatePage(),
          'admin/home': (context) => const AdminHomePage(),
          'admin/products': (context) => const AdminProductListPage(),
          'admin/categories': (context) => const AdminCategoryListPage(),
          'client/home': (context) => const ClientHomePage(),
        },
      ),
    );
  }
}
