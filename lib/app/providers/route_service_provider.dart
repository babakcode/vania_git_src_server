import 'package:vania/vania.dart';
import 'package:git_src_bot/route/api_route.dart';
import 'package:git_src_bot/route/web.dart';
import 'package:git_src_bot/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    WebRoute().register();
    ApiRoute().register();
    WebSocketRoute().register();
  }
}
