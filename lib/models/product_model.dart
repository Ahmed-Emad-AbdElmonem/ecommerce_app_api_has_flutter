
class ProductModel {

  String? name;
  String? description;
  String? image;
  int? price;
  int? oldPrice;
  int? id;
  int? discount;


 ProductModel.fromJson({required Map<String,dynamic> data}){
  id=data['id'].toInt();
  name=data['name'].toString();
  image=data['image'].toString();
  description=data['description'];
  price=data['price'].toInt();
  oldPrice=data['old_price'].toInt();
  discount=data['discount'].toInt();

 }

  
}