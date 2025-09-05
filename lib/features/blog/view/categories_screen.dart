import '../../../core/constants/app_constants.dart';
import '../viewmodel/categories_provider.dart';
import '../viewmodel/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_button_with_icon.dart';
import '../../home/view/components/custom_post_card.dart';
import '../model/post.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  static const String id = "/categories_screen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<PostModel> _filteredPosts = [];
  int _selectedCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    final storedCategories = context.watch<Categories>().items;
    final storedPosts = context.watch<Posts>();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: CustomText(
          text: "Categories",
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: storedCategories
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CustomTextButtonWithIcon(
                            label: category.name ?? '',
                            buttonBackgroundColour:
                                _selectedCategoryId == category.id
                                ? kPrimaryColour
                                : Colors.transparent,
                            buttonForegroundColour:
                                _selectedCategoryId == category.id
                                ? Colors.white
                                : Color(0XFF181818),
                            textColour: _selectedCategoryId == category.id
                                ? Colors.white
                                : Color(0XFF181818),
                            borderColour: _selectedCategoryId == category.id
                                ? Colors.transparent
                                : Color(0XFFC7C4BC),
                            buttonIcon: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: EdgeInsets.only(left: 3),
                              child: CustomText(
                                text: category.icon ?? "",
                                alignText: TextAlign.center,
                                textSize: 16,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedCategoryId = category.id!;
                                _filteredPosts = storedPosts.filteredItems(
                                  categoryId: category.id!,
                                );
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Column(
                children: _filteredPosts.isNotEmpty
                    ? _filteredPosts
                          .map(
                            (post) => CustomPostCard(
                              category: post.series?.name ?? '',
                              thumbnailUrl: post.imageUrl ?? '',
                              title: post.title ?? '',
                              excerpt: "${post.content?.substring(0, 50)}...",
                              author: post.author?.name ?? '',
                              onPressed: () {},
                            ),
                          )
                          .toList()
                    : storedPosts.items
                          .map(
                            (post) => CustomPostCard(
                              category: post.series?.name ?? '',
                              thumbnailUrl: post.imageUrl ?? '',
                              title: post.title ?? '',
                              excerpt: "${post.content?.substring(0, 50)}...",
                              author: post.author?.name ?? '',
                              onPressed: () {},
                            ),
                          )
                          .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
