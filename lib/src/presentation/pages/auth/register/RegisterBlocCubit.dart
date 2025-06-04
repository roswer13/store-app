import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocState.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  RegisterBlocCubit() : super(RegisterInitial());

  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;

  Stream<bool> get isFormValid => Rx.combineLatest6(
    nameStream,
    lastnameStream,
    emailStream,
    phoneStream,
    passwordStream,
    confirmPasswordStream,
    (
      String name,
      String lastname,
      String email,
      String phone,
      String password,
      String confirmPassword,
    ) => true,
  );

  void register() {
    print('Email: ${_emailController.value}');
    print('Name: ${_nameController.value}');
    print('Lastname: ${_lastnameController.value}');
    print('Phone: ${_phoneController.value}');
    print('Password: ${_passwordController.value}');
    print('Confirm Password: ${_confirmPasswordController.value}');
  }

  void setName(String name) {
    if (name.isNotEmpty && name.length < 3) {
      _nameController.sink.addError('Name must be at least 3 characters long');
    } else {
      _nameController.sink.add(name);
    }
  }

  void setLastname(String lastname) {
    if (lastname.isNotEmpty && lastname.length < 3) {
      _lastnameController.sink.addError(
        'Lastname must be at least 3 characters long',
      );
    } else {
      _lastnameController.sink.add(lastname);
    }
  }

  void setEmail(String email) {
    if (email.isNotEmpty && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _emailController.sink.addError('Invalid email format');
    } else {
      _emailController.sink.add(email);
    }
  }

  void setPhone(String phone) {
    if (phone.isNotEmpty && phone.length < 10) {
      _phoneController.sink.addError('Phone must be at least 10 digits long');
    } else {
      _phoneController.sink.add(phone);
    }
  }

  void setPassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink.addError(
        'Password must be at least 6 characters long',
      );
    } else {
      _passwordController.sink.add(password);
    }
  }

  void setConfirmPassword(String confirmPassword) {
    if (confirmPassword.isNotEmpty &&
        confirmPassword != _passwordController.value) {
      _confirmPasswordController.sink.addError('Passwords do not match');
    } else {
      _confirmPasswordController.sink.add(confirmPassword);
    }
  }

  void dispose() {
    setName('');
    setLastname('');
    setEmail('');
    setPhone('');
    setPassword('');
    setConfirmPassword('');
  }
}
