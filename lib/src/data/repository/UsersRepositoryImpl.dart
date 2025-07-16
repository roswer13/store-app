import 'dart:io';

import 'package:store_app/src/data/dataSource/remote/services/UsersService.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/repository/UsersRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersService _usersService;

  UsersRepositoryImpl(this._usersService);

  @override
  Future<Resource<User>> update(int id, User user, File? image) {
    return _usersService.update(id, user, image);
  }
}
