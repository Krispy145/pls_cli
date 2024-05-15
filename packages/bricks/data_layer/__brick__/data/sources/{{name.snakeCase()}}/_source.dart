library data.sources.{{name.snakeCase()}};
import 'package:utilities/data_sources/source.dart';
import "package:utilities/data/models/basic_search_query_model.dart";
import '../../models/{{name.snakeCase()}}_model.dart';

import 'package:utilities/data_sources/remote/api.dart';
import 'package:utilities/logger/logger.dart';
import 'package:parent_name_template/utils/loggers.dart';
import 'package:utilities/data_sources/local/assets.dart';
import "package:utilities/data_sources/local/dummy_data.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:utilities/data_sources/remote/firestore.dart';
import "package:utilities/data_sources/local/hive/hive.dart";
import "/utils/loggers.dart";
import "package:utilities/data_sources/local/secure.dart";
import "package:utilities/logger/logger.dart";
import 'package:utilities/data_sources/remote/supabase.dart';
import "package:supabase_flutter/supabase_flutter.dart";


{{#api}} part 'api.source.dart'; {{/api}}
{{#assets}} part 'assets.source.dart'; {{/assets}}
{{#dummy}} part 'dummy.source.dart'; {{/dummy}}
{{#firestore}} part 'firestore.source.dart'; {{/firestore}}
{{#hive}} part 'hive.source.dart'; {{/hive}}
{{#secure}} part 'secure.source.dart'; {{/secure}}
{{#supabase}} part 'supabase.source.dart'; {{/supabase}}

/// [{{name.pascalCase()}}DataSource] is an mixin that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
sealed class {{name.pascalCase()}}DataSource implements DataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel> {}
