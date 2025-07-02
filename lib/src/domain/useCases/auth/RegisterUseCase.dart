import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';

class RegisterUseCase {
  AuthRepository repostory;

  RegisterUseCase(this.repostory);

  run(User user) async {
    return await repostory.register(user);
  }
}
