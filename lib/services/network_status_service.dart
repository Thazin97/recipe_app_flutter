import 'dart:async';
import 'package:connectivity/connectivity.dart';

enum NetworkStatus { WiFi,Cellular, Offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
  StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult status){
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
  //   if (status == ConnectivityResult.wifi || status == ConnectivityResult.mobile) {
  //     return NetworkStatus.Online;
  //   } else {
  //     return NetworkStatus.Offline;
  //   }
  // }
    switch (status) {
      case ConnectivityResult.mobile:
        return NetworkStatus.Cellular;
      case ConnectivityResult.wifi:
        return NetworkStatus.WiFi;
      case ConnectivityResult.none:
        return NetworkStatus.Offline;
      default:
        return NetworkStatus.Offline;
    }
  }

}
