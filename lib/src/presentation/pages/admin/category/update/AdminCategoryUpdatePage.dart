import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/src/domain/models/Category.dart';

import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/AdminCategoryUpdateContent.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/update/bloc/AdminCategoryUpdateState.dart';

class AdminCategoryUpdatePage extends StatefulWidget {
  const AdminCategoryUpdatePage({super.key});

  @override
  State<AdminCategoryUpdatePage> createState() =>
      _AdminCategoryUpdatePageState();
}

class _AdminCategoryUpdatePageState extends State<AdminCategoryUpdatePage> {
  Category? category;
  AdminCategoryUpdateBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(AdminCategoryUpdateInitEvent(category: category));
    });
  }

  @override
  void dispose() {
    _bloc?.add(AdminCategoryUpdateResetForm());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminCategoryUpdateBloc>(context);
    category = ModalRoute.of(context)?.settings.arguments as Category;

    return Scaffold(
      body: BlocListener<AdminCategoryUpdateBloc, AdminCategoryUpdateState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Success) {
            context.read<AdminCategoryListBloc>().add(GetCategories());
            Fluttertoast.showToast(
              msg: "Category updated successfully",
              toastLength: Toast.LENGTH_SHORT,
            );
          } else if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<AdminCategoryUpdateBloc, AdminCategoryUpdateState>(
          builder: (context, state) {
            return AdminCategoryUpdateContent(_bloc, state, category);
          },
        ),
      ),
    );
  }
}
