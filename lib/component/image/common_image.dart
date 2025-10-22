import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stays_hotel_booking/core/utils/log/error_log.dart';


class CommonImage extends StatelessWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;

  final BoxFit fill;

  const CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.contain,
    this.defaultImage = "",
    super.key,
  });

  checkImageType() {}

  @override
  Widget build(BuildContext context) {
    if (imageSrc.contains("assets/icons")) {
      return _buildSvgImage();
    } else if (imageSrc.contains("assets/images")) {
      return _buildPngImage();
    } else {
      return _buildNetworkImage();
    }
  }

  Widget _buildErrorWidget() {
    if (defaultImage.isNotEmpty) {
      return Image.asset(defaultImage);
    }
    return const SizedBox.shrink();
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      height: size ?? height,
      width: size ?? width,
      imageUrl: imageSrc,
      fit: fill,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider, fit: fill),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) {
        errorLog(error, source: "Common Image");

        return _buildErrorWidget();
      },
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      imageSrc,
      color: imageColor,
      height: size ?? height,
      width: size ?? width,
      fit: fill,
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imageSrc,
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {
          errorLog(error, source: "Common Image");
          return _buildErrorWidget();
        },
      ),
    );
  }
}
