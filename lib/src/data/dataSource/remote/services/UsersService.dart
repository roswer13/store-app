import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import 'package:store_app/src/data/api/ApiConfig.dart';
import 'package:store_app/src/data/dataSource/local/SharedPref.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/utils/ListToString.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

import 'package:http/http.dart' as http;

class UsersService {
  SharedPref sharedPref;

  UsersService(this.sharedPref);

  Future<Resource<User>> update(int id, User user, File? image) async {
    try {
      print('Updating user with ID: $id');
      Uri uri = Uri.http(Apiconfig.apiCommerce, '/users/upload/$id');
      String token = "";
      final userSession = await sharedPref.read('user_session');

      if (userSession != null) {
        AuthResponse authResponse = AuthResponse.fromJson(userSession);
        token = authResponse.token;
      }

      final request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = token;

      if (image != null) {
        request.files.add(
          http.MultipartFile(
            'file',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            filename: basename(image.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }

      request.fields['name'] = user.name;
      request.fields['lastname'] = user.lastname;
      request.fields['phone'] = user.phone;

      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        User user = User.fromJson(data);
        return Success(user);
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
