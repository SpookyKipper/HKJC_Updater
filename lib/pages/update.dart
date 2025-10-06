import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:ota_update_fork/ota_update_fork.dart';
import 'package:spookyservices/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String title = "馬會App更新助手";
  OtaEvent? currentEvent;
  String? progress;
  bool _showContent = false;
  String? app;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      //delay so no transition lag
      setState(() {
        _showContent = true;
      });
    });
  }

  Future<void> updateApk(String url) async {
    try {
      OtaUpdate()
          .execute(url, destinationFilename: 'hkjc_app_update.apk')
          .listen((OtaEvent event) {
            setState(() => currentEvent = event);
            setState(() {
              progress = event.value;
            });
            // print('Current OTA status: ${event.status} : ${event.value}');

            if (event.status == OtaStatus.INSTALLING) {
              Navigator.of(context).pop(); // Close the dialog
              context.go('/updateComplete');
            } else if (event.status == OtaStatus.PERMISSION_NOT_GRANTED_ERROR ||
                event.status == OtaStatus.INTERNAL_ERROR) {
              Navigator.of(context).pop(); // Close the dialog
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
              Navigator.of(context).pop(); // Close the dialog
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

  @override
  Widget build(BuildContext context) {
    const Map<String, String> appsDownloadUrl = {
      "RacingTouch": "https://m.hkjc.com/tc/download-racing-touch.html",
      "HKJCTV": "https://m.hkjc.com/tc/download-hkjctv.html",
    };

    if (app == null ||
        (GoRouter.of(
                  context,
                ).routeInformationProvider.value.uri.queryParameters['app'] !=
                null &&
            GoRouter.of(context)
                .routeInformationProvider
                .value
                .uri
                .queryParameters['app']!
                .isNotEmpty)) {
      // refreshing state causes app to be null, so save it first
      setState(() {
        app = GoRouter.of(
          context,
        ).routeInformationProvider.value.uri.queryParameters['app'];
      });
    }

    print("App to update: $app");
    if (app != null && app!.isNotEmpty) {
      setState(() {
        title = "更新 $app";
      });
    }

    if (app == null) {
      return Container();
    }

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.endsWith('.apk')) {
              print("Preventing ${request.url}");

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(child: Text("正在下載更新")),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("請不要離開此頁面。", style: TextStyle(fontSize: 20)),
                        (progress != null && progress != "0")
                            ? Text("下載進度: ${currentEvent?.value ?? 0}%")
                            : SizedBox(),
                      ],
                    ),
                  );
                },
              );

              updateApk(request.url);

              return NavigationDecision.prevent;
              //
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(appsDownloadUrl[app]!));

    return Scaffold(
      appBar: AppBar(title: title, backButton: context.canPop()),
      body: (_showContent
          ? WebViewWidget(controller: controller)
          : Center(child: CircularProgressIndicator())),
    );
  }
}
