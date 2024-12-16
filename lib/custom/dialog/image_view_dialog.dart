import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';

class ImageViewDialog extends StatelessWidget {
  final String image;

  const ImageViewDialog({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      decoration: BoxDecoration(
        color: AppColors.placeholder,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Image.asset(AppAsset.icPlaceholderImage).paddingAll(50);
        },
        errorWidget: (context, url, error) {
          return Image.asset(AppAsset.icPlaceholderImage).paddingAll(50);
        },
      ),
    );
  }
}
