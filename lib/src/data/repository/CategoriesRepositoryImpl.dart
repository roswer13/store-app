import 'dart:io';

import 'package:store_app/src/data/dataSource/remote/services/CategoriesService.dart';
import 'package:store_app/src/domain/models/Category.dart';
import 'package:store_app/src/domain/repository/CategoriesRepository.dart';
import 'package:store_app/src/domain/utils/Resource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesService categoriesService;

  CategoriesRepositoryImpl(this.categoriesService);

  @override
  Future<Resource<Category>> create(Category category, File file) {
    return categoriesService.create(category, file);
  }
}
