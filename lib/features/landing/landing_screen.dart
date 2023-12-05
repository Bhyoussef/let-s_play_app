import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/routes/routes_list.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landing_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                child: Center(
                    child: Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.fitWidth,
                )),
                flex: 7,
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {

                            Navigator.pushNamed(context, RouteList.register);
                          },
                          child: const Text(
                            'Get started',
                            style: AppStyles.largeButtonTextStyle,
                          ),
                          style: AppStyles.elevatedButtonDefaultStyle),
                      TextButton(
                        style: TextButton.styleFrom(
                            textStyle: AppStyles.textButtonTextStyle()),
                        onPressed: () {},
                        child: Text(
                          'Browse courts',
                          style: AppStyles.textButtonTextStyle(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ? ",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteList.login);
                              },
                              child: Text("Sign in",
                                  style: AppStyles.textButtonTextStyle(
                                      fontSize: 13)))
                        ],
                      )
                    ]),
                flex: 4,
              )
            ]),
          ),
        ),
      )),
    );
  }
}
