import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/presentation/pages/profile/update/ProfileUpdateContent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  ProfileUpdateBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ProfileUpdateBloc>(context);
    User? user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      body: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
        builder: (context, state) {
          return ProfileUpdateContent(user, _bloc, state);
        },
      ),
    );
  }
}
