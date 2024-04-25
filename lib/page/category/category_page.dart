import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tudotaichinh/model/ListPostModel.dart';
import 'package:tudotaichinh/page/category/widget/widget_post_item.dart';

import '../../common/snack_bar_helper/snack_bar_helper.dart';
import '../../service/apis/list_post_api.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late ScrollController _scrollController;
  final List<ListPostModel> _listCategorySite = [];
  final String _error = "";
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    _fetchDataListPost();
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

    getListPostApi().then((value) {
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
                    crossAxisCount: 2, childAspectRatio: 16 / 9),
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
                          child: Container(
                              child: WidgetPostList(
                            postItem: item,
                          ))));
                }),
          ),
          onRefresh: _refreshListPost,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Container(
        child: LoadingOverlay(
            progressIndicator: LoadingAnimationWidget.threeArchedCircle(
                color: Theme.of(context).primaryColor, size: 50.0),
            isLoading: _isLoading,
            child: _buildListCategory()),
      ),
    );
  }
}
