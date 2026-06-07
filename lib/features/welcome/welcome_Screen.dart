import 'package:flutter/material.dart';
import 'package:tests/core/constants/storage_key.dart';
import 'package:tests/core/widgets/custom_svg_picture.dart';
import 'package:tests/core/widgets/custom_text_form_field.dart';
import 'package:tests/features/navigation/main_screen.dart';

import '../../core/services/preferences_manager.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/Vector.svg",
                    width: 42,
                    height: 42,
                  ),

                  SizedBox(width: 16),
                  Text(
                    "Tasky",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: 108),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Tasky ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/waving.svg",
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Your productivity journey starts here.",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 16),
              ),
              SizedBox(height: 24),
              CustomSvgPicture.withoutColor(
                path: "assets/images/pana.svg",
                width: 215,
                height: 205,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 28),
                      Align(alignment: Alignment.centerLeft),
                      SizedBox(height: 8),
                      CustomTextFormField(
                        title: "Full Name",
                        controller: controller,
                        hintText: "e.g. Mohamed Zain",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Full Name";
                          } else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManagers().setString(
                              StorageKey.username,
                              controller.value.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return MainScreen();
                                },
                              ),
                            );
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFF15B86C),
                          foregroundColor: Color(0XFFFFFCFC),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        child: Text("Let’s Get Started"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
