import 'package:flutter_riverpod/flutter_riverpod.dart';

final emotionProvider =
    StateNotifierProvider<EmotionModel, String>((ref) => EmotionModel());

class EmotionModel extends StateNotifier<String> {
  EmotionModel() : super("");

  void selectKey(String key) {
    print("selectKey $key");
    state = key;
  }
}
