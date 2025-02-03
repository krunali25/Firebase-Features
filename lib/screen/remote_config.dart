import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:firebase_features/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../helper/FirebaseRemoteConfigService.dart';

class RemoteConfigScreen extends StatefulWidget {
  const RemoteConfigScreen({super.key});

  @override
  State<RemoteConfigScreen> createState() => _RemoteConfigScreenState();
}

class _RemoteConfigScreenState extends State<RemoteConfigScreen> {
  String _welcomeMessage = "Loading...";
  final RemoteConfigService remoteConfigService = RemoteConfigService();

  @override
  void initState() {
    super.initState();
    _loadWelcomeMessage();
  }

  Future<void> _loadWelcomeMessage() async {
    try {
      final message = remoteConfigService.getValue('message');
      print("Fetched message: $message");
      setState(() {
        _welcomeMessage = message.isNotEmpty
            ? message
            : "Default welcome message (no remote message).";
      });
    } catch (e) {
      print("Error fetching message: $e");
      setState(() {
        _welcomeMessage = "Failed to load the welcome message.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Remote Config Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _welcomeMessage,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(Dimens.padding_30),
              child: AppButton(
                onPressed: () async {
                  try {
                    await remoteConfigService.fetchAndActivate(); // Public fetch method
                    final newMessage = remoteConfigService.getValue('message');
                    setState(() {
                      _welcomeMessage = newMessage;
                    });
                    print("Updated message: $newMessage");
                  } catch (e) {
                    print("Error fetching new message: $e");
                  }
                },
                label: StringConstants.fetchNewConfig,
                // child: const Text("Fetch New Config"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
