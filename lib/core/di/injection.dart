// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart';
// import 'package:streamsync_lite/features/authentication/services/api_services.dart';
// import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';
// import 'package:streamsync_lite/features/home/repositories/Homerepo.dart';
// import 'package:streamsync_lite/features/home/services/localStorage.dart';
// import 'package:streamsync_lite/features/home/services/video_api_services.dart';
// import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart';

// final s1 = GetIt.instance;

// Future<void> InitDependencies() async {
//   final pref = await SharedPreferences.getInstance();

//   //services
//   s1.registerLazySingleton<SharedPreferences>(() => pref);
//   s1.registerLazySingleton<ApiServices>(() => ApiServices());
//   s1.registerLazySingleton<VideoApiServices>(() => VideoApiServices());
//   s1.registerLazySingleton<VideoLocalStorage>(
//     () => VideoLocalStorage(s1<SharedPreferences>()),
//   );
//   s1.registerLazySingleton<Localdatabase>(
//     () => Localdatabase(s1<SharedPreferences>()),
//   );

//   //Repositories
//   s1.registerLazySingleton<Authrepositry>(
//     () => Authrepositry(s1<ApiServices>(), s1<Localdatabase>()),
//   );
//   s1.registerLazySingleton<Splashrepo>(() => Splashrepo(s1<Localdatabase>()));
//   s1.registerLazySingleton<Homerepo>(
//     () => Homerepo(s1<VideoApiServices>(), s1()),
//   );
// }

