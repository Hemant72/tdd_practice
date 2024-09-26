import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tdd_practice/src/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tdd_practice/src/auth/data/repositiory/auth_repositiory_impl.dart';
import 'package:tdd_practice/src/auth/domain/repository/auth_repositiory.dart';
import 'package:tdd_practice/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_practice/src/auth/domain/usecases/get_user.dart';
import 'package:tdd_practice/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_practice/src/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthCubit(createUser: sl(), getUser: sl()))
    ..registerFactory(() => AuthBloc(createUser: sl(), getUser: sl()))
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton<AuthRepositiory>(() => AuthRepositioryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDatasourceImpl(sl()))
    ..registerLazySingleton(() => Dio());
}
