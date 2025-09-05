import 'dart:convert';

import '../../../core/components/custom_text.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extentions/string_extension.dart';
import '../../../core/services/secure_storage/secure_storage.dart';
import '../../home/view/home_screen.dart';
import '../../interests/view/interests_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/components/custom_text_button_with_icon.dart';
import '../../../core/services/networking/blog_api.dart';
import '../../../core/services/networking/user_api.dart';
import '../../blog/model/category.dart';
import '../../blog/model/post.dart';
import '../../blog/view/view_post_screen.dart';
import '../../blog/viewmodel/categories_provider.dart';
import '../../blog/viewmodel/posts_provider.dart';
import '../../home/view/components/custom_post_card.dart';
import '../../home/view/components/custom_stream_card.dart';
import '../../interests/model/interest.dart';
import '../../interests/viewmodel/interests_provider.dart';
import 'interested_posts_screen.dart';
import 'stream_posts_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String id = "/dashboard_screen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedInterestId = 0;
  late WebSocketChannel _channel;
  late Stream _broadcastStream = Stream.empty();
  final List<PostModel> _allStreamPosts = [];

  void _initSocket() async {
    final userToken = await SecureStorage.readUserToken();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://breach-api-ws.qa.mvm-tech.xyz?token=$userToken'),
    );
    _broadcastStream = _channel.stream.asBroadcastStream();
  }

  @override
  void initState() {
    _initSocket();
    _getUserInterests(context);
    _getPosts(context);
    _getAllCategories(context);
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final interests = context.watch<Interests>().items;
    final storedPosts = context.watch<Posts>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 1,
        leading: DrawerButton(),
        title: SvgPicture.asset("assets/svg/breach-logo.svg"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: kPrimaryColour),
              child: SvgPicture.asset(
                "assets/svg/breach-logo.svg",
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                context.go(HomeScreen.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.interests_outlined),
              title: Text('Interests'),
              onTap: () {
                Navigator.pop(context);
                context.push(InterestsScreen.id);
              },
            ),

            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ElevatedButton.icon(
                icon: Icon(Icons.edit_outlined),
                label: Text('Start writing'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColour,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/write');
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: kAppBorderPadding,
        child: SingleChildScrollView(
          child: RefreshIndicator.adaptive(
            onRefresh: () async => _refreshPage(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: size.height * 0.58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Top Picks",
                            textSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () => context.push(InterestedPostsScreen.id),
                            child: CustomText(
                              text: "View All",
                              textSize: 14,
                              textColor: kGreyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultSize / 2),
                      CustomText(
                        text: "Experience the best of Breach",
                        textSize: 14,
                        textColor: kGreyTextColour,
                      ),
                      if (interests.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: interests
                                .map(
                                  (interest) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: CustomTextButtonWithIcon(
                                      label: interest.category?.name ?? '',
                                      buttonBackgroundColour:
                                          _selectedInterestId ==
                                              interest.category?.id
                                          ? kPrimaryColour
                                          : Colors.transparent,
                                      buttonForegroundColour:
                                          _selectedInterestId ==
                                              interest.category?.id
                                          ? Colors.white
                                          : Color(0XFF181818),
                                      textColour:
                                          _selectedInterestId ==
                                              interest.category?.id
                                          ? Colors.white
                                          : Color(0XFF181818),
                                      borderColour:
                                          _selectedInterestId ==
                                              interest.category?.id
                                          ? Colors.transparent
                                          : Color(0XFFC7C4BC),
                                      buttonIcon: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
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
                                          _selectedInterestId =
                                              interest.category!.id!;
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
                                    .filteredItems(
                                      categoryId: _selectedInterestId,
                                    )
                                    .isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          storedPosts
                                                  .filteredItems(
                                                    categoryId:
                                                        _selectedInterestId,
                                                  )
                                                  .length >
                                              5
                                          ? 5
                                          : storedPosts
                                                .filteredItems(
                                                  categoryId:
                                                      _selectedInterestId,
                                                )
                                                .length,
                                      itemBuilder: (context, index) =>
                                          CustomPostCard(
                                            category:
                                                storedPosts
                                                    .filteredItems(
                                                      categoryId:
                                                          _selectedInterestId,
                                                    )[index]
                                                    .series
                                                    ?.name ??
                                                '',
                                            thumbnailUrl:
                                                storedPosts
                                                    .filteredItems(
                                                      categoryId:
                                                          _selectedInterestId,
                                                    )[index]
                                                    .imageUrl ??
                                                '',
                                            title:
                                                storedPosts
                                                    .filteredItems(
                                                      categoryId:
                                                          _selectedInterestId,
                                                    )[index]
                                                    .title ??
                                                '',
                                            excerpt:
                                                "${storedPosts.filteredItems(categoryId: _selectedInterestId)[index].content?.substring(0, 50)}...",
                                            author:
                                                storedPosts
                                                    .filteredItems(
                                                      categoryId:
                                                          _selectedInterestId,
                                                    )[index]
                                                    .author
                                                    ?.name ??
                                                '',
                                            onPressed: () => context.push(
                                              ViewPostScreen.id,
                                              extra: storedPosts
                                                  .filteredItems(
                                                    categoryId:
                                                        _selectedInterestId,
                                                  )[index]
                                                  .id,
                                            ),
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
                                itemCount: storedPosts.items.length > 5
                                    ? 5
                                    : storedPosts.items.length,
                                itemBuilder: (context, index) => CustomPostCard(
                                  category:
                                      storedPosts.items[index].series?.name ??
                                      '',
                                  thumbnailUrl:
                                      storedPosts.items[index].imageUrl ?? '',
                                  title: storedPosts.items[index].title ?? '',
                                  excerpt:
                                      "${storedPosts.items[index].content?.substring(0, 50)}...",
                                  author:
                                      storedPosts.items[index].author?.name ??
                                      '',
                                  onPressed: () => context.push(
                                    ViewPostScreen.id,
                                    extra: storedPosts.items[index].id,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultSize),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Streams",
                            textSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () => context.push(
                              StreamPostsScreen.id,
                              extra: _allStreamPosts,
                            ),
                            child: CustomText(
                              text: "View All",
                              textSize: 14,
                              textColor: kGreyTextColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultSize / 2),
                      CustomText(
                        text:
                            "Discover trending content from topics you care about in real time",
                        textSize: 14,
                        textColor: kGreyTextColour,
                      ),
                      SizedBox(height: kDefaultSize / 10),
                      Card(
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: kGreyTextColour.withOpacity(0.5),
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: StreamBuilder(
                            stream: _broadcastStream.map<List<PostModel>>((
                              event,
                            ) {
                              final data = jsonDecode(event);
                              if (data is List) {
                                return data
                                    .map<PostModel>(
                                      (json) => PostModel.fromJson(json),
                                    )
                                    .toList();
                              } else if (data is Map) {
                                return [PostModel.fromJson(data)];
                              }
                              return <PostModel>[];
                            }),
                            builder: (context, snapshot) {
                              // if (snapshot.connectionState ==
                              //     ConnectionState.waiting) {
                              //   return const Center(
                              //     child: CircularProgressIndicator(),
                              //   );
                              // } else
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Error: ${snapshot.error}"),
                                );
                              } else if (snapshot.hasData) {
                                _allStreamPosts.insert(0, snapshot.data![0]);
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _allStreamPosts.length > 5
                                      ? 5
                                      : _allStreamPosts.length,
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemBuilder: (context, index) {
                                    final post = _allStreamPosts[index];
                                    return CustomStreamCard(
                                      title:
                                          post.title?.capitalizeFirstofEach ??
                                          '',
                                      excerpt:
                                          "${post.content?.substring(0, 50) ?? ''}...",
                                      author: post.author?.name ?? '',
                                      date: post.createdAt != null
                                          ? DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(post.createdAt!),
                                            )
                                          : '',
                                      onPressed: () {},
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text("No data yet..."),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultSize * 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshPage(BuildContext context) async {
    // final [products, categories, notifications] =
    await Future.wait([
      _getPosts(context),
      _getAllCategories(context),
      _getUserInterests(context),
    ]);
  }

  Future<void> _getUserInterests(BuildContext context) async {
    final userToken = await SecureStorage.readUserToken();
    final userId = await SecureStorage.readUserId();
    final res = await UserApi.getUserInterests(
      userToken: userToken!,
      userId: userId!,
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final getInterestsResponse = jsonDecode(res.body);
      final fetchedInterests = getInterestsResponse
          .map<InterestModel>(InterestModel.fromJson)
          .toList();
      setState(() {
        context.read<Interests>().setItems = fetchedInterests;
        if (fetchedInterests.isNotEmpty) {
          _selectedInterestId = fetchedInterests.first.category.id!;
        }
      });
    }
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

  void _logout(BuildContext context) {
    SecureStorage.deleteUserToken();
    SecureStorage.deleteUserId();
    context.go(HomeScreen.id);
  }
}
