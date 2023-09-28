import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vcare_app/feature/home_screen/date/model/doctor_model.dart';

import '../../../../core/local_database/secure_storage.dart';
import '../../data/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo, this.secureStorage) : super(SearchInitial());
  final SearchRepo searchRepo;
  final SecureStorage secureStorage;

  List<DoctorModel> searchDoctorsList = [];

  void searchDoctor(String searchKeyWord) async {
    String? token = await secureStorage.readSecureData('token');
    searchRepo
        .searchDoctor(token: token!, searchKeyWord: searchKeyWord)
        .then((value) => emit(SearchSuccess(value)));
  }
}
