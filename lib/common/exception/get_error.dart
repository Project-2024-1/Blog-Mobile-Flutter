String getErrorMsg(Object? e) {
  String msg = "";
  try {
    msg = (e as dynamic).message;
  } on NoSuchMethodError {
    msg = e.toString();
  }
  return msg;
}