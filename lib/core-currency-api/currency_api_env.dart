import 'package:envied/envied.dart';

part 'currency_api_env.g.dart';

@Envied(path: 'api_secrets.env')
final class CurrencyApiEnv {
  @EnviedField(varName: 'FIXER_IO_API_KEY', obfuscate: true)
  static final String apiKey = _CurrencyApiEnv.apiKey;
}
