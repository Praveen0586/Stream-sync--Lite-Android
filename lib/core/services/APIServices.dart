import 'package:streamsync_lite/core/globals/globals.dart';

class ApiConfigs {
  static const liveurl = "";

  static const testurl = "http://10.185.61.246:3000";

  static String baseURL = isLiveAPI ? liveurl : testurl;

  //API links
  static String Register = baseURL + "/auth/register";
  static String Login = baseURL + "/auth/login";
  static String refreshtocken = baseURL + "/auth/refresh";

  static String videosByChannelid =
      baseURL + "/videos/latest";
  static String getVideoByID = baseURL + "/videos/Xw69Rw-GY4s";
  static String sendProgress = baseURL + "/videos/progress";
    static String getProgress = baseURL + "/videos/progress/get";



}
