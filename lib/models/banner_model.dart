class BannerModel {
  int? id;
  String? imgUrl;

  BannerModel.fromJson({required Map<String, dynamic> data}) {
    id = data['id'];
    imgUrl = data['image'];
  }
}
