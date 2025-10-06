import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:ota_update_fork/ota_update_fork.dart';
import 'package:spookyservices/widgets/widgets.dart';

class ApkInstallPage extends StatefulWidget {

  const ApkInstallPage({super.key});

  @override
  State<ApkInstallPage> createState() => _ApkInstallPageState();
}

class _ApkInstallPageState extends State<ApkInstallPage> {
  OtaEvent? currentEvent;

  @override
  Widget build(BuildContext context) {
   

    Future<void> updateApk(String url) async {
      try {
        OtaUpdate()
            .execute(url, destinationFilename: 'hkjc_app_update.apk')
            .listen((OtaEvent event) {
              setState(() {
                currentEvent = event;
              });
              // print('Current OTA status: ${event.status} : ${event.value}');

              if (event.status == OtaStatus.INSTALLING) {
                context.go('/updateComplete');
              } else if (event.status ==
                      OtaStatus.PERMISSION_NOT_GRANTED_ERROR ||
                  event.status == OtaStatus.INTERNAL_ERROR) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("更新失敗"),
                      content: Text("無法下載更新，請確保您已授予應用程式存儲權限，然後重試。"),
                      actions: [
                        TextButton(
                          child: Text("確定"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (event.status == OtaStatus.DOWNLOAD_ERROR) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("更新失敗"),
                      content: Text("無法下載更新，請檢查您的網絡連接，然後重試。"),
                      actions: [
                        TextButton(
                          child: Text("確定"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            });
      } catch (e) {
        print('Failed to make OTA update. Details: $e');
      }
    }

    if (currentEvent == null) {
      updateApk(GoRouter.of(context).routeInformationProvider.value.uri.queryParameters['apkUrl']!);
    }

    return Scaffold(
      appBar: AppBar(title: "香港賽馬會應用程式更新助手", backButton: context.canPop()),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("正在下載及安裝更新"),
          SizedBox(height: 20),
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text("請不要離開此頁面。", style: TextStyle(fontSize: 20)),
          (currentEvent?.value != null && currentEvent?.value != "0")
              ? Text("下載進度: ${currentEvent?.value ?? 0}%")
              : SizedBox()
        ],
      )),
    );
  }
}
