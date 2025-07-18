import 'package:flutter/material.dart';

class AdminCategoryListPage extends StatefulWidget {
  const AdminCategoryListPage({super.key});

  @override
  State<AdminCategoryListPage> createState() => _AdminCategoryListPageState();
}

class _AdminCategoryListPageState extends State<AdminCategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'admin/category/create');
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Center(child: Text('List of Categories will be displayed here.')),
    );
  }
}
