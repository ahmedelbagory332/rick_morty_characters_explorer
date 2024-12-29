import 'package:get_it/get_it.dart';
import 'package:rick_morty_characters_explorer/app/di/repo_service_locator.dart';

import '../../data/Characters/local/dbhelper.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<DbHelper>(DbHelper());
  await setupRepoServiceLocator(getIt);
}