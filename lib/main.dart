import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/core/connectivity/connectivityService.dart';
import 'package:streamsync_lite/core/connectivity/offlinebanner.dart';
import 'package:streamsync_lite/core/di/dependencyinjection.dart';
import 'package:streamsync_lite/core/fcm/firebasemessaging.dart';
import 'package:streamsync_lite/core/fcm/notificationservice.dart';
import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart';
import 'package:streamsync_lite/features/authentication/viewmodel/bloc/authentiction_bloc.dart';
import 'package:streamsync_lite/features/favorites/repository/favrepo.dart';
import 'package:streamsync_lite/features/favorites/viewModel/bloc/favorites_bloc.dart';
import 'package:streamsync_lite/features/home/repositories/Homerepo.dart';
import 'package:streamsync_lite/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:streamsync_lite/features/notifications/repository/ntificationsrepo.dart';
import 'package:streamsync_lite/features/notifications/viewModel/bloc/notifications_bloc.dart';
import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart';
import 'package:streamsync_lite/features/splash/view/splashScreen.dart';
import 'package:streamsync_lite/features/splash/viewModels/splash_cubit.dart';
import 'package:streamsync_lite/features/videoPlayBack/repository/videoplayRepo.dart';
import 'package:streamsync_lite/features/videoPlayBack/viewMdel/bloc/video_play_back_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationService.initialize();

  await configureDependencies();
  ConnectivityService().initialize();
runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(getIt<Splashrepo>())),
        BlocProvider(
          create: (context) => AuthentictionBloc(getIt<Authrepositry>()),
        ),
        BlocProvider(create: (context) => HomeBloc(getIt<Homerepo>())),
        BlocProvider(
          create: (context) => VideoPlayBackBloc(getIt<Videoplayrepo>()),
        ),
        BlocProvider(
          create: (context) =>
              NotificationsBloc(getIt<NotificationRepository>()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(getIt<FavoritesRepository>()),
        ),
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
      home: Stack(
        children: [
          SplashScreen(),
          Positioned(bottom: 20, right: 20, child: OfflineBanner()),
        ],
      ),
      themeMode: ThemeMode.light,
    );
  }
}
