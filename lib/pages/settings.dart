import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:one_ui/one_ui.dart';
import 'package:spookyservices/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 50,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red, // Specify the border color
              width: 2, // Specify the border width
            ),
            borderRadius: BorderRadius.circular(
              12,
            ), // Optional: Add rounded corners
          ),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
        
                  children: [
                    Button(
                      text: "查看授權許可 View Licenses",
                      onPressed: () async {
                        showLicensePage(
                          context: context,
                          applicationName: 'HKJC Updater',
                          applicationVersion: "v0.0.4 (4)",
                          applicationIcon: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 100),
                            child: Image.asset("assets/images/icon.png"),
                          ),
        
                          applicationLegalese: "© Spooky Services",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
