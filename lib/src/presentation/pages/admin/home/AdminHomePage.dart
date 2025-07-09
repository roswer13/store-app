import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/AdminCategoryListPage.dart';

import 'package:store_app/src/presentation/pages/admin/home/bloc/AdminHmeState.dart';
import 'package:store_app/src/presentation/pages/admin/home/bloc/AdminHomeBloc.dart';
import 'package:store_app/src/presentation/pages/admin/home/bloc/AdminHomeEvent.dart';
import 'package:store_app/src/presentation/pages/admin/product/list/AdminProductListPage.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  AdminHomeBloc? _bloc;

  List<Widget> pagesList = <Widget>[
    const AdminCategoryListPage(),
    const AdminProductListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminHomeBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      drawer: BlocBuilder<AdminHomeBloc, AdminHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Text(
                    'Admin Menu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('Categorias'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    _bloc?.add(AdminChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Productos'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    _bloc?.add(AdminChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Cerrar Sesión'),
                  onTap: () {
                    _bloc?.add(AdminLogout());
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: BlocBuilder<AdminHomeBloc, AdminHomeState>(
        builder: (context, state) {
          return pagesList[state.pageIndex];
        },
      ),
    );
  }
}
