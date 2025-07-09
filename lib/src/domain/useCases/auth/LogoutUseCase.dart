import 'package:store_app/src/domain/repository/AuthRepository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<bool> run() {
    return authRepository.logout();
  }
}
