import '../../../core/extentions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/components/custom_text.dart';
import '../../blog/model/post.dart';
import '../../blog/view/view_post_screen.dart';
import '../../home/view/components/custom_stream_card.dart';

class StreamPostsScreen extends StatefulWidget {
  const StreamPostsScreen({super.key});

  static const String id = "/stream_posts";

  @override
  State<StreamPostsScreen> createState() => _StreamPostsScreenState();
}

class _StreamPostsScreenState extends State<StreamPostsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = GoRouterState.of(context).extra! as List<PostModel>;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => context.pop()),
        centerTitle: true,
        title: CustomText(
          text: "Streams",
          textSize: 20,
          fontWeight: FontWeight.w800,
          alignText: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: args.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            final post = args[index];
            return CustomStreamCard(
              title: post.title?.capitalizeFirstofEach ?? '',
              excerpt: "${post.content?.substring(0, 100) ?? ''}...",
              author: post.author?.name ?? '',
              date: post.createdAt != null
                  ? DateFormat(
                      'dd/MM/yyyy',
                    ).format(DateTime.parse(post.createdAt!))
                  : '',
              onPressed: () {},
            );
          },
        ),
      ),
    );
  }
}
