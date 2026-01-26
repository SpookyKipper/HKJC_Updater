import 'package:flutter/material.dart' hide AppBar;
import 'package:spookyservices/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
