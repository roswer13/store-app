import 'package:injectable/injectable.dart';

import 'package:store_app/src/data/dataSource/local/SharedPref.dart';
import 'package:store_app/src/data/dataSource/remote/services/UsersService.dart';
import 'package:store_app/src/data/repository/AuthRepositoryImpl.dart';
import 'package:store_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:store_app/src/data/repository/UsersRepositoryImpl.dart';
import 'package:store_app/src/domain/repository/AuthRepository.dart';
import 'package:store_app/src/domain/repository/UsersRepository.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:store_app/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:store_app/src/domain/useCases/users/UpdateUserUsesCase.dart';
import 'package:store_app/src/domain/useCases/users/UsersUseCases.dart';

@module
abstract class AppModule {
  @injectable
  AuthService get authService => AuthService();

  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharedPref);

  @injectable
  UsersService get usersService => UsersService(sharedPref);

  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  @injectable
  UsersUseCases get usersUseCases =>
      UsersUseCases(updateUserUseCase: UpdateUserUseCase(usersRepository));
}
