import 'package:equatable/equatable.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  final BlocFormItem name;

  const RegisterNameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}

class RegisterLastnameChanged extends RegisterEvent {
  final BlocFormItem lastname;

  const RegisterLastnameChanged({required this.lastname});

  @override
  List<Object?> get props => [lastname];
}

class RegisterEmailChanged extends RegisterEvent {
  final BlocFormItem email;

  const RegisterEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterPhoneChanged extends RegisterEvent {
  final BlocFormItem phone;

  const RegisterPhoneChanged({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class RegisterPasswordChanged extends RegisterEvent {
  final BlocFormItem password;

  const RegisterPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final BlocFormItem confirmPassword;

  const RegisterConfirmPasswordChanged({required this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterFormReset extends RegisterEvent {
  const RegisterFormReset();
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class RegisterInitialEvent extends RegisterEvent {
  const RegisterInitialEvent();
}
