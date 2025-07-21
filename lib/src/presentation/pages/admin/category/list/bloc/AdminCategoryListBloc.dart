import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_app/src/domain/useCases/categories/CategoriesUseCases.dart';
import 'package:store_app/src/domain/utils/Resource.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListEvent.dart';
import 'package:store_app/src/presentation/pages/admin/category/list/bloc/AdminCategoryListState.dart';

class AdminCategoryListBloc
    extends Bloc<AdminCategoryListEvent, AdminCategoryListState> {
  final CategoriesUseCases categoriesUseCases;

  AdminCategoryListBloc({required this.categoriesUseCases})
    : super(const AdminCategoryListState()) {
    on<GetCategories>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<AdminCategoryListState> emit,
  ) async {
    emit(state.copyWith(response: Loading()));
    try {
      final categories = await categoriesUseCases.getCategories.run();
      emit(state.copyWith(response: categories));
    } catch (e) {
      emit(state.copyWith(response: Error(e.toString())));
    }
  }
}
