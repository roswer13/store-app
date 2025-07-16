import 'dart:io';

import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/repository/UsersRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class UpdateUserUseCase {
  final UsersRepository _usersRepository;

  UpdateUserUseCase(this._usersRepository);

  Future<Resource> run(int id, User user, File? image) async {
    return _usersRepository.update(id, user, image);
  }
}
