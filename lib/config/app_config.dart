class AppConfig {
  final String baseDogApiUrl;

  AppConfig({required this.baseDogApiUrl});
}

class DefaultConfig extends AppConfig {
  DefaultConfig() : super(baseDogApiUrl: "https://api.thedogapi.com/v1");
}

class IntegrationTestConfig extends AppConfig {
  IntegrationTestConfig() : super(baseDogApiUrl: "http://localhost:3018");
}
