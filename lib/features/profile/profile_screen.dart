import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tests/core/constants/storage_key.dart';
import 'package:tests/core/theme/theme_controller.dart';
import 'package:tests/main.dart';
import 'package:tests/features/profile/user_details_screen.dart';
import 'package:tests/features/welcome/welcome_Screen.dart';

import '../../core/services/preferences_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username = "Default";
  String? userImagePath;
  String? motivationQuote = "Default";
  bool isDarkMode = true;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    setState(() {
      username = PreferencesManagers().getString(StorageKey.username);
      userImagePath = PreferencesManagers().getString(StorageKey.userImage);
      isDarkMode = PreferencesManagers().getBool(StorageKey.theme) ?? true;
      motivationQuote =
          PreferencesManagers().getString(StorageKey.motivationQuote) ??
          "One task at a time. One step closer.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundImage: userImagePath == null
                            ? AssetImage("assets/images/person.png")
                            : FileImage(File(userImagePath!)),
                        radius: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          _showImageSourceDialog(context, (XFile file) {
                            _saveImage(file);
                            setState(() {
                              userImagePath = file.path;
                            });
                          });
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(Icons.camera_alt, size: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "$username",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "$motivationQuote",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Profile Info",
              style: TextStyle(
                color: Color(0XFFFFFCFC),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            ListTile(
              onTap: () async {
                bool result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UserDetailsScreen(
                        userName: username!,
                        motivation: motivationQuote!,
                      );
                    },
                  ),
                );

                if (result != null && result) {
                  _loadUserData();
                }
              },
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              title: Text("User Details"),
              trailing: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () {},
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.dark_mode,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              title: Text("Dark Mode"),
              trailing: ValueListenableBuilder(
                valueListenable: ThemeController.themeNotofier,
                builder: (context, value, child) {
                  return Switch(
                    value: value == ThemeMode.dark,
                    onChanged: (value) async {
                      ThemeController.toggleTheme();
                    },
                  );
                },
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () async {
                PreferencesManagers().remove(StorageKey.username);
                PreferencesManagers().remove(StorageKey.tasks);
                PreferencesManagers().remove(StorageKey.motivationQuote);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return WelcomeScreen();
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              title: Text("Log Out"),
              trailing: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PreferencesManagers().setString(StorageKey.userImage, newFile.path);
  }

  void _showImageSourceDialog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Choose image",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 10),
                  Text("Gallery"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);

                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 10),
                  Text("Camira"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
