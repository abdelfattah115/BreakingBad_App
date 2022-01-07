import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bussiness_logic/cubit/characters_cubit.dart';
import 'data/apis/characters_api.dart';
import 'data/models/charater.dart';
import 'data/repository/charaters_repository.dart';
import 'prsentation/screens/characters_screen.dart';
import 'prsentation/screens/details_screen.dart';

import 'constants/strings.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersAPI());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: CharactersScreen(),
              ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => CharactersCubit(charactersRepository),
              child: CharacterDetailsScreen(character: character,),
            ));
    }
  }
}
