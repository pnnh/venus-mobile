import 'package:dream/application/web/providers/emotion.dart';
import 'package:dream/services/models/picture.dart';
import 'package:dream/services/models/resource.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'partial/quick_action.dart';

class ImageCellWidget extends ConsumerWidget {
  final ResourceModel resource;

  const ImageCellWidget(this.resource, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hoverOrSelected =
        (ref.watch(wpGridProvider)).hoverOrSelected(resource.pk);
    debugPrint("ImageCellWidget ${resource.pk} ${resource.title}");
    return Container(
      child: MouseRegion(
        onEnter: (event) {
          ref.read(wpGridProvider.notifier).hover(resource.pk);
        },
        onExit: (event) {
          ref.read(wpGridProvider.notifier).hover("");
        },
        child: GestureDetector(
          onTap: () {
            ref.read(wpGridProvider.notifier).select(resource.pk);
          },
          child: Container(
            //padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                  color:
                      hoverOrSelected ? Color(0xff009cff) : Color(0xffD7D7D7),
                  width: 1.5),
            ),
            child: buildBody(resource),
          ),
        ),
      ),
    );
  }

  Widget buildBody(ResourceModel resource) {
    // if (resource.headerEnum == ResourceHeader.picture) {
    //   var picture = resource.getBody<PictureModel>();
    //   if (picture != null) {
    //     return Image(
    //       // height: 96,
    //       // width: 96,
    //       //image: NetworkImage(buildFileUrl(emotion.file)),
    //       image: NetworkImage(buildFileUrl(picture.file)),
    //       fit: BoxFit.fill,
    //     );
    //   }
    // }
    return Container(
      color: Colors.white,
    );
  }
}
