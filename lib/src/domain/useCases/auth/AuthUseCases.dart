import 'package:store_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/RegisterUseCase.dart';

class AuthUseCases {
  LoginUseCase login;
  RegisterUseCase register;

  AuthUseCases({required this.login, required this.register});
}
