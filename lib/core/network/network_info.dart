import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return !(connectivityResult.contains(ConnectivityResult.none));
  }
}
