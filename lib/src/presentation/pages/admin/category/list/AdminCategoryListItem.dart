import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/Category.dart';

class AdminCategoryListItem extends StatelessWidget {
  Category? category;

  AdminCategoryListItem(this.category);

  @override
  Widget build(BuildContext context) {
    return category != null
        ? ListTile(
            title: Text(category!.name),
            subtitle: Text(category!.description),
            contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
            leading: Container(
              width: 70,
              child: FadeInImage.assetNetwork(
                image: category!.image!,
                fit: BoxFit.cover,
                placeholder: 'assets/img/user_image.png',
                fadeInDuration: const Duration(seconds: 1),
              ),
            ),
            trailing: Wrap(
              direction: Axis.horizontal,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'admin/category/update',
                      arguments: category,
                    );
                  },
                ),
                IconButton(icon: Icon(Icons.delete), onPressed: () {}),
              ],
            ),
          )
        : Container();
  }
}
