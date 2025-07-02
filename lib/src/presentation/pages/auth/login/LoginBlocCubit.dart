import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';

import 'package:store_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/login/LoginBlocState.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {
  AuthUseCases authUseCases;

  LoginBlocCubit(this.authUseCases) : super(LoginInitial());

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _responseController = BehaviorSubject<Resource>();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

  void setEmail(String email) {
    if (email.isNotEmpty && email.length < 5) {
      _emailController.sink.addError('Email cannot be empty');
      return;
    }
    _emailController.sink.add(email);
  }

  void setPassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink.addError(
        'Password must be at least 6 characters',
      );
      return;
    }
    _passwordController.sink.add(password);
  }

  Stream<bool> get isFormValid =>
      Rx.combineLatest2(emailStream, passwordStream, (email, password) => true);

  void dispose() {
    setEmail('');
    setPassword('');
  }

  void login() async {
    final email = _emailController.valueOrNull;
    final password = _passwordController.valueOrNull;

    if (email != null && password != null) {
      _responseController.add(Loading());
      // Perform login logic here
      print('Logging in with email: $email and password: $password');
      // Emit a success state or handle errors as needed
      // Add delay example
      Resource response = await authUseCases.login.run(email, password);
      _responseController.add(response);
      Future.delayed(const Duration(seconds: 1), () {
        _responseController.add(Initial());
      });
      print('Login successful: ${response}');
    } else {
      print('Email or password is not set');
    }
  }
}
