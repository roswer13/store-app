import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/src/presentation/pages/roles/RolesItem.dart';

import 'package:store_app/src/presentation/pages/roles/bloc/RolesBloc.dart';
import 'package:store_app/src/presentation/pages/roles/bloc/RolesState.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, state) {
          if (state.roles == null || state.roles!.isEmpty) {
            return Center(child: Text('No roles available'));
          }

          return Container(
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.roles!.length,
              itemBuilder: (context, index) {
                final role = state.roles![index];
                if (role == null) {
                  return SizedBox.shrink(); // Skip null roles
                }
                return RolesItem(role);
              },
            ),
          );
        },
      ),
    );
  }
}
