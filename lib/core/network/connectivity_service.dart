import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_status.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();

  static Future<NetworkStatus> getCurrentStatus() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    final status = _mapToNetworkStatus(connectivityResult);
    return status;
  }

  Stream<NetworkStatus> get onStatusChanged {
    return _connectivity.onConnectivityChanged
        .asyncMap((result) => _mapToNetworkStatus(result))
        .asyncMap((status) async => status)
        .distinct();
  }

  static NetworkStatus _mapToNetworkStatus(List<ConnectivityResult> result) =>
      result.contains(ConnectivityResult.wifi)
          ? NetworkStatus.onlineWifi
          : result.contains(ConnectivityResult.mobile)
              ? NetworkStatus.onlineMobile
              : NetworkStatus.offline;
}
