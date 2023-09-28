class ApiConstants{
  static const baseUrl = 'https://vcare.integration25.com/api';
  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const logout = '$baseUrl/auth/logout';
  static const homePage = '$baseUrl/home/index';
  static const getAllDoctor = '$baseUrl/doctor/index';
  static const getFilterDoctor = '$baseUrl/doctor/doctor-filter';
  static const getAllCity = '$baseUrl/city/index';
  static const getUserProfile = '$baseUrl/user/profile';
  static const storeAppointment = '$baseUrl/appointment/store';
  static const getAllAppointment = '$baseUrl/appointment/index';
  static const searchDoctor = '$baseUrl/doctor/doctor-search';
  static const updateUserInfo = '$baseUrl/user/update';
}