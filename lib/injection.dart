import 'package:get_it/get_it.dart';
import 'package:vcare_app/feature/account/business_logic/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:vcare_app/feature/auth/business_logic/login_cubit/login_cubit.dart';
import 'package:vcare_app/feature/auth/business_logic/register_cubit/register_cubit.dart';
import 'package:vcare_app/feature/doctor_screen/business_logic/doctor_cubit/doctor_cubit.dart';
import 'package:vcare_app/feature/doctor_screen/business_logic/get_all_city/get_all_city_cubit.dart';
import 'package:vcare_app/feature/doctor_screen/date/doctor_repo/doctor_repo.dart';
import 'package:vcare_app/feature/history_screen/data/repo/history_repo.dart';
import 'package:vcare_app/feature/home_screen/business_logic/home_cubit/home_cubit.dart';
import 'package:vcare_app/feature/home_screen/date/repo/home_repo.dart';
import 'core/network/setup_dio.dart';
import 'core/network/wep_services.dart';
import 'core/local_database/secure_storage.dart';
import 'feature/account/business_logic/user_info_cubit/user_info_cubit.dart';
import 'feature/account/data/account_repo/account_repo.dart';
import 'feature/auth/date/repo/auth_repo.dart';
import 'feature/details_screen/data/repo/store_appointment_repo.dart';
import 'feature/history_screen/business_logic/get_appointments_cubit/get_appointments_cubit.dart';
import 'feature/search/business_logic/search_cubit/search_cubit.dart';
import 'feature/search/data/repo/search_repo.dart';

final getIt = GetIt.instance;

void initGetIt() async {
  ///Bloc
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt(), getIt()));
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt() ,getIt()));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt(), getIt()));
  getIt.registerLazySingleton<DoctorCubit>(() => DoctorCubit(getIt(), getIt()));
  getIt.registerLazySingleton<GetAllCityCubit>(
      () => GetAllCityCubit(getIt(), getIt()));
  getIt.registerLazySingleton<UserInfoCubit>(
      () => UserInfoCubit(getIt(), getIt()));
  getIt.registerLazySingleton<UpdateUserInfoCubit>(
      () => UpdateUserInfoCubit(getIt(), getIt()));
  getIt.registerLazySingleton<GetAppointmentsCubit>(
      () => GetAppointmentsCubit(getIt(), getIt()));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt(), getIt()));

  ///Repo
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerLazySingleton<DoctorRepo>(() => DoctorRepo(getIt()));
  getIt.registerLazySingleton<AccountRepo>(() => AccountRepo(getIt()));
  getIt.registerLazySingleton<StoreAppointmentRepo>(
      () => StoreAppointmentRepo(getIt()));
  getIt.registerLazySingleton<HistoryRepo>(() => HistoryRepo(getIt()));
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()));

  ///Wep_Services
  getIt
      .registerLazySingleton<WebService>(() => WebService(createAndSetupDio()));

  ///Local_data
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
}
