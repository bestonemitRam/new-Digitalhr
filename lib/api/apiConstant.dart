class APIURL {
  static const production = "https://bsoe.meestdrive.in/";
  static const MAIN_URL = production;
  static const API_URL = MAIN_URL + "api";

  static const String GET_ALL_TASK = "$API_URL/employee/task-list-all";
  static const String UPDATE_TASK = "$API_URL/employee/task-submit";
  static const String UPDATE_PROFILE = "$API_URL/employee/profile-update";
  static const String TADA_LIST_URL = "$API_URL/employee/tada-lists";
  static const String TADA_STORE_URL = "$API_URL/employee/tada/store";
  static const String PROFILE_URL = "$API_URL/employee/get-profile-details";
  static const String TADA_UPDATE_URL = "$API_URL/employee/tada/update/";
}
