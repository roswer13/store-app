import 'package:equatable/equatable.dart';

abstract class AdminCategoryListEvent extends Equatable {
  const AdminCategoryListEvent();

  @override
  List<Object?> get props => [];
}

class GetCategories extends AdminCategoryListEvent {
  const GetCategories();
}

class DeleteCategory extends AdminCategoryListEvent {
  final int categoryId;

  const DeleteCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
