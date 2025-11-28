// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:streamsync_lite/core/di/injections.dart' as _i638;
import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart'
    as _i981;
import 'package:streamsync_lite/features/authentication/services/api_services.dart'
    as _i543;
import 'package:streamsync_lite/features/authentication/services/localdatabase.dart'
    as _i569;
import 'package:streamsync_lite/features/favorites/repository/favrepo.dart'
    as _i862;
import 'package:streamsync_lite/features/favorites/services/apicalls_favorites.dart'
    as _i696;
import 'package:streamsync_lite/features/favorites/services/loca;storage.dart'
    as _i898;
import 'package:streamsync_lite/features/home/repositories/Homerepo.dart'
    as _i327;
import 'package:streamsync_lite/features/home/services/localStorage.dart'
    as _i17;
import 'package:streamsync_lite/features/home/services/video_api_services.dart'
    as _i47;
import 'package:streamsync_lite/features/notifications/repository/ntificationsrepo.dart'
    as _i544;
import 'package:streamsync_lite/features/notifications/services/localNotifications.dart'
    as _i164;
import 'package:streamsync_lite/features/notifications/services/notificationremote.dart'
    as _i250;
import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart'
    as _i914;
import 'package:streamsync_lite/features/videoPlayBack/repository/videoplayRepo.dart'
    as _i766;
import 'package:streamsync_lite/features/videoPlayBack/services/videpPreviewAPi.dart'
    as _i1022;
import 'package:streamsync_lite/features/videoPlayBack/services/vidoelocalStorage.dart'
    as _i174;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i543.ApiServices>(() => registerModule.apiServices());
    gh.lazySingleton<_i47.VideoApiServices>(
      () => registerModule.videoApiServices(),
    );
    gh.lazySingleton<_i1022.Videppreviewapi>(
      () => registerModule.videoPreviewApi(),
    );
    gh.lazySingleton<_i164.NotificationLocalService>(
      () => registerModule.notificationLocal(),
    );
    gh.lazySingleton<_i250.NotificationRemoteService>(
      () => registerModule.notificationRemote(),
    );
    gh.lazySingleton<_i898.FavoritesLocalService>(
      () => registerModule.favLocal(),
    );
    gh.lazySingleton<_i696.FavoritesRemoteService>(
      () => registerModule.favRemote(),
    );
    gh.lazySingleton<_i569.Localdatabase>(
      () => registerModule.localdatabase(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i17.VideoLocalStorage>(
      () => registerModule.videoLocalStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i174.VideoPlayLocalStorage>(
      () => registerModule.videoPlayLocalStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i981.Authrepositry>(
      () => registerModule.authRepository(
        gh<_i543.ApiServices>(),
        gh<_i569.Localdatabase>(),
      ),
    );
    gh.lazySingleton<_i766.Videoplayrepo>(
      () => registerModule.videoPlayRepo(
        gh<_i1022.Videppreviewapi>(),
        gh<_i174.VideoPlayLocalStorage>(),
      ),
    );
    gh.lazySingleton<_i327.Homerepo>(
      () => registerModule.homeRepo(
        gh<_i47.VideoApiServices>(),
        gh<_i17.VideoLocalStorage>(),
      ),
    );
    gh.lazySingleton<_i914.Splashrepo>(
      () => registerModule.splashRepo(gh<_i569.Localdatabase>()),
    );
    gh.lazySingleton<_i862.FavoritesRepository>(
      () => registerModule.favRepository(
        gh<_i898.FavoritesLocalService>(),
        gh<_i696.FavoritesRemoteService>(),
      ),
    );
    gh.lazySingleton<_i544.NotificationRepository>(
      () => registerModule.notificationRepo(
        gh<_i250.NotificationRemoteService>(),
        gh<_i164.NotificationLocalService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i638.RegisterModule {}
