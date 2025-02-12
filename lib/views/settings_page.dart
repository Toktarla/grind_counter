import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/di/injection_container.dart';

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
        ],
      ),
    );
  }
}
