import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:store_app/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:store_app/src/presentation/pages/profile/update/ProfileUpdateContent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  ProfileUpdateBloc? _bloc;
  User? _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(ProfileUpdateInitEvent(user: _user));
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ProfileUpdateBloc>(context);
    _user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (context, state) {
          final responseState = state.response;

          if (responseState is Success) {
            User user = responseState.data as User;
            _bloc?.add(ProfileUpdateUpdateUserSession(user: user));

            Fluttertoast.showToast(
              msg: "Perfil actualizado correctamente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );

            Future.delayed(Duration(seconds: 1), () {
              context.read<ProfileInfoBloc>().add(ProfileInfoGetUser());
            });
          } else if (responseState is Error) {
            Fluttertoast.showToast(
              msg: responseState.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          builder: (context, state) {
            final responseState = state.response;
            if (responseState is Loading) {
              return Stack(
                children: [
                  ProfileUpdateContent(_user, _bloc, state),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            return ProfileUpdateContent(_user, _bloc, state);
          },
        ),
      ),
    );
  }
}
