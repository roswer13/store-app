import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/AdminCategoryCreateContent.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/create/bloc/AdminCategoryCreateState.dart';

class AdminCategoryCreatePage extends StatefulWidget {
  const AdminCategoryCreatePage({super.key});

  @override
  State<AdminCategoryCreatePage> createState() =>
      _AdminCategoryCreatePageState();
}

class _AdminCategoryCreatePageState extends State<AdminCategoryCreatePage> {
  AdminCategoryCreateBloc? _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminCategoryCreateBloc>(context);

    return Scaffold(
      body: BlocListener<AdminCategoryCreateBloc, AdminCategoryCreateState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Success) {
            _bloc?.add(AdminCategoryCreateResetForm());
            Fluttertoast.showToast(
              msg: "Category created successfully",
              toastLength: Toast.LENGTH_SHORT,
            );
          } else if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        child: BlocBuilder<AdminCategoryCreateBloc, AdminCategoryCreateState>(
          builder: (context, state) {
            return AdminCategoryCreateContent(_bloc, state);
          },
        ),
      ),
    );
  }
}
