
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart';
import 'package:streamsync_lite/features/authentication/services/api_services.dart';
import 'package:streamsync_lite/features/authentication/services/localdatabase.dart';
import 'package:streamsync_lite/features/favorites/repository/favrepo.dart';
import 'package:streamsync_lite/features/favorites/services/apicalls_favorites.dart';
import 'package:streamsync_lite/features/favorites/services/loca;storage.dart';
import 'package:streamsync_lite/features/home/repositories/Homerepo.dart';
import 'package:streamsync_lite/features/home/services/localStorage.dart';
import 'package:streamsync_lite/features/home/services/video_api_services.dart';
import 'package:streamsync_lite/features/notifications/repository/ntificationsrepo.dart';
import 'package:streamsync_lite/features/notifications/services/localNotifications.dart';
import 'package:streamsync_lite/features/notifications/services/notificationremote.dart';
import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart';
import 'package:injectable/injectable.dart';
import 'package:streamsync_lite/features/videoPlayBack/repository/videoplayRepo.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/videpPreviewAPi.dart';
import 'package:streamsync_lite/features/videoPlayBack/services/vidoelocalStorage.dart';

@module
abstract class RegisterModule {

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // CORE
  @lazySingleton
  Localdatabase localdatabase(SharedPreferences prefs) => Localdatabase(prefs);

  @lazySingleton
  ApiServices apiServices() => ApiServices();

  // SPLASH
  @lazySingleton
  Splashrepo splashRepo(Localdatabase db) => Splashrepo(db);

  // HOME
  @lazySingleton
  VideoApiServices videoApiServices() => VideoApiServices();

  @lazySingleton
  VideoLocalStorage videoLocalStorage(SharedPreferences prefs) =>
      VideoLocalStorage(prefs);

  @lazySingleton
  Homerepo homeRepo(
    VideoApiServices api,
    VideoLocalStorage local,
  ) =>
      Homerepo(api, local);

  // AUTH
  @lazySingleton
  Authrepositry authRepository(
    ApiServices api,
    Localdatabase localdatabase,
  ) =>
      Authrepositry(api, localdatabase);

  // VIDEO PLAY PREVIEW
  @lazySingleton
  Videppreviewapi videoPreviewApi() => Videppreviewapi();

  @lazySingleton
  VideoPlayLocalStorage videoPlayLocalStorage(SharedPreferences prefs) =>
      VideoPlayLocalStorage(prefs);

  @lazySingleton
  Videoplayrepo videoPlayRepo(
    Videppreviewapi api,
    VideoPlayLocalStorage storage,
  ) =>
      Videoplayrepo(api, storage);

  // NOTIFICATION
  @lazySingleton
  NotificationLocalService notificationLocal() => NotificationLocalService();

  @lazySingleton
  NotificationRemoteService notificationRemote() =>
      NotificationRemoteService();

  @lazySingleton
  NotificationRepository notificationRepo(
    NotificationRemoteService remote,
    NotificationLocalService local,
  ) =>
      NotificationRepository(remote: remote, local: local);

  // FAVORITES
  @lazySingleton
  FavoritesLocalService favLocal() => FavoritesLocalService();

  @lazySingleton
  FavoritesRemoteService favRemote() => FavoritesRemoteService();

  @lazySingleton
  FavoritesRepository favRepository(
    FavoritesLocalService local,
    FavoritesRemoteService remote,
  ) =>
      FavoritesRepository(local: local, remote: remote);
}
