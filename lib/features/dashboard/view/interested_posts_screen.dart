import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_button_with_icon.dart';
import '../../../core/constants/app_constants.dart';
import '../../blog/viewmodel/posts_provider.dart';
import '../../home/view/components/custom_post_card.dart';
import '../../interests/viewmodel/interests_provider.dart';

class InterestedPostsScreen extends StatefulWidget {
  const InterestedPostsScreen({super.key});

  static const String id = "/interested_posts";

  @override
  State<InterestedPostsScreen> createState() => _InterestedPostsScreenState();
}

class _InterestedPostsScreenState extends State<InterestedPostsScreen> {
  int _selectedInterestId = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final interests = context.watch<Interests>().items;
    if (interests.isNotEmpty && _selectedInterestId == 0) {
      setState(() {
        _selectedInterestId = interests.first.category?.id ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final interests = context.watch<Interests>().items;
    final storedPosts = context.watch<Posts>();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: () => context.pop()),
        centerTitle: true,
        title: CustomText(
          text: "Interested Topics",
          textSize: 20,
          fontWeight: FontWeight.w800,
          alignText: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: kAppBorderPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (interests.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: interests
                      .map(
                        (interest) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomTextButtonWithIcon(
                            label: interest.category?.name ?? '',
                            buttonBackgroundColour:
                                _selectedInterestId == interest.category?.id
                                ? kPrimaryColour
                                : Colors.transparent,
                            buttonForegroundColour:
                                _selectedInterestId == interest.category?.id
                                ? Colors.white
                                : Color(0XFF181818),
                            textColour:
                                _selectedInterestId == interest.category?.id
                                ? Colors.white
                                : Color(0XFF181818),
                            borderColour:
                                _selectedInterestId == interest.category?.id
                                ? Colors.transparent
                                : Color(0XFFC7C4BC),
                            buttonIcon: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: EdgeInsets.only(left: 3),
                              child: CustomText(
                                text: interest.category?.icon ?? "",
                                alignText: TextAlign.center,
                                textSize: 16,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedInterestId = interest.category!.id!;
                                storedPosts.filteredItems(
                                  categoryId: interest.category?.id!,
                                );
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            interests.isNotEmpty
                ? storedPosts
                          .filteredItems(categoryId: _selectedInterestId)
                          .isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: storedPosts
                                .filteredItems(categoryId: _selectedInterestId)
                                .length,
                            itemBuilder: (context, index) => CustomPostCard(
                              category:
                                  storedPosts
                                      .filteredItems(
                                        categoryId: _selectedInterestId,
                                      )[index]
                                      .series
                                      ?.name ??
                                  '',
                              thumbnailUrl:
                                  storedPosts
                                      .filteredItems(
                                        categoryId: _selectedInterestId,
                                      )[index]
                                      .imageUrl ??
                                  '',
                              title:
                                  storedPosts
                                      .filteredItems(
                                        categoryId: _selectedInterestId,
                                      )[index]
                                      .title ??
                                  '',
                              excerpt:
                                  "${storedPosts.filteredItems(categoryId: _selectedInterestId)[index].content?.substring(0, 50)}...",
                              author:
                                  storedPosts
                                      .filteredItems(
                                        categoryId: _selectedInterestId,
                                      )[index]
                                      .author
                                      ?.name ??
                                  '',
                              onPressed: () {},
                            ),
                          ),
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: kDefaultSize * 5,
                            ),
                            child: CustomText(
                              text: "No Posts Yet!",
                              textSize: 16,
                            ),
                          ),
                        )
                : Expanded(
                    child: ListView.builder(
                      itemCount: storedPosts.items.length,
                      itemBuilder: (context, index) => CustomPostCard(
                        category: storedPosts.items[index].series?.name ?? '',
                        thumbnailUrl: storedPosts.items[index].imageUrl ?? '',
                        title: storedPosts.items[index].title ?? '',
                        excerpt:
                            "${storedPosts.items[index].content?.substring(0, 50)}...",
                        author: storedPosts.items[index].author?.name ?? '',
                        onPressed: () {},
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
