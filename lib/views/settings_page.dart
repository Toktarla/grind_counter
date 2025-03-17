import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/di/injection_container.dart';
import '../services/local_notification_service.dart';
import '../utils/helpers/snackbar_helper.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool playSound = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = sl<SharedPreferences>();
    setState(() {
      playSound = prefs.getBool('playSound') ?? false;
    });
  }

  Future<void> _togglePlaySound(bool value) async {
    final prefs = sl<SharedPreferences>();
    await prefs.setBool('playSound', value);
    setState(() {
      playSound = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Feedback');
            },
            icon: const Icon(Icons.feedback_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Play sound'),
            subtitle: const Text('Plays sound when an exercise is recorded.'),
            trailing: Switch(
              onChanged: _togglePlaySound,
              value: playSound,
            ),
          ),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            onTap: () async {
              print(sl<SharedPreferences>().get('fcmToken'));
              PermissionStatus status = await Permission.notification.request();
              if (status.isGranted) {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                );

                if (selectedTime != null) {
                  LocalNotificationService.scheduleDailyMotivationalMessage(
                    hour: selectedTime.hour,
                    minute: selectedTime.minute,
                  );
                  SnackbarHelper.showSuccessSnackbar(message: 'Notification time was scheduled to ${selectedTime.format(context)}');
                }
              } else if (status.isDenied) {
                await Permission.notification.request();
              } else if (status.isPermanentlyDenied) {
                openAppSettings();
              }
            },
          ),
        ],
      ),
    );
  }
}