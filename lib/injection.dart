import 'package:get_it/get_it.dart';
import 'package:vcare_app/feature/auth/business_logic/login_cubit/login_cubit.dart';
import 'package:vcare_app/feature/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:vcare_app/feature/home_screen/business_logic/home_cubit/home_cubit.dart';
import 'package:vcare_app/feature/home_screen/date/repo/home_repo.dart';
import 'core/network/setup_dio.dart';
import 'core/network/wep_services.dart';
import 'core/utilities/cache/secure_storage.dart';
import 'feature/auth/date/repo/auth_repo.dart';

final getIt = GetIt.instance;

void initGetIt() async{
  ///Bloc
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt() ,getIt()));
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt() , getIt()));


  ///Repo
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));


  ///Wep_Services
  getIt.registerLazySingleton<WebService>(
          () => WebService(createAndSetupDio()));


  ///External
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
