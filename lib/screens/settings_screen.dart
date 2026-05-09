import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool isDarkMode = false;

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // PROFILE CARD
          GestureDetector(
            onTap: pickImage,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? const Icon(Icons.person, size: 40, color: Colors.blue)
                        : null,
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wellnex User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Your wellness journey starts here 💙",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          Text(
            "App Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          // NOTIFICATIONS
          _buildTile(
            icon: Icons.notifications,
            title: "Notifications",
            isDark: isDarkMode,
            trailing: Switch(
              value: notifications,
              onChanged: (value) {
                setState(() => notifications = value);
              },
            ),
          ),

          // DARK MODE
          _buildTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            isDark: isDarkMode,
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() => isDarkMode = value);
              },
            ),
          ),

          // PRIVACY
          _buildTile(
            icon: Icons.lock,
            title: "Privacy",
            isDark: isDarkMode,
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Privacy"),
                  content: const Text(
                    "We are working on advanced privacy controls.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),

          // ABOUT
          _buildTile(
            icon: Icons.info,
            title: "About App",
            isDark: isDarkMode,
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Wellnex",
                applicationVersion: "1.0.0",
                children: const [Text("AI-powered wellness tracking app.")],
              );
            },
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
