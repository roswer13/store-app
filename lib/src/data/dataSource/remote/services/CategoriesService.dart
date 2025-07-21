import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:store_app/src/data/api/ApiConfig.dart';
import 'package:store_app/src/data/dataSource/local/SharedPref.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/utils/ListToString.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

import 'package:http/http.dart' as http;

class CategoriesService {
  SharedPref sharedPref;

  CategoriesService(this.sharedPref);

  Future<Resource<Category>> create(Category category, File file) async {
    try {
      print('Creating category with ID: ${category.toJson()}');
      Uri uri = Uri.http(Apiconfig.apiCommerce, '/categories');

      String token = "";
      final userSession = await sharedPref.read('user_session');

      if (userSession != null) {
        AuthResponse authResponse = AuthResponse.fromJson(userSession);
        token = authResponse.token;
      }

      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token;

      print('File path: ${file.path}');
      if (file != null) {
        request.files.add(
          http.MultipartFile(
            'file',
            http.ByteStream(file.openRead().cast()),
            await file.length(),
            filename: basename(file.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }

      print('Request fields: ${request.fields}');
      request.fields['name'] = category.name;
      request.fields['description'] = category.description;

      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Category category = Category.fromJson(data);
        print('Category created successfully: ${category.toJson()}');
        return Success(category);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      // Handle error
      print('Error during create category: $e');
      return Error('An error occurred during create category: ${e.toString()}');
    }
  }

  Future<Resource<List<Category>>> getCategories() async {
    try {
      print('Getting categories');
      Uri uri = Uri.http(Apiconfig.apiCommerce, 'categories/getCategories');
      String token = "";
      final userSession = await sharedPref.read('user_session');

      if (userSession != null) {
        AuthResponse authResponse = AuthResponse.fromJson(userSession);
        token = authResponse.token;
      }

      final request = http.MultipartRequest('GET', uri);
      request.headers['Authorization'] = token;

      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Category> categories = Category.fromJsonList(data);
        return Success(categories);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      // Handle error
      print('Error during update: $e');
      return Error('An error occurred during update: ${e.toString()}');
    }
  }
}
