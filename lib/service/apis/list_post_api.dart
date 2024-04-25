import 'package:tudotaichinh/service/apis/base_api.dart';

import '../../common/exception/ApiException.dart';
import '../../model/ListPostModel.dart';

Future<List<ListPostModel>?> getListPostApi() async {
  const path = '/api/post';
 
  final data = await baseGetNewApi(path);
  // List<dynamic> jsonGetMessage = data['data'];

  List<ListPostModel> listPosts= [];

  try {
    for (var jsonListPostChild in data['posts']) {
      final listPostItem = ListPostModel.fromJson(jsonListPostChild);
      listPosts.add(listPostItem);
    }
    return listPosts;
  } catch (error) {
    print("error $error");
    throw ApiException(error.toString());
  }
}