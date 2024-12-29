import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Characters/view/widget/empty_error.dart';
import '../manager/fav_characters_cubit.dart';
import 'fav_character_list_item.dart';

class FavCharactersViewBody extends StatelessWidget {
  const FavCharactersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<FavCharactersCubit>().state.localList.isEmpty ?
    const Center(child: EmptyError(text: "No Data")) :
    ListView.builder(
        itemCount:
            context.read<FavCharactersCubit>().state.localList.length,
        itemBuilder: (ctx, index) {
          return favCharacterListItem(
            context,
            context.watch<FavCharactersCubit>().state.localList[index],
            (favItem) {
              context.read<FavCharactersCubit>().onFavClick(favItem);
            },
          );
        });
  }
}
