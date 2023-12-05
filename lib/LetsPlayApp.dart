import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/features/landing/landing_screen.dart';
import 'package:lets_play/routes/routes.dart';
import 'package:lets_play/common/components/ScrollGlowEffectDisabler.dart';

import 'bottom_tabbar/bottom_tabbar.dart';
import 'features/AppStartup/SplashScreen.dart';
import 'features/AppStartup/cubit/startup/startup_cubit.dart';
import 'features/register/enable_location_screen.dart';

class LetsPlayApp extends StatelessWidget {
  const LetsPlayApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Let's Play",
        builder: EasyLoading.init(builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (details) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: ScrollConfiguration(
                behavior: ScrollGlowEffectDisabler(), child: child!),
          );
        }),
        home: const StartupScreenDecider(),
        onGenerateRoute: (RouteSettings settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return MaterialPageRoute(
            builder: builder!,
            settings: settings,
          );
        },
      ),
    );
  }
}

class StartupScreenDecider extends StatefulWidget {
  const StartupScreenDecider({Key? key}) : super(key: key);

  @override
  State<StartupScreenDecider> createState() => _StartupScreenDeciderState();
}

class _StartupScreenDeciderState extends State<StartupScreenDecider> {
  @override
  void initState() {
    super.initState();
    context.read<StartupCubit>().initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartupCubit, StartupState>(
      listener: (context, state) async {
        if (state.notification != null) {
          /// show notification widget
        }
      },
      buildWhen: (previous, current) =>
          previous.showSplash != current.showSplash,
      builder: (context, startup) {
        Widget screen;
        if (startup.showSplash!) {
          screen = SplashScreen();
        } else {
          if (startup.isAuthed == true) {
            if (startup.isLocated == true) {
              screen = const HomeBottomTabbar();
            } else {
              screen = const EnableLocationScreen();
            }
          } else {
            screen = const LandingScreen();
          }
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 800), child: screen);
      },
    );
  }
}
