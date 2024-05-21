class EnvironmentConfig {
  static const IsProduction = String.fromEnvironment('IS_PRODUCTION');
  static const IsStaging = String.fromEnvironment('IS_STAGING');
  static const IsPVDev = String.fromEnvironment('IS_PV_DEV');
}