import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/charater.dart';
import '../../data/models/quote.dart';
import '../../data/repository/charaters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacter(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuoteCharacters(String charName){
    charactersRepository.getQuoteCharacters(charName).then((quotes){
      emit(QuotesCharactersLoaded(quotes));
    });
  }
}
