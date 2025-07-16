import 'dart:io';

import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

abstract class UsersRepository {
  Future<Resource<User>> update(int id, User user, File? image);
}
