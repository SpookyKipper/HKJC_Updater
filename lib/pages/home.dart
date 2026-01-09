import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:one_ui/one_ui.dart';
import 'package:spookyservices/spookyservices.dart';
import 'package:spookyservices/theme/RouteDesign.dart';
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
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Center(
                  child: Text("請選擇需要下載或更新的App", style: TextStyle(fontSize: 30)),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button(
                      widget: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Image.asset("assets/images/3in1.png", width: 25),
                      ),
                      text: "投注三合一",
                      onPressed: () {
                        context.push('/update?app=投注三合一');
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
                        context.push('/update?app=馬會開户口');
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
        );
      },
    );
  }
}
