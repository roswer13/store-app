import 'package:injectable/injectable.dart';
import 'package:store_app/src/data/dataSource/remote/repository/AuthRepositoryImpl.dart';
import 'package:store_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/RegisterUseCase.dart';

@module
abstract class AppModule {
  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
  );
}
