class KeywordLocal {
  final int id;
  final int quantityProduct;
  final int quantityProductCheckShowMaker;
  final int isEnabledKeyword; // 0 -> false, 1-> true

  KeywordLocal({required this.id, required this.quantityProduct, required this.quantityProductCheckShowMaker, required this.isEnabledKeyword});

  KeywordLocal.fromMapAll(Map<String, dynamic> item):
      id = item["id"],
      quantityProduct = item["quantityProduct"],
      quantityProductCheckShowMaker = item["quantityProductCheckShowMaker"],
      isEnabledKeyword = item["isEnabledKeyword"]
  ;


  Map<String, Object> toMapAll(){
    return {
      'id':id,
      'quantityProduct': quantityProduct,
      'quantityProductCheckShowMaker': quantityProductCheckShowMaker,
      'isEnabledKeyword': isEnabledKeyword
    };
  }
}