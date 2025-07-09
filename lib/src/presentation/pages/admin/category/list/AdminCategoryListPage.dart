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
      body: Center(child: Text('This is the Category List Page')),
    );
  }
}
