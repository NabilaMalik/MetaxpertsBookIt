class ShopVisitModel{

  int? id;
  String? brand;
  String? shopName;
  String? shopAddress;
  String? ShopOwner;
  String? bookerName;
  String? photoPath;
  String? feedback;
  int? shopId;

  ShopVisitModel({
    this.id,
    this.brand,
    this.shopName,
    this.shopAddress,
    this.ShopOwner,
    this.bookerName,
    this.photoPath,
    this.feedback,
    this.shopId,
  });


  factory ShopVisitModel.fromMap(Map<dynamic,dynamic> json){
    return ShopVisitModel(
        id: json['id'],
        brand: json['brand'],
        shopName: json['shopName'],
        shopAddress: json['shopAddress'],
        ShopOwner: json['ShopOwner'],
        bookerName: json['bookerName'],
        photoPath: json['photoPath'],
        feedback: json['feedback'],
        shopId: json['shopId']
    );
  }

  Map<String, dynamic> toMap(){
    return{

      'id':id,
      'brand':brand,
      'shopName':shopName,
      'shopAddress':shopAddress,
      'ShopOwner':ShopOwner,
      'bookerName':bookerName,
      'photoPath':photoPath,
      'feedback':feedback,
      'shopId':shopId,
    };
  }
}
