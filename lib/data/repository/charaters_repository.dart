import '../apis/characters_api.dart';
import '../models/charater.dart';
import '../models/quote.dart';

class CharactersRepository {
  final CharactersAPI charactersAPI;

  CharactersRepository(this.charactersAPI);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersAPI.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getQuoteCharacters(String charName) async {
    final quotes = await charactersAPI.getQuoteCharacters(charName);
    return quotes
        .map((charQuote) => Quote.fromJson(charQuote))
        .toList();
  }
}
