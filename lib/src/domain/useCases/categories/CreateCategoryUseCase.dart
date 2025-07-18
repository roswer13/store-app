import 'dart:io';

import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/repository/CategoriesRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class CreateCategoryUseCase {
  CategoriesRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<Resource<Category>> run(Category category, File file) async {
    return await repository.create(category, file);
  }
}
