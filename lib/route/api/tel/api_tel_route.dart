
import 'package:git_src_bot/app/http/controllers/telegram_bot_controller.dart';
import 'package:git_src_bot/app/http/middleware/home_middleware.dart';
import 'package:teledart/teledart.dart';
import 'package:vania/vania.dart';

class ApiTelRoute implements Route {

  TeleDart _teleDart;

  ApiTelRoute({
    required TeleDart teleDart
  }) : _teleDart = teleDart;

  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api/tel');

    _command();

    Router.post("/validateData", telegramBotController.verifyTelegramWebAppData);
    Router.get("/fiat/{base}", telegramBotController.getFiat).middleware([
      HomeMiddleware()
    ]);
    Router.get("/crypto/{base}", telegramBotController.getCrypto).middleware([
      HomeMiddleware()
    ]);
  }

  void _command() {
    _teleDart.onMessage(entityType: 'bot_command', keyword: 'start')
        .listen((message) => message.reply('Hello flutter'));

  }
}
