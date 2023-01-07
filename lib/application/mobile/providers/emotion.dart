import 'package:dream/services/models/folder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<PictureFolder> folderProvider =
    StateProvider((_) => PictureFolder("", path: ""));

final StateProvider<String> gridProvider = StateProvider((_) => "");
