import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  static late String baseUrl;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('assets/config.yaml');
    final yamlConfig = loadYaml(configString);

    baseUrl = yamlConfig['baseUrl'] ?? '';
  }
}
