
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants/storage_keys.dart';

Future<String> loadAccessToken() async {
  final refs = await SharedPreferences.getInstance();
  if (!refs.containsKey(KEY_ACCESS_TOKEN)) {
    throw Exception("User not login && access_token not set ");
  }
  return refs.getString(KEY_ACCESS_TOKEN)!;
}