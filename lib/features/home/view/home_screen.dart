import 'dart:convert';

import '../../../core/components/custom_text.dart';
import '../../../core/components/custom_text_button.dart';
import '../../auth/view/login_screen.dart';
import '../../auth/view/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/components/custom_post_shimmer_card.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/networking/blog_api.dart';
import '../../blog/model/category.dart';
import '../../blog/model/post.dart';
import '../../blog/view/view_post_screen.dart';
import '../../blog/viewmodel/categories_provider.dart';
import '../../blog/viewmodel/posts_provider.dart';
import 'components/custom_post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isFeaturedSelected = true;
  bool _isPopularSelected = false;
  bool _isRecentSelected = false;
  bool _isBusinessSelected = false;
  List<PostModel> _loadedPosts = [];

  @override
  Widget build(BuildContext context) {
    final storedPosts = context.watch<Posts>().items;
    return Scaffold(
      appBar: AppBar(
        // elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: SvgPicture.asset("assets/svg/breach-logo.svg"),
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.0),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          IconButton(
            onPressed: () => context.push(LoginScreen.id),
            icon: Icon(Icons.person_2_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator.adaptive(
          onRefresh: () async => _refreshPage(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Color(0XFFf9ebf5).withOpacity(0.8),
                child: Column(
                  children: [
                    Image.asset("assets/images/Mascot_hero_anim.png"),
                    SizedBox(height: kDefaultSize),
                    Text.rich(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0XFF181818),
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                      TextSpan(
                        children: [
                          TextSpan(text: "Find "),
                          TextSpan(
                            text: "Great ",
                            style: TextStyle(color: kSecondaryColour),
                          ),
                          TextSpan(text: "Ideas"),
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultSize / 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: CustomText(
                        text:
                            "Subscribe to your favourite creators and thinkers. Support work that matters",
                        textSize: 14,
                        alignText: TextAlign.center,
                        textColor: Color(0XFF181818),
                      ),
                    ),
                    SizedBox(height: kDefaultSize),
                    CustomTextButton(
                      backgroundColour: kPrimaryColour,
                      textColour: Colors.white,
                      text: "Join Breach",
                      borderColour: Colors.transparent,
                      onPressed: () => context.push(SignupScreen.id),
                    ),
                    SizedBox(height: kDefaultSize),
                  ],
                ),
              ),
              Padding(
                padding: kAppBorderPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextButton(
                            backgroundColour: _isFeaturedSelected
                                ? kPrimaryColour
                                : Colors.transparent,
                            textColour: _isFeaturedSelected
                                ? Colors.white
                                : kPrimaryColour,
                            text: "Featured",
                            borderColour: _isFeaturedSelected
                                ? Colors.transparent
                                : kPrimaryColour,
                            onPressed: () {
                              setState(() {
                                _isFeaturedSelected = true;
                                _isPopularSelected = false;
                                _isRecentSelected = false;
                                _isBusinessSelected = false;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          CustomTextButton(
                            backgroundColour: _isPopularSelected
                                ? kPrimaryColour
                                : Colors.transparent,
                            textColour: _isPopularSelected
                                ? Colors.white
                                : kPrimaryColour,
                            text: "Popular",
                            borderColour: _isPopularSelected
                                ? Colors.transparent
                                : kPrimaryColour,
                            onPressed: () {
                              setState(() {
                                _isFeaturedSelected = false;
                                _isPopularSelected = true;
                                _isRecentSelected = false;
                                _isBusinessSelected = false;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          CustomTextButton(
                            backgroundColour: _isRecentSelected
                                ? kPrimaryColour
                                : Colors.transparent,
                            textColour: _isRecentSelected
                                ? Colors.white
                                : kPrimaryColour,
                            text: "Recent",
                            borderColour: _isRecentSelected
                                ? Colors.transparent
                                : kPrimaryColour,
                            onPressed: () {
                              setState(() {
                                _isFeaturedSelected = false;
                                _isPopularSelected = false;
                                _isRecentSelected = true;
                                _isBusinessSelected = false;
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          CustomTextButton(
                            backgroundColour: _isBusinessSelected
                                ? kPrimaryColour
                                : Colors.transparent,
                            textColour: _isBusinessSelected
                                ? Colors.white
                                : kPrimaryColour,
                            text: "Business",
                            borderColour: _isBusinessSelected
                                ? Colors.transparent
                                : kPrimaryColour,
                            onPressed: () {
                              setState(() {
                                _isFeaturedSelected = false;
                                _isPopularSelected = false;
                                _isRecentSelected = false;
                                _isBusinessSelected = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultSize - 5,
                      ),
                      child: Divider(height: 1),
                    ),
                    storedPosts.isNotEmpty
                        ? Column(
                            children: storedPosts
                                .map(
                                  (post) => CustomPostCard(
                                    category: post.series?.name ?? '',
                                    thumbnailUrl: post.imageUrl ?? '',
                                    title: post.title ?? '',
                                    excerpt:
                                        "${post.content?.substring(0, 50)}...",
                                    author: post.author?.name ?? '',
                                    onPressed: () => context.push(
                                      ViewPostScreen.id,
                                      extra: post.id,
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : _loadedPosts.isNotEmpty
                        ? Column(
                            children: _loadedPosts
                                .map(
                                  (post) => CustomPostCard(
                                    category: post.series?.name ?? '',
                                    thumbnailUrl: post.imageUrl ?? '',
                                    title: post.title ?? '',
                                    excerpt:
                                        "${post.content?.substring(0, 50)}...",
                                    author: post.author?.name ?? '',
                                    onPressed: () {},
                                  ),
                                )
                                .toList(),
                          )
                        : Column(
                            children: [
                              CustomPostShimmerCard(),
                              CustomPostShimmerCard(),
                              CustomPostShimmerCard(),
                              CustomPostShimmerCard(),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _getPosts(context);
    _getAllCategories(context);
    super.initState();
  }

  Future<void> _refreshPage(BuildContext context) async {
    // final [products, categories, notifications] =
    await Future.wait([_getPosts(context), _getAllCategories(context)]);
  }

  Future<void> _getPosts(BuildContext context, {String? categoryId}) async {
    final res = await BlogApi.getPosts(categoryId: categoryId);
    try {
      if (res.statusCode == 200 || res.statusCode == 201) {
        final getPostsResponse = jsonDecode(res.body);
        final fetchedPosts = getPostsResponse
            .map<PostModel>(PostModel.fromJson)
            .toList();
        setState(() {
          context.read<Posts>().clearItems();
          _loadedPosts = fetchedPosts;
          context.read<Posts>().setItems = fetchedPosts;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> _getAllCategories(BuildContext context) async {
    final res = await BlogApi.getCategories();
    if (res.statusCode == 200 || res.statusCode == 201) {
      final getCategoriesResponse = jsonDecode(res.body);
      final fetchedCategories = getCategoriesResponse
          .map<CategoryModel>(CategoryModel.fromJson)
          .toList();
      setState(() {
        context.read<Categories>().setItems = fetchedCategories;
      });
    }
  }
}
