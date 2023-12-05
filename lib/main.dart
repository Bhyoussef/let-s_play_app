import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lets_play/common/constants/storage_contants.dart';
import 'package:lets_play/features/landing/cubit/auth_cubit.dart';
import 'package:lets_play/features/search_screen/cubit/search_cubit.dart';
import 'package:lets_play/services/kiwi_container.dart';
import 'LetsPlayApp.dart';
import 'data/core/debug/app_bloc_observer.dart';
import 'data/core/http/dio_api_client.dart';
import 'features/AppStartup/cubit/startup/startup_cubit.dart';
import 'features/AppStartup/cubit/utility/utility_cubit.dart';
import 'features/profile/cubit/user_cubit.dart';

late Box userBox;
final myDio = DioClient();

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    setupKiwiContainer();
    Bloc.observer = AppBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    userBox = await (Hive.openBox(StorageConstants.userBox));

    unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
    runApp(const LetsPlayProvided());
  }, (e, stackTrace) {
    print(e);
    throw e;
  });
}

class LetsPlayProvided extends StatelessWidget {
  const LetsPlayProvided({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<UtilityCubit>(create: (context) => UtilityCubit()),
        BlocProvider<StartupCubit>(
            create: (context) => StartupCubit(
                  userCubit: context.read<UserCubit>(),
                  utilityCubit: context.read<UtilityCubit>(),
                )),
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(userCubit: context.read<UserCubit>())),
      ],
      child: const LetsPlayApp(),
    );
  }
}
