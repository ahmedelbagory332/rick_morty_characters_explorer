import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'app/app_router.dart';
import 'app/di/service_locator.dart';

Future<void> main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router
      ),
    );
  }
}
