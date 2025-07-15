import 'package:equatable/equatable.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

abstract class ProfileUpdateEvent extends Equatable {
  const ProfileUpdateEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateInitEvent extends ProfileUpdateEvent {
  const ProfileUpdateInitEvent();
}

class ProfileUpdateChangeName extends ProfileUpdateEvent {
  final BlocFormItem name;

  const ProfileUpdateChangeName({required this.name});

  @override
  List<Object?> get props => [name];
}

class ProfileUpdateChangeLastname extends ProfileUpdateEvent {
  final BlocFormItem lastname;

  const ProfileUpdateChangeLastname({required this.lastname});

  @override
  List<Object?> get props => [lastname];
}

class ProfileUpdateChangePhone extends ProfileUpdateEvent {
  final BlocFormItem phone;

  const ProfileUpdateChangePhone({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class ProfileUpdateFormSubmit extends ProfileUpdateEvent {
  const ProfileUpdateFormSubmit();
}
