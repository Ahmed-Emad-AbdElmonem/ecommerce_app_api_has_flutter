class CategoryModel {
  int? id;
  String? imgUrl;
 String? title;
  CategoryModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    imgUrl = data['image'];
    title = data['name'];
  }
}
