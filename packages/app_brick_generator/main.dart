import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:pool/pool.dart';

final _sourcePath = path.join(path.current, "packages", "app");
final _targetPath =
    path.join(path.current, "packages", "bricks", 'app', '__brick__');
final _staticDir =
    path.join(path.current, 'packages', 'app_brick_generator', 'static');
final _androidPath = path.join(_targetPath, 'template', 'android');
final _rootPath = path.join(_targetPath, 'template');
final _libPath = path.join(_targetPath, 'template', 'lib');
final _androidKotlinPath =
    path.join(_androidPath, 'app', 'src', 'main', 'kotlin');
final _orgPath = path.join(_androidKotlinPath, 'com');

final pool = Pool(10, timeout: Duration(seconds: 30));

extension GeneratorStringX on String {
  String replaceApplicationId(String filePath) {
    final isAndroid = path.isWithin(_androidPath, filePath);

    if (isAndroid && filePath.endsWith('build.gradle')) {
      return replaceAll(
        'com.wearearch.flutter_template',
        '{{application_id_android}}',
      );
    } else if (isAndroid) {
      return replaceAll(
        'com.wearearch.flutter_template',
        '{{application_id_android}}',
      );
    } else {
      return replaceAll('com.wearearch.flutter-template', '{{application_id}}');
    }
  }
}

void main() async {
  stderr.writeln("Generating Flutter App Brick");
  // Remove Previously Generated Files
  final targetDir = Directory(_targetPath);
  if (targetDir.existsSync()) {
    await targetDir.delete(recursive: true);
  }

  // Copy Project Files
  await Shell.cp(_sourcePath, _targetPath);

  // delete existing main files and replace with the firebase templates
  await Future.wait([
    File(path.join(_libPath, 'main_development.dart')).delete(),
    File(path.join(_libPath, 'main_production.dart')).delete(),
    File(path.join(_libPath, 'main_staging.dart')).delete(),
  ]);
  await Shell.cp(
    path.join(_staticDir, "main_development.dart"),
    path.join(_libPath, "main_development.dart"),
  );
  await Shell.cp(
    path.join(_staticDir, "main_staging.dart"),
    path.join(_libPath, "main_staging.dart"),
  );
  await Shell.cp(
    path.join(_staticDir, "main_production.dart"),
    path.join(_libPath, "main_production.dart"),
  );
  await Shell.cp(
    path.join(_staticDir, "codemagic.yaml"),
    path.join(_rootPath, "codemagic.yaml"),
  );

  // Delete Android's Organization Folder Hierarchy
  Directory(_orgPath).deleteSync(recursive: true);

  // Convert Values to Variables
  await Future.forEach(
      Directory(_targetPath)
          .listSync(recursive: true)
          .whereType<File>()
          .toList(), (_) async {
    var file = _ as File;
    if (path.basename(file.path) == ".DS_Store") {
      await file.delete();
    }
  });

  // Directory(_targetPath)
  //    .listSync(recursive: true)
  //    .whereType<File>()
  //    .toList();
  // for (final _ in allFiles) {
  //   var file = _;
  //
  //   try {
  //     if (file.path.endsWith('Info.plist')) {
  //       final contents = await readFile(file);
  //       file = await file.writeAsString(
  //         contents.replaceAll(
  //           '<string>Flutter Template</string>',
  //           r'<string>$(FLAVOR_APP_NAME)</string>',
  //         ),
  //       );
  //     }
  //
  //     final contents = await readFile(file);
  //     file = await file.writeAsString(
  //       contents
  //           .replaceAll('flutter_template', '{{project_name.snakeCase()}}')
  //           .replaceAll('flutter-template', '{{project_name.paramCase()}}')
  //           .replaceAll('A new Flutter project.', '{{{description}}}')
  //           .replaceAll('Flutter Template', '{{project_name.titleCase()}}')
  //           .replaceApplicationId(file.path),
  //       flush: true,
  //     );
  //
  //     final fileSegments = file.path.split('/').sublist(2);
  //     if (fileSegments.contains('flutter_template')) {
  //       final newPathSegment = fileSegments.join('/').replaceAll(
  //             'flutter_template',
  //             '{{project_name.snakeCase()}}',
  //           );
  //       final newPath = path.join(_targetPath, newPathSegment);
  //       File(newPath).createSync(recursive: true);
  //       file.renameSync(newPath);
  //       Directory(file.parent.path).deleteSync(recursive: true);
  //     }
  //   } catch (_) {}
  // }

  await Future.wait(
    Directory(path.join(_targetPath, 'template'))
        .listSync(recursive: true)
        .whereType<File>()
        .map((_) async {
      var file = _;

      try {
        if (file.path.contains("assets/")) {
          return;
        }
        if (file.path.endsWith('Info.plist')) {
          final contents = await readFile(file);
          file = await file.writeAsString(
            contents.replaceAll(
              '<string>Flutter Template</string>',
              r'<string>$(FLAVOR_APP_NAME)</string>',
            ),
          );
        }

        final contents = await readFile(file);
        file = await file.writeAsString(
          contents
              .replaceApplicationId(file.path)
              .replaceAll('flutter_template', '{{project_name.snakeCase()}}')
              .replaceAll('flutter-template', '{{project_name.paramCase()}}')
              .replaceAll('A new Flutter project.', '{{{description}}}')
              .replaceAll('Flutter Template', '{{project_name.titleCase()}}'),
          flush: true,
        );

        final fileSegments = file.path.split('/').sublist(2);
        if (fileSegments.contains('flutter_template')) {
          final newPathSegment = fileSegments.join('/').replaceAll(
                'flutter_template',
                '{{project_name.snakeCase()}}',
              );
          final newPath = path.join(_targetPath, newPathSegment);
          File(newPath).createSync(recursive: true);
          file.renameSync(newPath);
          Directory(file.parent.path).deleteSync(recursive: true);
        }
      } catch (_) {}
    }),
  );

  final mainActivityKt = File(
    path.join(
      _androidKotlinPath.replaceAll('template', '{{project_name.snakeCase()}}'),
      '{{application_id_android.pathCase()}}',
      'MainActivity.kt',
    ),
  );
  await Shell.mkdir(mainActivityKt.parent.path);
  await Shell.cp(path.join(_staticDir, 'MainActivity.kt'), mainActivityKt.path);

  final firebaseToolPath = File(
    path.join(
      _targetPath,
      "template",
      "{{#has_firebase}}tools{{/has_firebase}}",
      "firebase_install.sh",
    ),
  );
  await Shell.mkdir(firebaseToolPath.parent.path);
  await Shell.cp(
    path.join(_staticDir, 'firebase_install.sh'),
    firebaseToolPath.path,
  );

  await Shell.rename(
    path.join(_targetPath, 'template'),
    path.join(_targetPath, '{{project_name.snakeCase()}}'),
  );
}

