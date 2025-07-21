import 'dart:io';

import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/repository/CategoriesRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class UpdateCategoryUseCase {
  final CategoriesRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<Resource<Category>> run(int id, Category category, File? file) async {
    return await _repository.update(id, category, file);
  }
}
