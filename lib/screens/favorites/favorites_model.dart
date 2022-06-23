
class FavoritesModel {
  bool? status;
  String? message;
  FavDataModel? data;
  FavoritesModel.fromJson(Map<String,dynamic>json) {
    status=json['status'];
    message=json['message'];
    data=FavDataModel.fromJson(json['data']);
  }
}
class FavDataModel{
  int? currentPage;
  List<DataItem>? data=[];
  FavDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data?.add(DataItem.fromJson(element));
    });
  }
}

class DataItem{
  int? id;
  Product? product;
  DataItem.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product{
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  Product.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
//////////
// class FavoritesModel {
//   bool? status;
//   String? message;
//   DataModel? data;
//
//   FavoritesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
//   }
// }
// class DataModel {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//
//   DataModel.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add( Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//
// }
// class Data {
//   int? id;
//   List<Product> product=[];
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     json['product'].forEach((e){
//       product.add(Product.fromJson(e));
//     });
//   }
//
// }
// class Product {
//   int? id;
//   int? price;
//   int? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
//
// }