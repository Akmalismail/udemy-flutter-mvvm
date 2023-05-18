import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'dart:developer' as developer;

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return false;
    }
  }
}
