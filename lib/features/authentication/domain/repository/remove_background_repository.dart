import 'dart:typed_data';

import 'package:flutter_dashboard/core/use_case.dart';

abstract class RemoveBackgroundIRepository {
  DefaultFutureEitherType<Uint8List> removeBackground(Uint8List originalImage);
}
