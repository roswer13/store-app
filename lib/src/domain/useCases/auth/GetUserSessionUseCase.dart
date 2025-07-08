import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase {
  final AuthRepository authRepository;

  GetUserSessionUseCase(this.authRepository);

  Future<AuthResponse?> run() async {
    return await authRepository.getUserSession();
  }
}
