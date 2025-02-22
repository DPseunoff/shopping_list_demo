import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(name: 'Env', path: '.env', obfuscate: false)
abstract class Env {
  @EnviedField(varName: 'DATA_BASE_TYPE')
  static const String dbType = _Env.dbType;
}
