// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:store_app/src/data/dataSource/local/SharedPref.dart' as _i174;
import 'package:store_app/src/data/dataSource/remote/services/AuthService.dart'
    as _i1064;
import 'package:store_app/src/di/AppModule.dart' as _i121;
import 'package:store_app/src/domain/repository/AuthRepository.dart' as _i317;
import 'package:store_app/src/domain/useCases/auth/AuthUseCases.dart' as _i390;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i1064.AuthService>(() => appModule.authService);
    gh.factory<_i174.SharedPref>(() => appModule.sharedPref);
    gh.factory<_i317.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i390.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i121.AppModule {}
