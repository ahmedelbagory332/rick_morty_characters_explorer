import 'package:get_it/get_it.dart';
import 'package:rick_morty_characters_explorer/app/di/repo_service_locator.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await setupRepoServiceLocator(getIt);
}