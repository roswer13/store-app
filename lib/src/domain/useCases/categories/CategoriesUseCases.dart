import 'package:store_app/src/domain/useCases/categories/CreateCategoryUseCase.dart';
import 'package:store_app/src/domain/useCases/categories/GetCategoriesUseCase.dart';

class CategoriesUseCases {
  CreateCategoryUseCase create;
  GetCategoriesUseCase getCategories;

  CategoriesUseCases({required this.create, required this.getCategories});
}
