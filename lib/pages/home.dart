import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:one_ui/one_ui.dart';
import 'package:spookyservices/spookyservices.dart';
import 'package:spookyservices/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    print("Brightness: ${Theme.of(context).brightness}");
    if (Theme.of(context).brightness == Brightness.dark) {
      setDarkMode(true); //for spookyservices
    } else {
      setDarkMode(false); //for spookyservices
    }
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: OneUIView(
            title: Text("香港賽馬會應用程式更新助手"),
            actions: [
              CupertinoButton(
                padding: EdgeInsets.only(right: 10),
                onPressed: () {
                  context.push('/settings');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 24,
                    ),
                  ],
                ),
              ),
            ],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("請選擇需要更新的App", style: TextStyle(fontSize: 30)),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        widget: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Image.asset(
                            "assets/images/3in1.png",
                            width: 25,
                          ),
                        ),
                        text: "投注三合一",
                        onPressed: () {
                          context.push('/update?app=3in1');
                        },
                        contrast: true,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        widget: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Image.asset(
                            "assets/images/accountopening.png",
                            width: 25,
                          ),
                        ),
                        text: "馬會開户口",
                        onPressed: () {
                          context.push('/update?app=accountopening');
                        },
                        contrast: true,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        widget: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Image.asset(
                            "assets/images/RacingTouch.png",
                            width: 25,
                          ),
                        ),
                        text: "Racing Touch",
                        onPressed: () {
                          context.push('/update?app=RacingTouch');
                        },
                        contrast: true,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        widget: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Image.asset(
                            "assets/images/hkjctv.png",
                            width: 25,
                          ),
                        ),
                        text: "HKJC TV",
                        onPressed: () {
                          context.push('/update?app=HKJCTV');
                        },
                        contrast: true,
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
