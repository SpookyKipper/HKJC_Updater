import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:one_ui/one_ui.dart';
import 'package:spookyservices/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OneUIView(
        title: Text("設定"),
        // initCollapsed: true,
        child: ListView(
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
                        applicationVersion: "v0.0.1 (1)",
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
    );
  }
}
