import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

abstract class AuthRepository {
  Future<AuthResponse?> getUserSession();

  Future<bool> logout();

  Future<void> saveUserSession(AuthResponse authResponse);

  Future<Resource<AuthResponse>> login(String email, String password);

  Future<Resource<User>> register(User user);
}
