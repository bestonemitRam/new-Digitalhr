class APIURL {
  static const production = "https://bsoe.meestdrive.in/";
  static const MAIN_URL = production;
  static const API_URL = MAIN_URL + "api";

  static const String LOGIN_API = "$API_URL/user/authIn";
  static const String CHECK_IN_URL = "$API_URL/attendance/punchIN";
  static const String CHECK_Out_URL = "$API_URL/attendance/punchOUT";
  static const String LOCATION_TRACKER = "$API_URL/sales/locationSaver";
  static const String ATTENDANCC_HISTORY = "$API_URL/attendance/list/2024/";
  static const String LOG_OUT = "$API_URL/user/authOut";
  static const String GET_ME = "$API_URL/authorize/check";

  static const String GET_ALL_TASK = "$API_URL/employee/task-list-all";
  static const String UPDATE_TASK = "$API_URL/employee/task-submit";
  static const String UPDATE_PROFILE = "$API_URL/employee/profile-update";
  static const String TADA_LIST_URL = "$API_URL/employee/tada-lists";
  static const String TADA_STORE_URL = "$API_URL/employee/tada/store";
  static const String PROFILE_URL = "$API_URL/employee/get-profile-details";
  static const String TADA_UPDATE_URL = "$API_URL/employee/tada/update/";
  static const String HOME_PAGE_URL = "$API_URL/dashboard/overall";

  static const String BUUCKET_LEAVE = "$API_URL/leaves/allTakenLeaveTypes";

  static const String HOLIDAYS_API = "$API_URL/employee/holidayList";

  static const String SELECT_LEAVE_API = "$API_URL/leave/leaveTypes";

  static const String LEAVE_REQUEST_API = "$API_URL/leave/applyLeave";
  static const String LEAVE_LIST_DETAILS_API = "$API_URL/leave/list?";
  static const String SHOP_LIST = "$API_URL/employee/shopsList";
  static const String DISTRIBUTOR_LIST = "$API_URL/sales/distributors/list";
  static const String DISTRIBUTOR_STATE_LIST = "$API_URL/sales/states";
  static const String DISTRIBUTOR_DISTRICT_LIST = "$API_URL/sales/districts/";
  static const String CREATE_DISTRIBUTOR = "$API_URL/sales/distributors/save";
}
