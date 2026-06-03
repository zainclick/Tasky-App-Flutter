import 'package:flutter/material.dart';
import 'package:tests/core/widgets/custom_text_form_field.dart';

import '../core/services/preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivation,
  });

  final String userName;
  final String motivation;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    userNameController.text = widget.userName;
    motivationController.text = widget.motivation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 8),
              CustomTextFormField(
                title: "User Name",
                controller: userNameController,
                hintText: "Enter User Name",
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Task Name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                title: "Motivation Quote",
                controller: motivationController,
                hintText: "Enter Motivation Quote (Optional)",
                maxLines: 5,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Motivation Quote";
                  } else {
                    return null;
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    await PreferencesManagers().setString(
                      "username",
                      userNameController.value.text,
                    );
                    await PreferencesManagers().setString(
                      "motivation_quote",
                      motivationController.value.text,
                    );

                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF15B86C),
                  foregroundColor: Color(0XFFFFFCFC),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
