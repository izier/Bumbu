// lib/core/services/id_generator.dart

import 'package:uuid/uuid.dart';

class IdGenerator {
  static final _uuid = Uuid();

  static String generate() {
    return _uuid.v4();
  }
}
