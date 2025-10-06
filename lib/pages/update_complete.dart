import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';

class UpdateCompletePage extends StatelessWidget {
  const UpdateCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "更新成功後請按「完成」",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Button(
              text: "完成",
              onPressed: () => context.go('/'),
            )
          ],
        ),
      ),
    );
  }
}