import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vania/vania.dart';

class TelegramBotController extends Controller {

     final dio.Dio _apiCurrencies = dio.Dio(
          dio.BaseOptions(
               baseUrl: 'https://currency.babakcode.com/',
               headers: {
                    'api-key': 'whzWgyYC4rnoTigbk5557l7DfH0xLejAZ'
               }
          )
     );

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }


     Future<Response> verifyTelegramWebAppData(Request req) async {
          req.validate({
               'initData': 'required|string'
          });

          final telegramInitData = req.input('initData');

          print('initData: $telegramInitData\n');
          var initData = Uri.parse('https://babakcode.com?$telegramInitData');
          var hashValue = initData.queryParameters['hash'];
          initData = initData.replace(queryParameters: {}); // Remove 'hash' parameter

          var dataToCheck = initData.queryParameters.entries
              .map((entry) => '${entry.key}=${Uri.decodeComponent(entry.value)}')
              .toList();
          dataToCheck.sort();
          var dataToCheckString = dataToCheck.join('\n');

          var secretKey = Hmac(sha256, utf8.encode('WebAppData'))
              .convert(utf8.encode(env('BOT_TOKEN')))
              .bytes;
          var computedHash = Hmac(sha256, secretKey)
              .convert(utf8.encode(dataToCheckString))
              .toString();

          print('Data to check: $dataToCheckString');
          print('Computed hash: $computedHash');
          print('Provided hash: $hashValue');

          if(computedHash == hashValue){

               /// user => database
               /// generate key
               ///
               return Response.json({
                    'success': computedHash == hashValue,
                    'token': 'naoiwnduanduwandawndoiwajnfiueabf'
               });
          }
          return Response.json({
               'success': computedHash == hashValue
          });
     }


     Future<Response> getFiat(String base) async {
          return _apiCurrencies.get('api/v2/currency/all/$base').then((value) {
               return Response.json(value.data);
          },);
     }
     Future<Response> getCrypto(String base) async {
          return _apiCurrencies.get('/api/v2/crypto/all/$base').then((value) {
               return Response.json(value.data);
          },);
     }
}

final TelegramBotController telegramBotController = TelegramBotController();

