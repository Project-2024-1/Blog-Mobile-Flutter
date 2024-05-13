import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tudotaichinh/model/ListPostModel.dart';
import 'package:tudotaichinh/page/category/widget/widget_post_item.dart';

import '../../common/setting_view.dart';
import '../../common/snack_bar_helper/snack_bar_helper.dart';
import '../../model/ListCategoryModel.dart';
import '../../service/apis/list_post_api.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late ScrollController _scrollController;
  final List<ListPostModel> _listCategorySite = [];
  final List<CategoriesModel> _listCategory = [];
  final String _error = "";
  bool _isLoading = false;
  int _page = 1;

  /// List of body icon
  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
    Icons.post_add,
    Icons.local_activity,
    Icons.settings,
    Icons.person
  ];
  int current = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    _fetchDataListCategory();
    // _fetchDataListPost();
    super.initState();
  }

  void _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (this._scrollController.position.pixels ==
        this._scrollController.position.maxScrollExtent) {
      print('load more $_page');
      this._fetchDataListPost(page: (this._page + 1));
    }
  }

  Future<void> _refreshListPost() async {
    this._fetchDataListPost(page: 1);
  }

  void _fetchDataListPost({int page = 1}) {
    if (!mounted) {
      return;
    }

    setState(() {
      this._isLoading = true;
    });

    getListPostApi(idCategory: '').then((value) {
      if (value != null) {
        _listCategorySite.addAll(value);
      }
    }).catchError((error, stackTrace) {
      print("getListCategorySiteApi failed $error $stackTrace");

      showSnackBarError(context, error?.message);
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          this._isLoading = false;
        });
      }
    });
  }

  void _fetchDataListCategory({int page = 1}) {
    if (!mounted) {
      return;
    }

    setState(() {
      this._isLoading = true;
    });

    getListCategoryApi().then((value) {
      if (value != null) {
        _listCategory.addAll(value);
      }
       _fetchDataListPost();

    }).catchError((error, stackTrace) {
      print("getListCategorySiteApi failed $error $stackTrace");

      showSnackBarError(context, error?.message);
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          this._isLoading = false;
        });
      }
    });
  }

  Widget _buildListCategory() {
    return Stack(
      children: [
        RefreshIndicator(
          // ignore: sort_child_properties_last
          child: Scrollbar(
            // isAlwaysShown: true,
            controller: _scrollController,
            child: GridView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: _listCategorySite.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var item = _listCategorySite[index];
                  return LazyLoadingList(
                      initialSizeOfItems: 10,
                      index: index,
                      hasMore: true,
                      loadMore: () => print('Loading More'),
                      child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, '/manual_detail_content_web_view',
                            //     arguments: {
                            //       "site_list_category": item.categoryItemModel
                            //     });
                          },
                          child: WidgetPostList(
                            postItem: item,
                          )));
                }),
          ),
          onRefresh: _refreshListPost,
        ),
      ],
    );
  }

  Widget _buildMainBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          /// Tab Bar
          SizedBox(
            width: double.infinity,
            height: height50(context),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _listCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final item = _listCategory[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                          pageController.animateToPage(
                            current,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 5,
                          height: height35(context),
                          decoration: BoxDecoration(
                            color: current == index ? Colors.white70 : Colors.white54,
                            borderRadius: current == index ? BorderRadius.circular(12) : BorderRadius.circular(7),
                            border: current == index ? Border.all(color: const Color(0xff95C1E7), width: 1) : null,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(
                                //   icons[index],
                                //   size: current == index ? 23 : 20,
                                //   color: current == index
                                //       ? Colors.black
                                //       : Colors.grey.shade400,
                                // ),
                                Text(
                                  item.categoryName ?? '',
                                  style: GoogleFonts.ubuntu(
                                    fontWeight: FontWeight.w500,
                                    color: current == index ? Colors.black : Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: current == index,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  );
                }),
          ),

          /// MAIN BODY
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: height10(context)),
              width: double.infinity,
              child: PageView.builder(
                itemCount: icons.length,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildListCategory();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Blog"),
      ),
      body: Container(
        child: LoadingOverlay(
            progressIndicator: LoadingAnimationWidget.threeArchedCircle(
                color: Theme.of(context).primaryColor, size: 50.0),
            isLoading: _isLoading,
            child: _buildMainBody()),
      ),
    );
  }
}
