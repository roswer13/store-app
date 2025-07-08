import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';

class SaveUserSessionUseCase {
  final AuthRepository authRepository;

  SaveUserSessionUseCase(this.authRepository);

  Future<void> run(AuthResponse authResponse) async {
    await authRepository.saveUserSession(authResponse);
  }
}
