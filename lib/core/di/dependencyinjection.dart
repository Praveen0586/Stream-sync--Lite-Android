import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './dependencyinjection.config.dart';
final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => getIt.init();
