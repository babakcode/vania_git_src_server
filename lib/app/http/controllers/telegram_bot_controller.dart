import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vania/vania.dart';

class TelegramBotController extends Controller {
  final dio.Dio _apiCurrencies = dio.Dio(dio.BaseOptions(
      baseUrl: 'https://currency.babakcode.com/',
      headers: {'api-key': 'whzWgyYC4rnoTigbk5557l7DfH0xLejAZ'}));

  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> verifyTelegramWebAppData(Request req) async {
    req.validate({'initData': 'required|string'});

    final telegramInitData = req.input('initData');

    final Map<String, String> initData = {
      ...Uri(query: telegramInitData).queryParameters
    };

    final hash = initData['hash'];
    initData.remove('hash');

    final dataToCheck =
        initData.entries.map((entry) => '${entry.key}=${entry.value}').toList();
    dataToCheck.sort();

    final secretKey = Hmac(sha256, utf8.encode('WebAppData'))
        .convert(utf8.encode(env('BOT_TOKEN')));
    final computedHash = Hmac(sha256, secretKey.bytes)
        .convert(utf8.encode(dataToCheck.join('\n')))
        .toString();

    print('Data to check: $dataToCheck');
    print('Computed hash: $computedHash');
    print('Provided hash: $hash');

    if (computedHash == hash) {
      /// user => database
      /// generate key
      ///
      return Response.json({
        'success': computedHash == hash,
        'token': 'naoiwnduanduwandawndoiwajnfiueabf'
      });
    }
    return Response.json({'success': computedHash == hash});
  }

  Future<Response> getFiat(String base) async {
    return _apiCurrencies.get('api/v2/currency/all/$base').then(
      (value) {
        return Response.json(value.data);
      },
    );
  }

  Future<Response> getCrypto(String base) async {
    return _apiCurrencies.get('/api/v2/crypto/all/$base').then(
      (value) {
        return Response.json(value.data);
      },
    );
  }
}

final TelegramBotController telegramBotController = TelegramBotController();
