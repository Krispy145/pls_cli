library data.sources.{{name.snakeCase()}};

import "package:cloud_firestore/cloud_firestore.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import 'package:test_package/utils/loggers.dart';
import "package:utilities/data/models/basic_search_query_model.dart";
import 'package:utilities/data_sources/api/paginated.dart';
import 'package:utilities/data_sources/assets/paginated.dart';
import 'package:utilities/data_sources/dummy/paginated.dart';
import 'package:utilities/data_sources/firestore/paginated.dart';
import 'package:utilities/data_sources/hive/paginated.dart';
import 'package:utilities/data_sources/paginated.dart';
import 'package:utilities/data_sources/secure/paginated.dart';
import 'package:utilities/data_sources/source.dart';
import 'package:utilities/data_sources/supabase/paginated.dart';
import 'package:utilities/helpers/tuples.dart';
import "package:utilities/logger/logger.dart";

import '../../models/{{name.snakeCase()}}_model.dart';


{{#api}} part 'api.source.dart'; {{/api}}
{{#assets}} part 'assets.source.dart'; {{/assets}}
{{#dummy}} part 'dummy.source.dart'; {{/dummy}}
{{#firestore}} part 'firestore.source.dart'; {{/firestore}}
{{#hive}} part 'hive.source.dart'; {{/hive}}
{{#secure}} part 'secure.source.dart'; {{/secure}}
{{#supabase}} part 'supabase.source.dart'; {{/supabase}}

/// [{{name.pascalCase()}}DataSource] is an mixin that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
sealed class {{name.pascalCase()}}DataSource<Resp extends ResponseModel> with DataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel>, Paginated<Resp, {{name.pascalCase()}}Model, BasicSearchQueryModel> {}

