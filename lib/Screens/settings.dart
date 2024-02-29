import 'package:flutter/material.dart';
import 'package:pro_gamer/Screens/profile/profile_edit.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:const Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme:const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           const Text(
              'General Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          const  SizedBox(height: 10),
            ListTile(
              leading:const Icon(Icons.volume_up, color: Colors.white),
              title:const Text('Sound', style: TextStyle(color: Colors.white)),
              subtitle:const Text('Turn on/off game sound effects', style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: true, 
                onChanged: (bool value) {
                },
              ),
            ),
            ListTile(
              leading:const Icon(Icons.color_lens, color: Colors.white),
              title:const Text('Theme', style: TextStyle(color: Colors.white)),
              subtitle:const Text('Choose your preferred theme', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to theme selection page
              },
            ),
          const  Divider(),
           const Text(
              'Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
           const SizedBox(height: 10),
            ListTile(
              leading:const Icon(Icons.person, color: Colors.white),
              title:const Text('Edit Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    );
              },
            ),
            ListTile(
              leading:const Icon(Icons.security, color: Colors.white),
              title:const Text('Privacy & Security', style: TextStyle(color: Colors.white)),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}