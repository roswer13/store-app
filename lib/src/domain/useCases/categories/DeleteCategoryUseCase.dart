import 'package:store_app/src/domain/repository/CategoriesRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<Resource<bool>> run(int id) async {
    return await _repository.delete(id);
  }
}
