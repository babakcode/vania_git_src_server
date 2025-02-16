import 'package:vania/vania.dart';

class HomeMiddleware extends Middleware {
  @override
  handle(Request req) async {

    if(req.header('api-key') != 'naoiwnduanduwandawndoiwajnfiueabf'){
      abort(401, 'Api key required');
    }
  }
}
