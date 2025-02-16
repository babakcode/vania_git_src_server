import 'package:vania/vania.dart';
import 'package:git_src_bot/app/providers/route_service_provider.dart';

import '../app/providers/robot_service_privder.dart';
import 'auth.dart';
import 'cors.dart';

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  'cors': cors,
  'auth': authConfig,
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
    RobotServiceProvider(),
  ],
};
