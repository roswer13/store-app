import 'package:flutter/material.dart';

class AdminProductListPage extends StatefulWidget {
  const AdminProductListPage({super.key});

  @override
  State<AdminProductListPage> createState() => _AdminProductListPageState();
}

class _AdminProductListPageState extends State<AdminProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('This is the Product List Page')));
  }
}
