import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/User.dart';

class ProfileInfoContent extends StatelessWidget {
  User? user;

  ProfileInfoContent(this.user);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _imageBackground(context),
        Column(
          children: [
            _imageProfile(context),
            Spacer(),
            _cardProgfileInfo(context),
          ],
        ),
      ],
    );
  }

  Widget _cardProgfileInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
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
            ListTile(
              title: Text('${user?.name ?? ''} ${user?.lastname ?? ''}'),
              subtitle: Text('Nombre de usuario'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text(user?.email ?? ''),
              subtitle: Text('Correo electrónico'),
              leading: Icon(Icons.email),
            ),
            ListTile(
              title: Text(user?.phone ?? ''),
              subtitle: Text('Telefono'),
              leading: Icon(Icons.phone),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'profile/update',
                    arguments: user,
                  );
                },
                child: Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageProfile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      width: 150,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipOval(
          child: user?.image != null
              ? FadeInImage.assetNetwork(
                  image: user!.image!,
                  fit: BoxFit.cover,
                  placeholder: 'assets/img/user_image.png',
                  fadeInDuration: const Duration(seconds: 1),
                )
              : // Local image
                Image.asset('assets/img/user_image.png', fit: BoxFit.cover),
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
