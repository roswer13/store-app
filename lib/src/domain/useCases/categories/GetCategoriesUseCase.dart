import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/repository/CategoriesRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class GetCategoriesUseCase {
  CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  Future<Resource<List<Category>>> run() async {
    return await categoriesRepository.getCategories();
  }
}
