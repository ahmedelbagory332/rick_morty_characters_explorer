import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../domain/Characters/repo/characters_repo.dart';
import '../presentation/Characters/manager/characters_cubit.dart';
import '../presentation/Characters/view/characters_view.dart';
import 'di/service_locator.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static const kCharactersView = '/';

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: kCharactersView,
        builder: (context, state) => BlocProvider(
            create: (context) => CharactersCubit(
                  getIt.get<CharactersRepo>(),
                ),
            child: const CharactersView()),
      ),
    ],
  );
}
