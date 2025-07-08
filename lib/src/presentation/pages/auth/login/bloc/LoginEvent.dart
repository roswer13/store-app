import 'package:equatable/equatable.dart';
import 'package:store_app/src/domain/models/AuthResponse.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  const LoginInitialEvent();

  @override
  List<Object?> get props => [];
}

class LoginFormReset extends LoginEvent {
  const LoginFormReset();
}

class LoginSaveUserSession extends LoginEvent {
  final AuthResponse response;

  const LoginSaveUserSession({required this.response});

  @override
  List<Object?> get props => [response];
}

class EmailChanged extends LoginEvent {
  final BlocFormItem email;

  const EmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final BlocFormItem password;

  const PasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
