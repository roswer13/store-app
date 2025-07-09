import 'package:equatable/equatable.dart';

abstract class AdminHomeEvent extends Equatable {
  const AdminHomeEvent();
}

class AdminChangeDrawerPage extends AdminHomeEvent {
  final int pageIndex;

  const AdminChangeDrawerPage({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];

  @override
  String toString() => 'AdminchangeDrawerPage(pageIndex: $pageIndex)';
}

class AdminLogout extends AdminHomeEvent {
  const AdminLogout();

  @override
  List<Object?> get props => [];
}
