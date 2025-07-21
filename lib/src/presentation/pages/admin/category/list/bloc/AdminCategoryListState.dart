import 'package:equatable/equatable.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class AdminCategoryListState extends Equatable {
  final Resource? response;

  const AdminCategoryListState({this.response});

  AdminCategoryListState copyWith({Resource? response}) {
    return AdminCategoryListState(response: response ?? this.response);
  }

  @override
  List<Object?> get props => [response];
}
