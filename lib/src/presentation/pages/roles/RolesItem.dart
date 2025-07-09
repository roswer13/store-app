import 'package:flutter/material.dart';

import 'package:store_app/src/domain/models/Role.dart';

class RolesItem extends StatelessWidget {
  final Role role;

  const RolesItem(this.role);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          role.route,
          (route) => false,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 15),
            height: 100,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.png'),
              image: NetworkImage(role.image),
              fit: BoxFit.contain,
              fadeInDuration: Duration(seconds: 1),
            ),
          ),
          Text(
            role.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
