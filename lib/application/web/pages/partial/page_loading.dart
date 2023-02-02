
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
 
class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Container(
              height: 24,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,

                  /// Required, The loading type of the widget
                  colors: const [Colors.white],

                  /// Optional, The color collections
                  strokeWidth: 2,

                  /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.transparent,

                  /// Optional, Background of the widget
                  pathBackgroundColor: Colors.transparent

                  /// Optional, the stroke backgroundColor
                  ),
            );
  }
}