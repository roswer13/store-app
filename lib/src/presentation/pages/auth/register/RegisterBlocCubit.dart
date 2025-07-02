import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_app/src/domain/models/User.dart';
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/auth/register/RegisterBlocState.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  AuthUseCases authUseCases;

  RegisterBlocCubit(this.authUseCases) : super(RegisterInitial());

  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _responseController = BehaviorSubject<Resource>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;
  Stream<Resource> get responseStream => _responseController.stream;

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

  toUser() => User(
    name: _nameController.value,
    lastname: _lastnameController.value,
    email: _emailController.value,
    phone: _phoneController.value,
    password: _passwordController.value,
  );

  void register() async {
    _responseController.add(Loading());

    Resource<User> response = await authUseCases.register.run(toUser());

    _responseController.add(response);

    Future.delayed(const Duration(seconds: 1), () {
      _responseController.add(Initial());
    });
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
