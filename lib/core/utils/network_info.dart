import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo({required this.connectivity});

  Future<bool> isNotConnected() async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return true;
    }
    return false;
  }

  Future<bool> isOnline() async {
    final result = await InternetAddress.lookup("example.com");
    if (result.isEmpty) return false;
    if (result[0].rawAddress.isEmpty) return false;
    return true;
  }
}
