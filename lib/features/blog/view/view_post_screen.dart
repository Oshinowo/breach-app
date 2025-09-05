import '../../../core/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_text.dart';
import '../viewmodel/posts_provider.dart';

class ViewPostScreen extends StatefulWidget {
  const ViewPostScreen({super.key});

  static const String id = "/view_post";

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    final args = GoRouterState.of(context).extra! as int;
    final post = context.watch<Posts>().findById(args);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => context.pop()),
        centerTitle: true,
        title: CustomText(
          text: post.title ?? 'Post',
          textSize: 20,
          fontWeight: FontWeight.w800,
          alignText: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: kAppBorderPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: kDefaultSize / 2),
              CustomText(
                text: "Series: ${post.series?.name ?? 'No content'}",
                textSize: 16,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: kDefaultSize / 2),
              CachedNetworkImage(
                imageUrl: post.imageUrl ?? "https://via.placeholder.com/150",
                placeholder: (context, url) => Image.asset(
                  "assets/images/no-photo.jpg",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: kDefaultSize),
              CustomText(
                text: post.content ?? 'No content',
                textSize: 16,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: kDefaultSize * 2),
              CustomText(
                text: post.author?.name ?? 'Unknown',
                textSize: 18,
                fontWeight: FontWeight.bold,
                alignText: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
