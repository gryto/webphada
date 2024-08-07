class ApiService {
  static String version = "1.0.1";
  static String uri = "u3.cloudkejaksaan.my.id";
  static String server = "http://$uri";
  static String endPoint = "$server:4003";
  static String folder = "https://$uri/upload/mirror/user_profile";

  static String setLogin = "$endPoint/api/auth/login";
  static String detailUser = "$endPoint/api/user/get-single";
  static String getDashboard = "$endPoint/api/activity/get-dashboard";
  static String logActivity = "$endPoint/api/activity/get-log";
  static String reportVisitor = "$endPoint/api/activity/get-visitor";
  static String reportRating = "$endPoint/api/rating/get-all";
  static String reportContactus = "$endPoint/api/contact-us/get-all";
  static String reportNewsletter = "$endPoint/api/newsletter/get-all";
  static String getNotification = "$endPoint/api/notification/get-all";
  static String activeTutorial = "$endPoint/api/active/get-tutorial";
  static String getSurvey = "$endPoint/api/survey/get-by-user";
  static String setSurvey = "$endPoint/api/survey/process-data";
  static String searchContent = "$endPoint/api/activity/get-search-content";
  static String getSatker = "$endPoint/api/active/get-satker";
  static String getFilemanager = "$endPoint/api/activity/get-file-manager";
}
