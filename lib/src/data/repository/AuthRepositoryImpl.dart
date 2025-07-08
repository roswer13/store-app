import 'package:store_app/src/data/dataSource/local/SharedPref.dart';
import 'package:store_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;
  SharedPref sharedPref;

  AuthRepositoryImpl(this.authService, this.sharedPref);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  @override
  Future<Resource<User>> register(User user) {
    return authService.register(user);
  }

  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharedPref.read('user_session');
    if (data == null) {
      return null;
    }
    return AuthResponse.fromJson(data);
  }

  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    await sharedPref.save('user_session', authResponse.toJson());
  }
}
