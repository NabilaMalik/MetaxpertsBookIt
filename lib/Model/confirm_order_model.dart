class ConfirmOrderModel{

  int? id;
  String? shopName;
  String? ownerName;
  String? phoneNumber;
  String? brand;
  int? total;
  String? credit;
  String? requireDelivery;

  ConfirmOrderModel({
    this.id,
    this.shopName,
    this.ownerName,
    this.phoneNumber,
    this.brand,
    this.total,
    this.credit,
    this.requireDelivery,

  });

  factory ConfirmOrderModel.fromMap(Map<dynamic,dynamic> json){
    return ConfirmOrderModel(
      id: json['id'],
      shopName: json['shopName'],
      ownerName: json['ownerName'],
      phoneNumber: json['phoneNumber'],
      brand:json['brand'],
      total:json['total'],
      credit:json['credit'],
      requireDelivery:json['requireDelivery'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'shopName':shopName,
      'ownerName':ownerName,
      'phoneNumber':phoneNumber,
      'brand':brand,
      'total':total,
      'credit':credit,
      'requireDelivery':requireDelivery,
    };
  }

}
