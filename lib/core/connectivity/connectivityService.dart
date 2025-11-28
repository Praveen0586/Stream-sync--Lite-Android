import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _controller.stream;

  void initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      final hasInternet = result != ConnectivityResult.none;
      _controller.add(hasInternet);
    });
  }
}
