import 'package:store_app/src/domain/repository/AuthRepository.dart';

class LoginUseCase {
  AuthRepository repository;

  LoginUseCase(this.repository);

  run(String email, String password) async {
    return await repository.login(email, password);
  }
}
