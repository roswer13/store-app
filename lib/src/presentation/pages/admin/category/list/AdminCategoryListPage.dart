import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/AdminCategoryListItem.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListState.dart';

class AdminCategoryListPage extends StatefulWidget {
  const AdminCategoryListPage({super.key});

  @override
  State<AdminCategoryListPage> createState() => _AdminCategoryListPageState();
}

class _AdminCategoryListPageState extends State<AdminCategoryListPage> {
  AdminCategoryListBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(GetCategories());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminCategoryListBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'admin/category/create');
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<AdminCategoryListBloc, AdminCategoryListState>(
        listener: (context, state) {
          final responseState = state.response;

          if (responseState is Success) {
            print(
              'Response state: $responseState, data type: ${responseState.data.runtimeType}',
            );
            if (responseState.data is bool) {
              _bloc?.add(GetCategories());
            }
          }
          if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<AdminCategoryListBloc, AdminCategoryListState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Success) {
              List<Category> categories = responseState.data as List<Category>;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return AdminCategoryListItem(categories[index], _bloc);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class Cateory {}
