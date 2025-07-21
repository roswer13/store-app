import 'package:equatable/equatable.dart';

import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

abstract class AdminCategoryUpdateEvent extends Equatable {
  const AdminCategoryUpdateEvent();

  @override
  List<Object?> get props => [];
}

class AdminCategoryUpdateInitEvent extends AdminCategoryUpdateEvent {
  final Category? category;

  const AdminCategoryUpdateInitEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class AdminCategoryUpdateNameChanged extends AdminCategoryUpdateEvent {
  final BlocFormItem name;

  const AdminCategoryUpdateNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class AdminCategoryUpdateDescriptionChanged extends AdminCategoryUpdateEvent {
  final BlocFormItem description;

  const AdminCategoryUpdateDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class AdminCategoryUpdateFormSubmitted extends AdminCategoryUpdateEvent {
  const AdminCategoryUpdateFormSubmitted();
}

class AdminCategoryUpdatePickImage extends AdminCategoryUpdateEvent {
  const AdminCategoryUpdatePickImage();
}

class AdminCategoryUpdateTakePhoto extends AdminCategoryUpdateEvent {
  const AdminCategoryUpdateTakePhoto();
}
