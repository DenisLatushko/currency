import 'package:envied/envied.dart';

part 'api_env.g.dart';

@Envied(path: 'api_secrets.env')
final class ApiEnv {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _ApiEnv.apiKey;
}