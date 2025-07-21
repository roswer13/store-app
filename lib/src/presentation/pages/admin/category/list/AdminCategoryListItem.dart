import 'package:flutter/material.dart';
import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListBloc.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';

class AdminCategoryListItem extends StatelessWidget {
  AdminCategoryListBloc? bloc;
  Category? category;

  AdminCategoryListItem(this.category, this.bloc);

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
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Category'),
                          content: Text(
                            'Are you sure you want to delete this category?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (category?.id == null) return;
                                Navigator.of(context).pop();
                                bloc?.add(DeleteCategory(category!.id!));
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        : Container();
  }
}
