import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../atoms/loading.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  const ImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (_, __) =>
                        LoadingSpinner(),
                    errorWidget: (_, url, error) {
                      debugPrint('IMAGE ERROR: $url -> $error');
                      return const Icon(Icons.broken_image);
                    },
                  ); 
  }
}