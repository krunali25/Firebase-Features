import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigService() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // Timeout for fetching
        minimumFetchInterval: const Duration(seconds: 0), // No cache for testing
      ));
      await fetchAndActivate();
    } catch (e) {
      print("Error initializing Remote Config: $e");
    }
  }

  Future<void> fetchAndActivate() async {
    try {
      bool fetched = await _remoteConfig.fetchAndActivate();
      print("Remote Config fetched and activated: $fetched");
    } catch (e) {
      print("Error fetching and activating Remote Config: $e");
    }
  }

  String getValue(String key) {
    return _remoteConfig.getString(key);
  }
}
