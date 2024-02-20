import 'dart:io';

import 'package:path_provider/path_provider.dart';

///A wrapper for a package which provides some directories: temp, application etc.
class DirectoryProvider {
  Future<Directory> get tempDirectory async => getTemporaryDirectory();
}
