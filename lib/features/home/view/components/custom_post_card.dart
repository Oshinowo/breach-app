import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/extentions/string_extension.dart';

class CustomPostCard extends StatelessWidget {
  const CustomPostCard({
    super.key,
    required this.thumbnailUrl,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.category,
    required this.onPressed,
  });

  final String thumbnailUrl, title, excerpt, author, category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: kDefaultSize / 2),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/no-photo.jpg",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      text: category,
                      textSize: 12,
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title.capitalizeFirstofEach,
                    textSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xFF181818),
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: excerpt,
                    textSize: 14,
                    textColor: Colors.grey[800],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: author,
                        textSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border, size: 20),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.share_outlined, size: 20),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
