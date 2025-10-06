import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: "馬會App更新助手",
            backButton: context.canPop(),
            automaticallyImplyLeading:
                false, // Flutter sometimes adds back button despite cannot pop.
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("請選擇需要更新的App：", style: TextStyle(fontSize: 30)),
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
