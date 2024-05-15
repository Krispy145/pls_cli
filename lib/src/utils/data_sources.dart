/// Enum for data sources
enum DataSourceTypes {
  /// API data source
  api,

  /// Assets data source
  assets,

  /// Dummy data source
  dummy,

  /// Firestore data source
  firestore,

  /// Hive data source
  hive,

  /// Secure data source
  secure,

  /// Supabase data source
  supabase;

  bool get defaultPrompt {
    switch (this) {
      case DataSourceTypes.api:
        return false;
      case DataSourceTypes.assets:
        return false;
      case DataSourceTypes.dummy:
        return true;
      case DataSourceTypes.firestore:
        return false;
      case DataSourceTypes.hive:
        return false;
      case DataSourceTypes.secure:
        return false;
      case DataSourceTypes.supabase:
        return false;
    }
  }
}
