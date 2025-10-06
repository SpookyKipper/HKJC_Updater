import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: "設定", backButton: context.canPop()),
      body: Center(
        child: Column(
          children: [
            Padding(
          padding: const EdgeInsets.all(12.5),
          child: Center(
            child: Text("應用程式設定", style: TextStyle(fontSize: 24)),
          ),
        ),
            Button(
              text: "查看授權許可 View Licenses",
              onPressed: () async {
                showLicensePage(
                  context: context,
                  applicationName: 'HKJC Updater',
                  applicationVersion: "v0.0.1 (1)",
                  applicationIcon: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  
                  applicationLegalese: "© Spooky Services",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
