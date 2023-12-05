import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/standard_close_appBar.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes/routes_list.dart';

class WebviewPaymentScreen extends StatelessWidget {
  final String checkoutUrl;

  const WebviewPaymentScreen({super.key, required this.checkoutUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: WebviewPaymentContent(checkoutUrl: checkoutUrl),
      ),
    );
  }
}

class WebviewPaymentContent extends StatefulWidget {
  final String checkoutUrl;

  const WebviewPaymentContent({super.key, required this.checkoutUrl});

  @override
  State<WebviewPaymentContent> createState() => _WebviewPaymentContentState();
}

class _WebviewPaymentContentState extends State<WebviewPaymentContent> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildStandardCloseAppBar(context: context, title: 'Card Checkout'),
      body: Stack(
        children: [
          const LoadingScreen(),
          Opacity(
            opacity: isLoading ? 0.0 : 1.0,
            child: WebView(
              initialUrl: widget.checkoutUrl,
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              onProgress: (percent) {
                log(percent.toString());
                if (percent < 100) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }
                setState(() {});
              },
              navigationDelegate: (NavigationRequest req) async {
                log('log ' + req.url);
                if (req.url.toLowerCase().contains('dibsy_success')) {
                  context.read<UserCubit>().getUserSavedCards();

                  ///navigate with replacement to success screen

                  Navigator.pushReplacementNamed(
                      context, RouteList.successPaymentScreen);
                  return NavigationDecision.prevent;
                } else if (req.url.toLowerCase().contains('dibsy_failure') ||
                    req.url.toLowerCase().contains('unsuccess')) {
                  ///navigate to failure screen
                  Navigator.of(context).pop(false);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
