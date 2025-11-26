import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart';
import 'package:streamsync_lite/features/authentication/services/api_services.dart';
import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';
import 'package:streamsync_lite/features/authentication/viewmodel/bloc/authentiction_bloc.dart';
import 'package:streamsync_lite/features/home/repositories/Homerepo.dart';
import 'package:streamsync_lite/features/home/services/localStorage.dart';
import 'package:streamsync_lite/features/home/services/video_api_services.dart';
import 'package:streamsync_lite/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart';
import 'package:streamsync_lite/features/splash/view/splashScreen.dart';
import 'package:streamsync_lite/features/splash/viewModels/splash_cubit.dart';
import 'package:streamsync_lite/features/videoPlayBack/repository/videoplayRepo.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/videpPreviewAPi.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/vidoelocalStorage.dart';
import 'package:streamsync_lite/features/videoPlayBack/viewMdel/bloc/video_play_back_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await InitDependencies();

  final prefs = await SharedPreferences.getInstance();
  final Localdatabase localdatabase = Localdatabase(prefs);
  final Splashrepo splashrepo = Splashrepo(localdatabase);
  final apiservices = ApiServices();
  final VideoApiServices videoApiServices = VideoApiServices();
  final VideoLocalStorage videoLocalStorage = VideoLocalStorage(prefs);
  final Homerepo homerepo = Homerepo(videoApiServices, videoLocalStorage);
  final Authrepositry authrepo = Authrepositry(apiservices, localdatabase);
  final Videppreviewapi videppreviewapi = Videppreviewapi();
  final VideoPlayLocalStorage videoPlayLocalStorage = VideoPlayLocalStorage(
    prefs,
  );
  final Videoplayrepo videoplayrepo = Videoplayrepo(
    videppreviewapi,
    videoPlayLocalStorage,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(splashrepo)),
        BlocProvider(create: (context) => AuthentictionBloc(authrepo)),
        BlocProvider(create: (context) => HomeBloc(homerepo)),
        BlocProvider(create: (context) => VideoPlayBackBloc(videoplayrepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StreamSync Lite',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: SplashScreen(),
      themeMode: ThemeMode.light,
    );
  }
}
