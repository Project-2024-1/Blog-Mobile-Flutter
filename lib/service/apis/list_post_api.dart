import 'package:tudotaichinh/service/apis/base_api.dart';

import '../../common/exception/ApiException.dart';
import '../../model/ListCategoryModel.dart';
import '../../model/ListPostModel.dart';

Future<List<CategoriesModel>?> getListCategoryApi() async {
  const path = '/api/category';
 
  final data = await baseGetNewApi(path);
  // List<dynamic> jsonGetMessage = data['data'];

  List<CategoriesModel> listCategorys= [];

  try {
    for (var jsonListCategoryChild in data['categories']) {
      final listCategorysItem = CategoriesModel.fromJson(jsonListCategoryChild);
      listCategorys.add(listCategorysItem);
    }
    return listCategorys;
  } catch (error) {
    print("error $error");
    throw ApiException(error.toString());
  }
}

Future<List<ListPostModel>?> getListPostApi({required String idCategory}) async {
  const path = '/api/post';

 
  final data = await baseGetNewApi(path);
  // List<dynamic> jsonGetMessage = data['data'];

  List<ListPostModel> listCategorys= [];

  try {
    for (var jsonListCategoryChild in data['posts']) {
      final listCategorysItem = ListPostModel.fromJson(jsonListCategoryChild);
      listCategorys.add(listCategorysItem);
    }
    return listCategorys;
  } catch (error) {
    print("error $error");
    throw ApiException(error.toString());
  }
}

