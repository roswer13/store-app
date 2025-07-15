import 'package:flutter/material.dart';

import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
import 'package:store_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';
import 'package:store_app/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:store_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:store_app/src/presentation/widgets/DefaultTextField.dart';

class ProfileUpdateContent extends StatelessWidget {
  ProfileUpdateBloc? bloc;
  ProfileUpdateState state;
  User? user;

  ProfileUpdateContent(this.user, this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _imageBackground(context),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _imageProfile(context),
                // Spacer(),
                _cardProfileInfo(context),
              ],
            ),
          ),
        ),
        DefaultIconBack(left: 5, top: 50),
      ],
    );
  }

  Widget _cardProfileInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.44,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _textUpdateInfo(),
            _textFieldName(context),
            _textFieldLastname(context),
            _textFieldPhone(context),
            _fabSubmit(),
          ],
        ),
      ),
    );
  }

  Widget _fabSubmit() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 10, top: 20),
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Icon(Icons.check, color: Colors.white),
      ),
    );
  }

  Widget _textUpdateInfo() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 25, left: 35, bottom: 10),
      child: Text('Actualiza tu informacion', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _textFieldName(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: DefaultTextfield(
        label: 'Nombre',
        icon: Icons.person,
        //errorText: snapshot.error?.toString(),
        initialValue: user?.name ?? '',
        color: Colors.black,
        onChanged: (text) {
          bloc?.add(ProfileUpdateChangeName(name: BlocFormItem(value: text)));
        },
        validator: (value) {
          return state.name.error;
        },
      ),
    );
  }

  Widget _textFieldLastname(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: DefaultTextfield(
        label: 'Apellido',
        icon: Icons.person_outline,
        initialValue: user?.lastname ?? '',
        color: Colors.black,
        //errorText: snapshot.error?.toString(),
        onChanged: (text) {
          bloc?.add(
            ProfileUpdateChangeLastname(lastname: BlocFormItem(value: text)),
          );
        },
        validator: (value) {
          return state.lastname.error;
        },
      ),
    );
  }

  Widget _textFieldPhone(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: DefaultTextfield(
        label: 'Telefono',
        icon: Icons.phone,
        initialValue: user?.phone ?? '',
        color: Colors.black,
        //errorText: snapshot.error?.toString(),
        onChanged: (text) {
          bloc?.add(ProfileUpdateChangePhone(phone: BlocFormItem(value: text)));
        },
        validator: (value) {
          return state.phone.error;
        },
      ),
    );
  }

  Widget _imageProfile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //bloc?.add(ProfileUpdatePickImage());
        //bloc?.add(ProfileUpdateTakePhoto());
        SelectOptionImageDialog(
          context,
          () => bloc?.add(ProfileUpdatePickImage()),
          () => bloc?.add(ProfileUpdateTakePhoto()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 100),
        width: 150,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipOval(
            child: state.image != null
                ? Image.file(state.image!, fit: BoxFit.cover)
                : FadeInImage.assetNetwork(
                    image:
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
                    fit: BoxFit.cover,
                    placeholder: 'assets/img/user.png',
                    fadeInDuration: const Duration(seconds: 1),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _imageBackground(BuildContext context) {
    return Image.asset(
      'assets/img/background3.jpg',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      colorBlendMode: BlendMode.darken,
    );
  }
}
