// ignore_for_file: constant_identifier_names

/// [Structure] is an enum that represents the structure of the project.
enum Structure {
  /// [Default] structure.
  Default,

  /// [Map] structure.
  Map,

  /// [DefaultMap] structure.
  DefaultMap,

  /// [Dashboard] structure.
  Dashboard,
}

// /// [Structure] extension methods.
// extension ProjectStructureExtension on Structure {


//   String get routesFileName {
//     switch (this) {
//       case Structure.Default:
//         return 'default_routes.dart';
//       case Structure.Map:
//         return 'map_routes.dart';
//       case Structure.DefaultMap:
//         return 'default_map_routes.dart';
//       case Structure.Dashboard:
//         return 'dashboard_routes.dart';
//     }
//   }
// }