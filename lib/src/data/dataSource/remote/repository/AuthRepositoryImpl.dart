import 'package:store_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  @override
  Future<Resource<User>> register(User user) {
    return authService.register(user);
  }
}
