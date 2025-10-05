import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spookyservices/theme/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              Button(
                widget: Image.asset("assets/images/RacingTouch.png"),
                text: "Racing Touch",
                onPressed: () {
                  context.go('/update?app=RacingTouch');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