Future<String> readFile(File file) {
  return pool.withResource(() => file.readAsString());
}

class Shell {
  static Future<void> cp(String source, String destination) {
    return _Cmd.run('cp', ['-rf', source, destination]);
  }

  static Future<void> mkdir(String destination) {
    return _Cmd.run('mkdir', ['-p', destination]);
  }

  static Future<void> rename(String source, String destination) async {
    await Shell.cp('$source/', '$destination/');
    await _Cmd.run('rm', ['-rf', source]);
  }
}

class _Cmd {
  static Future<ProcessResult> run(
    String cmd,
    List<String> args, {
    bool throwOnError = true,
    String? processWorkingDir,
  }) async {
    final result = await Process.run(
      cmd,
      args,
      workingDirectory: processWorkingDir,
      runInShell: true,
    );

    if (throwOnError) {
      _throwIfProcessFailed(result, cmd, args);
    }
    return result;
  }

  static void _throwIfProcessFailed(
    ProcessResult pr,
    String process,
    List<String> args,
  ) {
    if (pr.exitCode != 0) {
      final values = {
        'Standard out': pr.stdout.toString().trim(),
        'Standard error': pr.stderr.toString().trim()
      }..removeWhere((k, v) => v.isEmpty);

      String message;
      if (values.isEmpty) {
        message = 'Unknown error';
      } else if (values.length == 1) {
        message = values.values.single;
      } else {
        message = values.entries.map((e) => '${e.key}\n${e.value}').join('\n');
      }

      throw ProcessException(process, args, message, pr.exitCode);
    }
  }
}
