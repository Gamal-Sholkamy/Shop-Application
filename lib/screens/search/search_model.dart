
class SearchModel{
  bool? status;
  String?message;
  SearchData?data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=SearchData.fromJson(json['data']);
  }
}
class SearchData{
  int? currentPage;
  List<SearchDataItem> data=[];

  SearchData.fromJson(Map<String ,dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      data.add(SearchDataItem.fromJson(element));
    });

  }

}
class SearchDataItem{
  int ? id;
  double? price;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  SearchDataItem.fromJson(Map<String ,dynamic> json){
   id=json['id'] ;
   price=json['price'] ;
   image=json['image'] ;
   name=json['name'] ;
   description=json['description'] ;
   inFavorites=json['inFavorites'] ;
   inCart=json['inCart'] ;
  }

}
////
// class SearchModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//
//   SearchModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//
// }
//
// class Data {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;
//
//
//   Data.fromJson(Map<String, dynamic> json) {
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
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   double? price;
//   String? image;
//   String? name;
//   String? description;
//   bool? inFavorites;
//   bool? inCart;
//
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
//
//
// }