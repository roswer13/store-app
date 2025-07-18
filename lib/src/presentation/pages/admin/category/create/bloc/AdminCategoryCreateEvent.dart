import 'package:equatable/equatable.dart';
import 'package:store_app/src/presentation/utils/BlocFormItem.dart';

abstract class AdminCategoryCreateEvent extends Equatable {
  const AdminCategoryCreateEvent();

  @override
  List<Object> get props => [];
}

class AdminCategoryCreateInitEvent extends AdminCategoryCreateEvent {
  const AdminCategoryCreateInitEvent();

  @override
  List<Object> get props => [];
}

class AdminCategoryCreateNameChanged extends AdminCategoryCreateEvent {
  final BlocFormItem name;

  const AdminCategoryCreateNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class AdminCategoryCreateDescriptionChanged extends AdminCategoryCreateEvent {
  final BlocFormItem description;

  const AdminCategoryCreateDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class AdminCategoryCreateFormSubmitted extends AdminCategoryCreateEvent {
  const AdminCategoryCreateFormSubmitted();
}

class AdminCategoryCreateResetForm extends AdminCategoryCreateEvent {
  const AdminCategoryCreateResetForm();
}

class AdminCategoryCreatePickImage extends AdminCategoryCreateEvent {
  const AdminCategoryCreatePickImage();
}

class AdminCategoryCreateTakePhoto extends AdminCategoryCreateEvent {
  const AdminCategoryCreateTakePhoto();
}
