import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersAPI {
   late Dio dio;

  CharactersAPI(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    
    dio = Dio(options);
  }
  
   Future<List<dynamic>> getAllCharacters() async{
    try{
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    }catch(e){
       print(e.toString());
       return[];
    }
   }

   Future<List<dynamic>> getQuoteCharacters(String charName) async{
     try{
       Response response = await dio.get('quote',queryParameters:{'author':charName} );
       print(response.data.toString());
       return response.data;
     }catch(e){
       print(e.toString());
       return[];
     }
   }
 }

