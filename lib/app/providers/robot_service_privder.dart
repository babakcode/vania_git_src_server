import 'package:git_src_bot/route/api/tel/api_tel_route.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vania/vania.dart';

class RobotServiceProvider extends ServiceProvider{

  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    final BOT_TOKEN = env('BOT_TOKEN');
    final username = (await Telegram(BOT_TOKEN).getMe()).username;
    final teledart = TeleDart(BOT_TOKEN, Event(username!));

    teledart.start();

    ApiTelRoute(teleDart: teledart).register();
  }
}
