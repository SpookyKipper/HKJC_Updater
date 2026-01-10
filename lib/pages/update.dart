import 'package:flutter/material.dart' hide AppBar;
import 'package:go_router/go_router.dart';
import 'package:spookyservices/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage>
    with AutomaticKeepAliveClientMixin<UpdatePage> {
  @override
  bool get wantKeepAlive => true;

  String title = "馬會App更新助手";
  String? progress;
  bool _showContent = false;
  String? app;

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(milliseconds: 1000), () {
    //   //delay so no transition lag
    //   setState(() {
    //     _showContent = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, String> appsDownloadUrl = {
      "RacingTouch": "https://m.hkjc.com/tc/download-racing-touch.html",
      "HKJCTV": "https://m.hkjc.com/tc/download-hkjctv.html",
      "投注三合一": "https://m.hkjc.com/tc/download-classic-3-in-1.html",
      "馬會開户口": "https://m.hkjc.com/tc/download-hkjc-account-opening.html",
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
              context.go('/apkInstall?apkUrl=${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(appsDownloadUrl[app]!));

    // if (app != null && app!.isNotEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     AppShell.of(context).setTitle("更新 $app");
    //   });
    // }

    return Scaffold(
      // appBar: OneUIAppBar(title: Text(title)),
      body: (true
          ? WebViewWidget(controller: controller)
          : Center(child: CircularProgressIndicator())),
    );
  }
}
