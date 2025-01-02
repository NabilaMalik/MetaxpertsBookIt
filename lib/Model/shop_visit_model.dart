class ShopVisitModel{

  int? id;
  String? brand;
  String? shopName;
  String? shopAddress;
  String? shopOwner;
  String? bookerName;
  String? addPhoto;
  String? feedback;

  ShopVisitModel({
    this.id,
    this.brand,
    this.shopName,
    this.shopAddress,
    this.shopOwner,
    this.bookerName,
    this.addPhoto,
    this.feedback,
  });


  factory ShopVisitModel.fromMap(Map<dynamic,dynamic> json){
    return ShopVisitModel(
        id: json['id'],
        brand: json['brand'],
        shopName: json['shopName'],
        shopAddress: json['shopAddress'],
        shopOwner: json['ShopOwner'],
        bookerName: json['bookerName'],
        addPhoto: json['addPhoto'],
        feedback: json['feedback'],

    );
  }

  Map<String, dynamic> toMap(){
    return{

      'id':id,
      'brand':brand,
      'shopName':shopName,
      'shopAddress':shopAddress,
      'ShopOwner':shopOwner,
      'bookerName':bookerName,
      'addPhoto':addPhoto,
      'feedback':feedback,
    };
  }
}
