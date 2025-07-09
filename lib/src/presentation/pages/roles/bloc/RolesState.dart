import 'package:equatable/equatable.dart';

import 'package:store_app/src/domain/models/Role.dart';

class RolesState extends Equatable {
  final List<Role?>? roles;

  RolesState({this.roles});

  RolesState copyWith({List<Role?>? roles}) {
    return RolesState(roles: roles ?? this.roles);
  }

  @override
  List<Object?> get props => [roles];
}
